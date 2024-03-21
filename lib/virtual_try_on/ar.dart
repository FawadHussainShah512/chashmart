import 'dart:async';
import 'dart:ffi';
import 'dart:math';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'dart:ui' as ui;
import 'dart:isolate';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:core';
import 'dart:typed_data';
import 'package:image/image.dart' as imglib;
import 'package:google_mlkit_face_mesh_detection/google_mlkit_face_mesh_detection.dart';

import 'glass_data.dart';





/// dart function for yuv to rgb conversion
Future<imglib.Image> _yuv2rgb(Map data) async{
  CameraImage cameraImage = data['frame'];
  int start = DateTime.now().microsecondsSinceEpoch;
  int width = cameraImage.width;
  int height = cameraImage.height;

  imglib.Image imgCamera = imglib.Image(width: width, height: height);
  imgColorBytes(imgCamera, cameraImage);
  int stop = DateTime.now().microsecondsSinceEpoch;
  imglib.Image rotatedImage = imglib.copyRotate(imgCamera, angle: 90);
  debugPrint("Image conversion took:  ${(stop - start)/1000} ms");
  return rotatedImage;

  // return await rotateImageBy90Degrees(imgCamera);
}

void imgColorBytes(imglib.Image imgCamera, CameraImage cameraImage) {
  try {
    final int width = cameraImage.width;
    final int height = cameraImage.height;
    final int uvRowStride = cameraImage.planes[1].bytesPerRow;
    final int uvPixelStride = cameraImage.planes[1].bytesPerPixel!;

    debugPrint("uvRowStride: " + uvRowStride.toString());
    debugPrint("uvPixelStride: " + uvPixelStride.toString());

    // imgLib -> Image package from https://pub.dartlang.org/packages/image
    for(int x=0; x < width; x++) {
      for(int y=0; y < height; y++) {
        final int uvIndex = uvPixelStride * (x/2).floor() + uvRowStride*(y/2).floor();
        final int index = y * width + x;

        final yp = cameraImage.planes[0].bytes[index];
        final up = cameraImage.planes[1].bytes[uvIndex];
        final vp = cameraImage.planes[2].bytes[uvIndex];
        // Calculate pixel color
        int r = (yp + vp * 1436 / 1024 - 179).round().clamp(0, 255);
        int g = (yp - up * 46549 / 131072 + 44 -vp * 93604 / 131072 + 91).round().clamp(0, 255);
        int b = (yp + up * 1814 / 1024 - 227).round().clamp(0, 255);

        // img.data!.buffer.asUint8List()[index] = shift | (b << 16) | (g << 8) | r;
        Color color = Color.fromARGB(255, r, g, b);
        imgCamera.setPixel(x, y, imglib.ColorRgb8(r,g,b));
      }
    }

  } catch (e) {
    debugPrint(">>>>>>>>>>>> ERROR:" + e.toString());
  }
}


/// face mesh detector
Future<dynamic> _faceMeshDetection(InputImage  inputImage ) async{
  debugPrint("Running face mesh algorithm");
  try {
    final meshDetector = FaceMeshDetector(option: FaceMeshDetectorOptions.faceMesh);
    final List<FaceMesh> meshes = await meshDetector.processImage(inputImage);
    List<FaceMeshPoint>? points;
    for (FaceMesh mesh in meshes) {
      final boundingBox = mesh.boundingBox;
      points = mesh.points;
      final triangles = mesh.triangles;
      final contour = mesh.contours[FaceMeshContourType.faceOval];
    }

    if(points == null) {
      debugPrint("No points found");
      return;
    }
    debugPrint("Found ${points.length} Points");
    debugPrint("[${List.generate(points.length, (index) => "(${points![index].x}, ${points[index].y})")}]");
    late FaceMeshPoint leftEarPoint;
    late FaceMeshPoint rightEarPoint;
    late FaceMeshPoint centerPoint;

    for(var point in points) {
      if(point.index == 162) leftEarPoint = point;
      else if(point.index == 389) rightEarPoint = point;
      else if (point.index == 197) centerPoint = point;
      else {
      }
    }

    double height = inputImage.metadata!.size.height;
    double width = inputImage.metadata!.size.width;

    return GlassData(
      leftEarX: leftEarPoint.x / width,
      rightEarX: rightEarPoint.x / width,
      leftEarY: leftEarPoint.y / height ,
      rightEarY: rightEarPoint.y / height,
      centerX: centerPoint.x / width,
      centerY: centerPoint.y / height,
      allPoints: List<Point>.generate(points.length, (index) => Point(points![index].x / width, points![index].y / height))
    );
  }catch(e) {
    debugPrint("$e");
    debugPrint("Face mesh detection failed");
  }

}

