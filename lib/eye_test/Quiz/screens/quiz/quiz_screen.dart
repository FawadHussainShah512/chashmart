import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/question_controller.dart';
import 'components/body.dart';

class QuizScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    QuestionController _controller = Get.put(QuestionController());
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // Fluttter show the back button automatically
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
        IconButton(
        onPressed: _controller.nextQuestion,
        icon: Icon(
          Icons.arrow_forward,
          color: Colors.white,
          size: 20, // Adjust the size of the arrow icon
        ),
      ),]

    ),
      body: Body(),
    );
  }
}