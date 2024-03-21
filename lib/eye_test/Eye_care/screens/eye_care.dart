import 'dart:math';

import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

class EyeCareTipsScreen extends StatefulWidget {
  @override
  _EyeCareTipsScreenState createState() => _EyeCareTipsScreenState();
}

class _EyeCareTipsScreenState extends State<EyeCareTipsScreen> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void _startConfettiAnimation() {
    _confettiController.play();
  }

  @override
  Widget build(BuildContext context) {
    _startConfettiAnimation();

    return Scaffold(
      appBar: AppBar(
        title: Text('Eye Care Tips'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue.shade400, Colors.blue.shade800],
              ),
            ),
          ),
          ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            blastDirection: pi / 2,
            shouldLoop: false,
            emissionFrequency: 0.05,
            numberOfParticles: 100,
            maxBlastForce: 5,
            minBlastForce: 2,
            gravity: 1,
            colors: [Colors.red, Colors.purple, Colors.pink],
            particleDrag: 0.05,

          ),
          const SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EyeCareTipCard(
                    title: '1. Take Regular Breaks',
                    description: 'Staring at screens for long periods can cause eye strain and fatigue. Remember to take regular breaks and look away from the screen every 20 minutes.',
                    imageAsset: 'assets/img.jpeg',
                  ),
                  SizedBox(height: 5),
                  EyeCareTipCard(
                    title: '2. Follow the 20-20-20 Rule',
                    description: 'To reduce eye strain, follow the 20-20-20 rule. Every 20 minutes, take a 20-second break, and look at something 20 feet away.',
                    imageAsset: 'assets/img.jpeg',
                  ),
                  SizedBox(height: 5),
                  // Add more EyeCareTipCard widgets for each tip
                  EyeCareTipCard(
                    title: '1. Take Regular Breaks',
                    description: 'Staring at screens for long periods can cause eye strain and fatigue. Remember to take regular breaks and look away from the screen every 20 minutes.',
                    imageAsset: 'assets/img.jpeg',
                  ),
                  SizedBox(height: 5),
                  EyeCareTipCard(
                    title: '2. Follow the 20-20-20 Rule',
                    description: 'To reduce eye strain, follow the 20-20-20 rule. Every 20 minutes, take a 20-second break, and look at something 20 feet away.',
                    imageAsset: 'assets/img.jpeg',
                  ),
                  SizedBox(height: 5),
                  EyeCareTipCard(
                    title: '1. Take Regular Breaks',
                    description: 'Staring at screens for long periods can cause eye strain and fatigue. Remember to take regular breaks and look away from the screen every 20 minutes.',
                    imageAsset: 'assets/img.jpeg',
                  ),
                  SizedBox(height: 5),
                  EyeCareTipCard(
                    title: '2. Follow the 20-20-20 Rule',
                    description: 'To reduce eye strain, follow the 20-20-20 rule. Every 20 minutes, take a 20-second break, and look at something 20 feet away.',
                    imageAsset: 'assets/img.jpeg',
                  ),
                  SizedBox(height: 5),
                  EyeCareTipCard(
                    title: '1. Take Regular Breaks',
                    description: 'Staring at screens for long periods can cause eye strain and fatigue. Remember to take regular breaks and look away from the screen every 20 minutes.',
                    imageAsset: 'assets/img.jpeg',
                  ),
                  SizedBox(height: 5),
                  EyeCareTipCard(
                    title: '2. Follow the 20-20-20 Rule',
                    description: 'To reduce eye strain, follow the 20-20-20 rule. Every 20 minutes, take a 20-second break, and look at something 20 feet away.',
                    imageAsset: 'assets/img.jpeg',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EyeCareTipCard extends StatefulWidget {
  final String title;
  final String description;
  final String imageAsset;

  const EyeCareTipCard({
    required this.title,
    required this.description,
    required this.imageAsset,
  });

  @override
  _EyeCareTipCardState createState() => _EyeCareTipCardState();
}

class _EyeCareTipCardState extends State<EyeCareTipCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              widget.imageAsset,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    widget.description,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: EyeCareTipsScreen(),
  ));
}





