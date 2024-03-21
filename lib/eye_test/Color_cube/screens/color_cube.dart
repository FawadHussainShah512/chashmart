
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/services.dart';

void main() {
  runApp(ColorMatchingGame());
}

class ColorMatchingGame extends StatefulWidget {
  @override
  _ColorMatchingGameState createState() => _ColorMatchingGameState();
}

class _ColorMatchingGameState extends State<ColorMatchingGame> {
  late Color selectedColor = Colors.red; // Initialize to a default color
  late int correctBoxIndex;
  int score = 0;
  int lastTappedBoxIndex = -1;

  @override
  void initState() {
    super.initState();
    _initializeGrid();
  }

  void _initializeGrid() {
    // Randomly shuffle the colors
    final List<Color> colors = _generateColors();

    // Randomly select a box to be lighter
    final random = Random();
    correctBoxIndex = random.nextInt(16);

    // Set the selected color based on the correct box
    selectedColor = colors[correctBoxIndex];

    setState(() {});
  }

  List<Color> _generateColors() {
    final List<Color> colors = [];
    final random = Random();

    for (int i = 0; i < 16; i++) {
      final colorIndex = random.nextInt(16);
      colors.add(_getColorForIndex(colorIndex));
    }

    return colors;
  }

  Color _getColorForIndex(int index) {
    switch (index) {
      case 0:
        return Colors.red;
      case 1:
        return Colors.green;
      case 2:
        return Colors.blue;
      case 3:
        return Colors.yellow;
      case 4:
        return Colors.orange;
      case 5:
        return Colors.purple;
      case 6:
        return Colors.teal;
      case 7:
        return Colors.pink;
      case 8:
        return Colors.brown;
      default:
        return Colors.red;
    }
  }

  Future<void> _boxTapped(int index) async {
    if (index == correctBoxIndex) {
      // User tapped the correct box
      score++;
      _initializeGrid(); // Move to the next grid
    } else if (index != correctBoxIndex && lastTappedBoxIndex != index) {
      // User tapped a dark-shaded box, change its color to black
      setState(() {
        selectedColor = Colors.black;
        lastTappedBoxIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      home: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: Colors.blue,),
          backgroundColor: Colors.blue,
          elevation: 0.0,
          title: Text(
            'Color Matching Game',
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30), // Add space from left and right sides
                child: Container(
                  height: 400, // Set a fixed height
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4, // 4x4 grid
                      mainAxisSpacing: 2.0, // Adjust spacing between boxes
                      crossAxisSpacing: 2.0, // Adjust spacing between boxes
                    ),
                    itemCount: 16,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () => _boxTapped(index),
                        child: Container(
                          color: index == correctBoxIndex
                              ? selectedColor.withOpacity(0.3)
                              : selectedColor,
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                  'Score: $score',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Exit',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
