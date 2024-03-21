import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as imglib;
import 'package:image_picker/image_picker.dart';

import 'ar.dart';
import 'glass_data.dart';

var cameras;
late Uint8List imageBytes;

final _orientations = {
  DeviceOrientation.portraitUp: 0,
  DeviceOrientation.landscapeLeft: 90,
  DeviceOrientation.portraitDown: 180,
  DeviceOrientation.landscapeRight: 270,
};

Map<String, imglib.Image> images = {};
// {'assets/glasses0.png' : true},
// {'assets/glasses1.png' : true},
// {'assets/glasses2.png' : true},
// {'assets/glasses3.png' : true},

/// CameraApp is the Main Application.
class CameraScreen extends StatefulWidget {
  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? controller;
  late CameraImage frame;
  imglib.Image? image;
  bool isConverting = false;
  int selectedGlassIndex = 0;
  GlassData? glassData;
  int camIndex = 1;

  List<Map<String, dynamic>> glasses = [
    {'path': 'assets/virtual_tryon/glasses0.png', 'is_asset': true},
    {'path': 'assets/virtual_tryon/glasses1.png', 'is_asset': true},
    {'path': 'assets/virtual_tryon/glasses2.png', 'is_asset': true},
    {'path': 'assets/virtual_tryon/glasses3.png', 'is_asset': true},
  ];

  Future<void> importNewGlass() async {
    var newGlass = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (newGlass == null) return;
    setState(() {
      glasses.add({'path': newGlass.path, 'is_asset': false});
      selectedGlassIndex = glasses.length - 1;
    });
  }

  Future<void> loadBytes() async {
    debugPrint("Loading asset image bytes");
    for (var glass in glasses) {
      ByteData assetByteData = await rootBundle.load(glass['path']);
      Uint8List bytes = assetByteData.buffer.asUint8List();
      if (bytes.isEmpty) {
        debugPrint("Could not load: ${glass['path']}");
      }
      images.addAll({glass['path']: imglib.decodeImage(bytes)!});
    }
    debugPrint("Finished loading asset image bytes");
  }

  void initialize() {
    try {
      controller =
          CameraController(cameras![camIndex], ResolutionPreset.medium);
    } catch (e) {
      return;
    }

    controller?.initialize().then((_) {
      controller!.setExposureMode(ExposureMode.auto);
      controller!.setFocusMode(FocusMode.auto);
      // controller!.setFlashMode(FlashMode.torch);
      debugPrint("Started image Stream");
      controller!.startImageStream((imgFrame) async {
        if (isConverting == false) {
          frame = imgFrame;
          isConverting = true;
          var rotationCompensation =
              _orientations[controller!.value.deviceOrientation];
          var incGlassData = await AR().getGlassData(
              frame: frame,
              camera: cameras[camIndex],
              rotationCompensation: rotationCompensation);
          setState(() {
            glassData = incGlassData;
          });
          isConverting = false;
        }
      });

      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    super.initState();

    Future(() async {
      await loadBytes();
      cameras = await availableCameras();
      initialize();
    });
  }

  @override
  void dispose() {
    try {
      controller!.stopImageStream();
    } catch (e) {
      debugPrint("$e");
    }
    controller?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {}
  }

  List<Widget> facePoints(double displayWidth, double displayHeight) {
    if (glassData == null) return [Container()];
    return List.generate(
        glassData!.allPoints.length,
        (idx) => Positioned(
              right: displayWidth * 1.25 * (glassData!.allPoints[idx].x) + 10,
              top: displayHeight * 0.82 * (glassData!.allPoints[idx].y) - 50,
              child: Icon(Icons.circle, color: Colors.green, size: 5),
            ));
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller!.value.isInitialized) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    // controller!.setZoomLevel(1.6);
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          body: LayoutBuilder(builder: (context, constraints) {
            double displayWidth = constraints.maxWidth;
            double displayHeight = constraints.maxHeight;
            return Stack(
              children: [
                Container(
                    width: displayWidth,
                    height: displayHeight,
                    child: CameraPreview(controller!)),
                displayGlass(
                    glassData: glassData,
                    screenSize: Size(displayWidth, displayHeight),
                    glassPath: glasses[selectedGlassIndex]['path'],
                    isAsset: glasses[selectedGlassIndex]['is_asset']),
                Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Container(
                                  color: Colors.blue.withOpacity(.8),
                                  child: Row(
                                    children: List.generate(
                                        glasses.length,
                                        (index) => GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                selectedGlassIndex = index;
                                              });
                                            },
                                            onLongPress: () {
                                              glasses.removeAt(index);
                                              setState(() {});
                                            },
                                            child: EyeGlassTile(
                                              color: selectedGlassIndex == index
                                                  ? Colors.red.withOpacity(0.5)
                                                  : null,
                                              isAsset: glasses[index]
                                                  ['is_asset'],
                                              glassPath: glasses[index]['path'],
                                            ))),
                                  ),
                                )),
                          ),
                          IconButton(
                            icon: Icon(Icons.add_circle,
                                color: Colors.green, size: 40),
                            onPressed: () {
                              importNewGlass();
                            },
                          )
                        ],
                      ),
                    )),
                Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(Icons.switch_camera_outlined,
                                color: Colors.white, size: 40),
                            onPressed: () async {
                              try {
                                await controller!.stopImageStream();
                                await controller!.dispose();
                                camIndex = camIndex == 0 ? 1 : 0;
                                initialize();
                              } catch (e) {
                                debugPrint("Unable to change camera");
                                debugPrint("$e");
                              }
                            },
                          ),
                        ],
                      ),
                    )),
                // Positioned(
                //         left: displayWidth / 2,
                //         bottom: displayHeight / 2,
                //         child: Icon(Icons.circle, color: Colors.green),)
                // ...facePoints(displayWidth, displayHeight)
              ],
            );
          }),
        ),
      ),
    );
  }
}