/// Add logic for other functions
/*
    <return type> _<process name>(<arguments>) async {
    //do stuff
    return <something>;
    }
 */



///Contains methods running on the other isolate
class OpencvIsolate {
  static late final DynamicLibrary omrLib;
  static late final ReceivePort openCVIsolateReceivePort;

  static void openCVIsolate(SendPort sendPort) {
    /// Load the omr dynamic libraries
    try {
      debugPrint(">>(Opencv Isolate) Trying to load the flutter opencv dynamic Library");
      // omrLib = Platform.isAndroid
      //     ? DynamicLibrary.open("libflutter_opencv.so")
      //     : DynamicLibrary.process();
      debugPrint(">>(Opencv Isolate) SUCCESSFULLY loaded the flutter opencv dynamic library");
    }catch (e) {
      debugPrint("$e");
      debugPrint(">>(Opencv Isolate) FAILED to load the flutter opencv dynamic library");
    }

    /// Create a receiver port for this isolate
    openCVIsolateReceivePort = ReceivePort();

    ///Send the corresponding send port back to the main isolate
    sendPort.send(openCVIsolateReceivePort.sendPort);

    openCVIsolateReceivePort.listen(
            (message) async{
          debugPrint("ISOLATE RECEIVED A MESSAGE");
          if(message is Map<String, dynamic>) { //i.e if
            if (message['process'] == 'YUV2RGB') {
              debugPrint("Isolate detected image conversion message");
              imglib.Image result = await _yuv2rgb(message);
              sendPort.send(result);
            }

            else if (message['process'] == 'FACE_MESH_DETECTION') {
              // var result = await _faceMeshDetection(message['image']);
              var result = null;
              sendPort.send(result);
            }

            ///Add and handle your own processes
            /*
            else if (message['process'] == '<PROCESS_NAME>') {
              <return type> result = await <process function>(message, omrLib);
              sendPort.send(result);
            }
            */
            else {

            }
          }
        });
  }
}

/// Contains methods running on the main isolate
class AR {
  static late final ReceivePort mainReceivePort;
  static late final SendPort mainSendPort;
  static late final Isolate? opencvIsolate;
  static StreamController<dynamic>? resultStreamController;

  Future<void> initialize() async {
    mainReceivePort = ReceivePort();

    /// Create opencv isolate
    opencvIsolate = await Isolate.spawn(OpencvIsolate.openCVIsolate , mainReceivePort.sendPort);
    /// Start Listing to the stream
    mainReceivePort.listen(
            (message) {
          debugPrint("Received a message from the opencv isolate. Content: ${message}");
          if(message is SendPort) {
            mainSendPort = message;
            debugPrint("(Opencv initialize) SUCCESSFULLY retrieved send port from opencv isolate");
          } else if (message is List<Map<String, dynamic>?>) {
            debugPrint("(Opencv initialize) SUCCESSFULLY retrieved a result from the opencv isolate");
            if(resultStreamController != null) {
              resultStreamController!.add(message);
            }
          }else {
            debugPrint("(Opencv initialize) SUCCESSFULLY retrieved a result from the opencv isolate");
            if(resultStreamController != null) {
              resultStreamController!.add(message);
            }
          }
        });

    debugPrint(">> Initializing the opencv library");
    debugPrint(">> Loading the dynamic libraries");
  }

  Future<imglib.Image?> yuv2rgb({required var frame}) async{
    debugPrint("Converting image in isolate");
    imglib.Image? result;
    try {
      resultStreamController = StreamController();
      mainSendPort.send({"frame": frame , 'process':'YUV2RGB'});
      debugPrint("Running stream");
      result = await resultStreamController!.stream.first;// as Future<List<Map<String, dynamic>?>>;
      debugPrint("Trying to close stream");
      resultStreamController!.close();
      resultStreamController = null;
    } catch(e) {
      debugPrint("$e");
      debugPrint("Failed to close the stream");
    }

    // debugPrint("(yuv2rgb) Returning $result from detectCorners");
    return result;
  }

