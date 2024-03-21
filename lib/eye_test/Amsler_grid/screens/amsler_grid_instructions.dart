import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'amsler_grid_testing.dart';

class AmslerGridInstructionsScreen extends StatefulWidget {
  @override
  _AmslerGridInstructionsScreenState createState() =>
      _AmslerGridInstructionsScreenState();
}

class _AmslerGridInstructionsScreenState
    extends State<AmslerGridInstructionsScreen> {
  Widget _buildInstructionStep(String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(Icons.check, color: Colors.blue),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildChartContainer(String imagePath) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.blue.shade200,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Image.asset(imagePath, fit: BoxFit.contain),
    );
  }

  Widget _buildChartGesture(String imagePath) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                AmslerGridTestingScreen(chartImagePath: imagePath),
          ),
        );
      },
      child: buildChartContainer(imagePath),
    );
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
          'Amsler Grid Instructions',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true, // This centers the title text
      ),
      backgroundColor: Colors.blue.shade400,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Amsler Grid Test?',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'The Amsler Grid Test is a simple and effective way to monitor your central vision and detect any changes.',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Exercises',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Choose an Amsler Grid chart below and perform the test by following the instructions provided with the chart.',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  SizedBox(height: 20),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildChartGesture(
                            'assets/amsler_grid_charts/chart1.jpg'),
                        _buildChartGesture(
                            'assets/amsler_grid_charts/chart2.jpg'),
                        _buildChartGesture(
                            'assets/amsler_grid_charts/chart3.jpg'),
                        _buildChartGesture(
                            'assets/amsler_grid_charts/chart4.jpg'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Instructions',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  _buildInstructionStep(
                      'Find a quiet and well-lit room to take the test.'),
                  _buildInstructionStep(
                      'Focus on the circles with numbers inside.'),
                  _buildInstructionStep(
                      'Identify the numbers you see in each circle.'),
                  _buildInstructionStep(
                      'Press Next if you see otherwise press Stop'),
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: AmslerGridInstructionsScreen()));
}
