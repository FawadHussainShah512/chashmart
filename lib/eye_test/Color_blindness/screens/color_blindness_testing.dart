import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ColorBlindnessTestingScreen extends StatefulWidget {
  @override
  _ColorBlindnessTestingScreenState createState() =>
      _ColorBlindnessTestingScreenState();
}

class _ColorBlindnessTestingScreenState
    extends State<ColorBlindnessTestingScreen> {
  List<String> imagePaths = [
    'assets/color_blindness/color1.jpg',
    'assets/color_blindness/color2.jpg',
    'assets/color_blindness/color3.jpg',
    'assets/color_blindness/color4.jpg',
    'assets/color_blindness/color5.jpg',
    'assets/color_blindness/color6.jpg',
    'assets/color_blindness/color7.jpg',
    'assets/color_blindness/color8.jpg',
    'assets/color_blindness/color9.jpg',
    'assets/color_blindness/color10.jpg',
    'assets/color_blindness/color11.jpg',
    'assets/color_blindness/color12.jpg',
    'assets/color_blindness/color13.jpg',
    'assets/color_blindness/color14.jpg',
    'assets/color_blindness/color15.jpg',
    // Add more image paths here
  ];

  List<List<String>> options = [
    ['17', '12', '11'],
    ['8', '3', '6'],
    ['20', '28', '29'],
    ['4', '5', '6'],
    ['8', '3', '6'],
    ['10', '15', '16'],
    ['71', '77', '74'],
    ['0', '8', '6'],
    ['45', '43', '40'],
    ['6', '5', '3'],
    ['2', '1', '7'],
    ['10', '16', '18'],
    ['78', '70', '73'],
    ['26', '28', '20'],
    ['47', '48', '42'],
    // Add more options for each image
  ];

  List<int> correctOptions = [
    12,
    8,
    29,
    5,
    3,
    15,
    74,
    6,
    45,
    5,
    7,
    16,
    73,
    26,
    42
  ]; // Correct options for each image
  int currentImageIndex = 0;
  int totalCorrect = 0; // Total number of correct answers

  void handleUserChoice(int userChoice) {
    if (userChoice == correctOptions[currentImageIndex]) {
      setState(() {
        totalCorrect++;
      });
    }

    if (currentImageIndex < imagePaths.length - 1) {
      setState(() {
        currentImageIndex++;
      });
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Your Color Blindness Test Score'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Score: $totalCorrect / ${imagePaths.length}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  onPrimary: Colors.white,
                ),
                child: Text('OK'),
              ),
            ],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: 4,
            backgroundColor: Colors.white,
            contentPadding: EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 8.0),
          );
        },
      );
    }
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
          'Color Blindness Test',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true, // This centers the title text
      ),
      body: Container(
        color: Colors.white, // Plain white background
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(),
                child: Image.asset(
                  imagePaths[currentImageIndex],
                  fit: BoxFit
                      .cover, // Fit the image while maintaining aspect ratio
                ),
              ),
              SizedBox(height: 100),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: options[currentImageIndex]
                    .map((option) => _buildOptionButton(option))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionButton(String option) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10), // Add horizontal spacing
      child: ElevatedButton(
        onPressed: () => handleUserChoice(int.parse(option)),
        style: ElevatedButton.styleFrom(
          minimumSize: Size(50, 50),
          primary: Colors.black,
          shape: CircleBorder(),
        ),
        child: Text(
          '$option',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: ColorBlindnessTestingScreen()));