  Future<dynamic> faceMeshDetection({required imglib.Image rgbImage}) async {
    debugPrint("Performing face mesh detection in isolate");
    imglib.Image? result;
    try {
      resultStreamController = StreamController();
      mainSendPort.send({"image": rgbImage , 'process':'FACE_MESH_DETECTION'});
      debugPrint("Running stream");
      result = await resultStreamController!.stream.first;// as Future<List<Map<String, dynamic>?>>;
      debugPrint("Trying to close stream");
      resultStreamController!.close();
      resultStreamController = null;
    } catch(e) {
      debugPrint("$e");
      debugPrint("Failed to close the stream");
    }

    // debugPrint("(yuv2rgb) Returning $result from detectCorners");
    return result;
  }

  Future<dynamic> getGlassData({required CameraImage frame, required var camera, required var rotationCompensation}) async {
    // var rgbImage = await yuv2rgb(frame: frame);
    var inputImage =  _inputImageFromCameraImage(image: frame, camera: camera, rotationCompensation: rotationCompensation);
    if(inputImage == null) {
      debugPrint("Failed to generate input image");
      return null;
    }
    var result = await _faceMeshDetection(inputImage);

    return result;
  }

}


InputImage? _inputImageFromCameraImage(
    {required CameraImage image, required var camera, required var rotationCompensation}) {
  // get image rotation
  // it is used in android to convert the InputImage from Dart to Java: https://github.com/flutter-ml/google_ml_kit_flutter/blob/master/packages/google_mlkit_commons/android/src/main/java/com/google_mlkit_commons/InputImageConverter.java
  // `rotation` is not used in iOS to convert the InputImage from Dart to Obj-C: https://github.com/flutter-ml/google_ml_kit_flutter/blob/master/packages/google_mlkit_commons/ios/Classes/MLKVisionImage%2BFlutterPlugin.m
  // in both platforms `rotation` and `camera.lensDirection` can be used to compensate `x` and `y` coordinates on a canvas: https://github.com/flutter-ml/google_ml_kit_flutter/blob/master/packages/example/lib/vision_detector_views/painters/coordinates_translator.dart
  final sensorOrientation = camera.sensorOrientation;
  // print(
  //     'lensDirection: ${camera.lensDirection}, sensorOrientation: $sensorOrientation, ${_controller?.value.deviceOrientation} ${_controller?.value.lockedCaptureOrientation} ${_controller?.value.isCaptureOrientationLocked}');
  InputImageRotation? rotation;
  if (Platform.isIOS) {
    rotation = InputImageRotationValue.fromRawValue(sensorOrientation);
  } else if (Platform.isAndroid) {

    if (rotationCompensation == null) {
      debugPrint("Rotation compensation is null");
      return null;
    }
    if (camera.lensDirection == CameraLensDirection.front) {
      // front-facing
      rotationCompensation = (sensorOrientation + rotationCompensation) % 360;
    } else {
      // back-facing
      rotationCompensation =
          (sensorOrientation - rotationCompensation + 360) % 360;
    }
    rotation = InputImageRotationValue.fromRawValue(rotationCompensation);
    // print('rotationCompensation: $rotationCompensation');
  }
  if (rotation == null) {
    debugPrint("Rotation is null");
    return null;
  }
  // print('final rotation: $rotation');

  // get image format
  final format = InputImageFormatValue.fromRawValue(image.format.raw);
  // validate format depending on platform
  // only supported formats:
  // * nv21 for Android
  // * bgra8888 for iOS
  if (format == null ||
      (Platform.isAndroid && format != InputImageFormat.nv21) ||
      (Platform.isIOS && format != InputImageFormat.bgra8888)) {
    debugPrint("Invalid formats: format: $format}");
    // return null;
  }

  // since format is constraint to nv21 or bgra8888, both only have one plane
  if (image.planes.length != 1) {
    debugPrint("More than one plane found");
    // return null;
  }
  Plane plane0 = image.planes[0];
  Plane plane1 = image.planes[1];
  Plane plane2 = image.planes[2];
  List<int> combinedList = [];
  combinedList.addAll(image.planes[0].bytes);
  combinedList.addAll(image.planes[1].bytes);
  combinedList.addAll(image.planes[2].bytes);
  var allBytes = Uint8List.fromList(combinedList);

  // compose InputImage using bytes
  return InputImage.fromBytes(
    bytes: allBytes,
    metadata: InputImageMetadata(
      size: ui.Size(image.width.toDouble(), image.height.toDouble()),
      rotation: rotation, // used only in Android
      format: format!, // used only in iOS
      bytesPerRow: plane0.bytesPerRow, // used only in iOS
    ),
  );
}