Widget displayGlass(
    {required GlassData? glassData,
    required String glassPath,
    required bool isAsset,
    required Size screenSize}) {
  if (glassData == null) {
    return Container();
    if (isAsset == true) {
      // debugPrint('converting asset image into bytes');
      // imglib.Image? image = images[glassPath];
      // Convert the rotated image to a Uint8List
      // imageBytes = Uint8List.fromList(imglib.encodePng(image!));
      // return Image.memory(imageBytes);
      return Image.asset(glassPath);
    } else {
      return Image.file(File(glassPath));
    }
  } else {
    //todo: Apply glassData transforms on the glass and return the glass
    double glassLength = screenSize.width * 1.4 * glassData!.relGlassLength;
    double containerHeight = 100.0;
    // double glassHeight = screenSize.height * * (gl);
    // double right = screenSize.width * 1.25 * (glassData!.leftEarX) + 10;
    // double top = screenSize.height * 0.82 * (glassData!.rightEarY) - 50;

    // debugPrint("Offset horizontal: ${10 / screenSize.width}");
    // debugPrint("offset vertical: ${50 / screenSize.height}");
    double right = screenSize.width * (1.25 * (glassData!.centerX) + 0.0278) -
        (glassLength / 2);
    double top = screenSize.height * (0.82 * (glassData!.centerY) - 0.0693) -
        (containerHeight / 2);
    // Load your image
    imglib.Image? image;
    if (isAsset == true) {
      image = images[glassPath];
    } else {
      image = imglib.decodeImage(File(glassPath).readAsBytesSync());
    }

    ///rotate the image here
    // Convert the rotated image to a Uint8List
    // imageBytes = Uint8List.fromList(imglib.encodePng(image!));
    // debugPrint("***Angle of rotation: ${glassData!.angleOfRotation}***");
    if (isAsset == true) {
      return Positioned(
        right: right,
        top: top,
        child: Container(
          height: containerHeight,
          width: glassLength,
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          child: Transform.rotate(
            angle: glassData!.angleOfRotation,
            child: Image.asset(glassPath),
          ),
        ),
      );
    } else {
      return Positioned(
        right: right,
        top: top,
        child: Container(
          height: containerHeight,
          width: glassLength,
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          child: Transform.rotate(
            angle: glassData!.angleOfRotation,
            child: Image.file(File(
                glassPath)), //Image.memory(imglib.encodePng(image!), width: glassLength,),
          ),
        ),
      );
      // return Positioned(
      //     child: Image.memory(imglib.encodePng(image!), width: glassLength,),
      //     right: right,
      //     top: top);
    }
  }
}

class EyeGlassTile extends StatefulWidget {
  String glassPath;
  bool isAsset;
  Color? color;
  EyeGlassTile({required this.glassPath, required this.isAsset, this.color});

  @override
  State<EyeGlassTile> createState() => _EyeGlassTileState();
}

class _EyeGlassTileState extends State<EyeGlassTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(5.0),
        height: 70,
        width: 70,
        child: Center(
            child: widget.isAsset == true
                ? Image.asset(widget.glassPath)
                : Image.file(File(widget.glassPath))),
        decoration: BoxDecoration(
            color: widget.color ?? Colors.white,
            border: Border.all(color: Colors.red),
            borderRadius: BorderRadius.all(Radius.circular(35.0))),
      ),
    );
  }
}

imglib.Image? rotateGlass(imglib.Image src) {}
