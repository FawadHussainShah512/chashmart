import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'color_blindness_testing.dart';

class InstructionColorBlindnessScreen extends StatefulWidget {
  @override
  _InstructionColorBlindnessScreenState createState() =>
      _InstructionColorBlindnessScreenState();
}

class _InstructionColorBlindnessScreenState
    extends State<InstructionColorBlindnessScreen> {
  PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  final List<String> _instructionTexts = [
    'Find a quiet and well-lit room to take the test.',
    'Focus on the circles with numbers inside.',
    'Identify the numbers you see in each circle.',
    'Press Next If you can see otherwise press Stop.',
  ];

  final List<String> _instructionImages = [
    'assets/visual_acuity/acuity1.png', // Replace with your image paths
    'assets/visual_acuity/acuity2.png',
    'assets/visual_acuity/acuity3.png',
    'assets/visual_acuity/acuity4.png',
    'assets/visual_acuity/acuity5.png',
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
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
          'Color Blindness Instructions',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true, // This centers the title text
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white, // White background
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 250, // Adjust the image height as needed
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: _instructionTexts.length,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        return _buildCircularImage(_instructionImages[index]);
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    _instructionTexts[_currentPage],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Roboto',
                        color: Colors.blue.shade800),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _instructionTexts.length,
                      (index) => _buildDot(index == _currentPage),
                    ),
                  ),
                  SizedBox(height: 50),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ColorBlindnessTestingScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue.shade800,
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: Text(
                      'Start Eye Test',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDot(bool isActive) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      width: isActive ? 12 : 8,
      height: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? Colors.blue.shade800 : Colors.grey,
      ),
    );
  }

  Widget _buildCircularImage(String imagePath) {
    return Container(
      width: 200, // Adjust the width as needed
      height: 200, // Adjust the height as needed
      decoration: BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Image.asset(
          imagePath,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
