

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../Main_menu/screens/main_menu.dart';

void main() {
  runApp(MaterialApp(
    home: EyeExerciseScreen(),
  ));
}

class EyeExerciseScreen extends StatefulWidget {
  @override
  _EyeExerciseScreenState createState() => _EyeExerciseScreenState();
}

class _EyeExerciseScreenState extends State<EyeExerciseScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  int secondsRemaining = 60;
  int directionIndex = 0;
  List<String> directions = [
    'Move eyes up',
    'Move eyes down',
    'Move eyes left',
    'Move eyes right',
    'Move eyes top left',
    'Move eyes top right',
    'Move eyes bottom left',
    'Move eyes bottom right',
  ];
  double ballX = 0.0;
  double ballY = 0.0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000), // Shorten the animation duration
    );

    startTimer();
  }

  void startTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (directionIndex < directions.length - 1) {
          directionIndex++;
        } else {
          directionIndex = 0;
        }

        switch (directions[directionIndex]) {
          case 'Move eyes up':
            ballX = 0.0;
            ballY = -1.0;
            break;
          case 'Move eyes down':
            ballX = 0.0;
            ballY = 1.0;
            break;
          case 'Move eyes left':
            ballX = -1.0;
            ballY = 0.0;
            break;
          case 'Move eyes right':
            ballX = 1.0;
            ballY = 0.0;
            break;
          case 'Move eyes top left':
            ballX = -1.0;
            ballY = -1.0;
            break;
          case 'Move eyes top right':
            ballX = 1.0;
            ballY = -1.0;
            break;
          case 'Move eyes bottom left':
            ballX = -1.0;
            ballY = 1.0;
            break;
          case 'Move eyes bottom right':
            ballX = 1.0;
            ballY = 1.0;
            break;
        }

        if (secondsRemaining > 0) {
          secondsRemaining--;
        } else {
          timer.cancel();
          _controller.stop();
          // Show a pop-up dialog when the test is completed
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Test Completed',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MainMenuScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          padding: EdgeInsets.all(16),
                        ),
                        child: Text(
                          'Close',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      });

      _controller.reset();
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: Colors.blue,),
        backgroundColor: Colors.blue,
        elevation: 0.0,
        title: Text(
          'Eye Exercise',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true, // This centers the title text
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(ballX * 50 * _controller.value, ballY * 50 * _controller.value),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.teal.shade900, // You can change the ball's color
                      shape: BoxShape.circle,
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 250),
            Text(
              directions[directionIndex],
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
                'Time Left: $secondsRemaining seconds',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
