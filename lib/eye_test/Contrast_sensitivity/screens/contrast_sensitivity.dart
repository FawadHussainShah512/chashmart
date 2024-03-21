import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(ContrastSensitivityTestScreen());
}

class ContrastSensitivityTestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      title: 'Contrast Sensitivity Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
// Status bar color
            statusBarColor: Colors.blue,),
          backgroundColor: Colors.blue,
          elevation: 0.0,
          title: Text(
            'Contrast Sensitivity Test',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          centerTitle: true, // This centers the title text
        ),
        body: ContrastSensitivityScreen(),
      ),
    );
  }
}

class ContrastSensitivityScreen extends StatefulWidget {
  @override
  _ContrastSensitivityScreenState createState() =>
      _ContrastSensitivityScreenState();
}

class _ContrastSensitivityScreenState extends State<ContrastSensitivityScreen> {
  double _sliderValue = 1.0;
  bool _testPassed = false;

  void _updateSliderValue(double newValue) {
    setState(() {
      _sliderValue = newValue;
      if (!_testPassed && _sliderValue <= 0.5) {
        _showTestPassedDialog();
      }
    });
  }

  void _showTestPassedDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Test Passed'),
          content: Text('Congratulations! You have passed the test.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
    setState(() {
      _testPassed = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Gradually move the slider until you can no longer distinguish the letters on the chart.',
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Container(
            height: 300,
            width: 300,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
            ),
            child: ChartLetters(sliderValue: _sliderValue),
          ),
          SizedBox(height: 20),
          Slider(
            value: _sliderValue,
            onChanged: _updateSliderValue,
            min: 0.0,
            max: 1.0,
            divisions: 10,
            label: _sliderValue.toStringAsFixed(2),
          ),
        ],
      ),
    );
  }
}

class ChartLetters extends StatelessWidget {
  final double sliderValue;

  ChartLetters({
    required this.sliderValue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ChartLetter(
              letter: 'C',
              opacity: sliderValue,
            ),
            ChartLetter(
              letter: 'D',
              opacity: sliderValue,
            ),
            ChartLetter(
              letter: 'E',
              opacity: sliderValue,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ChartLetter(
              letter: 'F',
              opacity: sliderValue,
            ),
            ChartLetter(
              letter: 'G',
              opacity: sliderValue,
            ),
            ChartLetter(
              letter: 'H',
              opacity: sliderValue,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ChartLetter(
              letter: 'N',
              opacity: sliderValue,
            ),
            ChartLetter(
              letter: 'P',
              opacity: sliderValue,
            ),
            ChartLetter(
              letter: 'U',
              opacity: sliderValue,
            ),
          ],
        ),
      ],
    );
  }
}

class ChartLetter extends StatelessWidget {
  final String letter;
  final double opacity;

  ChartLetter({
    required this.letter,
    required this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Opacity(
        opacity: opacity,
        child: Text(
          letter,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}





