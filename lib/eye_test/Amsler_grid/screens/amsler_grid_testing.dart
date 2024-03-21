import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';

class AmslerGridTestingScreen extends StatefulWidget {
  final String chartImagePath;

  AmslerGridTestingScreen({required this.chartImagePath});

  @override
  _AmslerGridTestingScreenState createState() =>
      _AmslerGridTestingScreenState();
}

class _AmslerGridTestingScreenState extends State<AmslerGridTestingScreen> {
  AudioPlayer? _player;
  bool _isPlaying = false;

  void _togglePlay() {
    if (_player == null) {
      _player = AudioPlayer();
      _player!.setAsset('assets/audio/amsler_grid_music.mp3').then((_) {
        _player!.play();
        _player!.playerStateStream.listen((playerState) {
          if (playerState.processingState == ProcessingState.completed) {
            setState(() {
              _isPlaying = false;
            });
            _player!.dispose(); // Dispose player after audio completes
            _player = null; // Reset player instance
          }
        });
        setState(() {
          _isPlaying = true;
        });
      });
    } else {
      if (_player!.playing) {
        _player!.pause();
      } else {
        _player!.play();
      }
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  @override
  void dispose() {
    _player?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _togglePlay(); // Start playing audio automatically
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: Colors.blue,
        ),
        backgroundColor: Colors.blue,
        elevation: 0.0,
        title: Text(
          'Amsler Grid Test',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true, // This centers the title text
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 350,
                  height: 350,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: Image.asset(
                    widget.chartImagePath,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 150, // Set a fixed width
                        child: ElevatedButton(
                          onPressed: _togglePlay,
                          style: ElevatedButton.styleFrom(
                            primary: _isPlaying ? Colors.red : Colors.green,
                            padding: EdgeInsets.symmetric(
                                horizontal: 40, vertical: 16),
                          ),
                          child: Text(
                            _isPlaying ? 'Mute' : 'Play',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Container(
                        width: 150, // Set a fixed width
                        child: ElevatedButton(
                          onPressed: () {
                            _showFinishPopup(context);
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            padding: EdgeInsets.symmetric(
                                horizontal: 40, vertical: 16),
                          ),
                          child: Text(
                            'Finish',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showFinishPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Test Finished'),
          content: Text(
              'If you answered YES for either eye, you should make an immediate appointment to see an eye doctor. Delay of even a few days could mean a permanent loss of vision. Tell your doctor about the results of the Amsler Grid Screening.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AmslerGridTestingScreen(chartImagePath: 'assets/chart1.png'),
  ));
}
