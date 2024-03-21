import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(AstigmatismTestScreen());
}

class AstigmatismTestScreen extends StatefulWidget {
  @override
  _AstigmatismTestScreenState createState() => _AstigmatismTestScreenState();
}

class _AstigmatismTestScreenState extends State<AstigmatismTestScreen> {
  int currentIndex = 0;
  List<String> imagePaths = [
    'assets/astigmatism_test/a_1.png',
    'assets/astigmatism_test/a_2.png',
    'assets/astigmatism_test/a_3.png',
    'assets/astigmatism_test/a_4.png',
  ];

  void _nextImage() {
    setState(() {
      currentIndex = (currentIndex + 1) % imagePaths.length;
    });
  }

  void _returnToHomeScreen() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: Colors.blue,
        ),
        backgroundColor: Colors.blue,
        elevation: 0.0,
        title: Text(
          'Astigmatism Test',
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
          children: [
            Image.asset(imagePaths[currentIndex], width: 300, height: 300),
            SizedBox(height: 100),
            if (currentIndex < imagePaths.length - 1)
              Container(
                width: 300, // Set the desired width
                height: 50, // Set the desired height
                child: ElevatedButton(
                  onPressed: _nextImage,
                  child: Text(
                    'Next',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              )
            else
              Column(
                children: [
                  Text(
                    'Instructions:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'If you have experienced any visual discomfort or difficulty, consider consulting a medical professional.',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _returnToHomeScreen,
                    child: Text(
                      'Back to Home',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
