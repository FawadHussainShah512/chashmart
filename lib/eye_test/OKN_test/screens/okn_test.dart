
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';

void main() {
  runApp(OKNTestScreen());
}

class OKNTestScreen extends StatefulWidget {
  @override
  _OKNTestScreenState createState() => _OKNTestScreenState();
}

class _OKNTestScreenState extends State<OKNTestScreen> {
  bool _testCompleted = false;

  @override
  void initState() {
    super.initState();
    _startTest();
  }

  void _startTest() {
    // Start a timer for 30 seconds
    Timer(Duration(seconds: 30), () {
      if (!_testCompleted) {
        // Stop the test and show the completion dialog
        _showCompletionDialog();
      }
    });
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing the dialog with a tap
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Test Complete"),
          content: Text("You have completed the OKN test."),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    setState(() {
      _testCompleted = true;
    });
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
            'OKN Test',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          centerTitle: true, // This centers the title text
        ),
        body: Center(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white, // Background color
            child: OKNLines(),
          ),
        ),
      ),
    );
  }
}

class OKNLines extends StatefulWidget {
  @override
  _OKNLinesState createState() => _OKNLinesState();
}

class _OKNLinesState extends State<OKNLines> {
  double _linePosition = 0;

  @override
  void initState() {
    super.initState();

    // Start a timer to update the line position every 100 milliseconds
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        // Increase the line position to move it upwards
        _linePosition -= 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // You can adjust the spacing between lines by changing the 'lineSpacing' value
    final lineSpacing = 25.0;

    // Calculate the initial number of lines based on screen height and line spacing
    final screenHeight = MediaQuery.of(context).size.height;
    final initialLineCount = (screenHeight / lineSpacing).ceil();

    return ListView.builder(
      itemCount: initialLineCount,
      itemBuilder: (BuildContext context, int index) {
        // Calculate the position of each line
        final yPos = index * lineSpacing + _linePosition;
        return OKNLine(yPosition: yPos);
      },
    );
  }
}

class OKNLine extends StatelessWidget {
  final double yPosition;

  OKNLine({required this.yPosition});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: OKNPainter(yPosition),
      size: Size(double.infinity, 20),
    );
  }
}

class OKNPainter extends CustomPainter {
  final double yPosition;

  OKNPainter(this.yPosition);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red // Line color
      ..strokeWidth = 20.0; // Line thickness

    // Draw the line at the specified Y position
    canvas.drawLine(
      Offset(0, yPosition),
      Offset(size.width, yPosition),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
