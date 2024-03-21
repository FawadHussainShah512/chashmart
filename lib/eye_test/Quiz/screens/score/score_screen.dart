import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:confetti/confetti.dart'; // Import the confetti package

import '../../constants.dart';
import '../../controllers/question_controller.dart';

class ScoreScreen extends StatefulWidget {
  @override
  _ScoreScreenState createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen>
    with SingleTickerProviderStateMixin {
  QuestionController _qnController = Get.put(QuestionController());
  int score = 0;
  bool _isExpanded = false;
  ConfettiController _confettiController = ConfettiController(); // Create a confetti controller

  @override
  void initState() {
    super.initState();
    // Calculate the score after a delay of 500 milliseconds
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        score = _qnController.numOfCorrectAns * 10;
        _isExpanded = true;
        _confettiController.play(); // Play the confetti effect
      });
    });
  }

  @override
  void dispose() {
    _confettiController.dispose(); // Dispose of the confetti controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          ConfettiWidget(
            confettiController: _confettiController, // Pass the confetti controller
            emissionFrequency: 0.05,
            numberOfParticles: 20,
            shouldLoop: false,
            colors: const [
              Colors.green,
              Colors.blue,
              Colors.pink,
              Colors.orange,
              Colors.purple,
            ],
            child: Column(
              children: [
                Spacer(flex: 3),
                Text(
                  "Score",
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      ?.copyWith(color: kSecondaryColor),
                ),
                Spacer(),
                AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  width: _isExpanded ? 200 : 50,
                  height: _isExpanded ? 200 : 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: kPrimaryGradient,
                  ),
                  child: Center(
                    child: Text(
                      "$score/${_qnController.questions.length * 10}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: _isExpanded ? 30 : 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Spacer(flex: 3),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
