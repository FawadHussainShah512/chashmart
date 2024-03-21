import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../Amsler_grid/screens/amsler_grid_instructions.dart';
import '../../Astigmatism_test/screens/astigmatism_test.dart';
import '../../Color_blindness/screens/instruction_color_blindness.dart';
import '../../Color_cube/screens/color_cube.dart';
import '../../Contrast_sensitivity/screens/contrast_sensitivity.dart';
import '../../Eye_exercise/screens/eye_exercise.dart';
import '../../Glacoma_survey/screens/glaucoma_survey.dart';
import '../../OKN_test/screens/okn_test.dart';
import '../../Quiz/screens/welcome/welcome_screen.dart';
import '../../Visual_acuity/screens/instruction_acuity.dart';

void main() {
  runApp(MaterialApp(
    home: MainMenuScreen(),
  ));
}

class MainMenuScreen extends StatelessWidget {
  static const routeName = '/MainMenuScreen';
  var height, width;

  List<String> imgData = [
    "assets/main_menu/visual_acuity.png", // Replace with actual image paths
    "assets/main_menu/color_blind.png",
    "assets/main_menu/amsler_grid.png",
    "assets/main_menu/okn.png",
    "assets/main_menu/eye_care.png",
    "assets/main_menu/color_cube.png",
    "assets/main_menu/eye_muscle.png",
    "assets/main_menu/eye_quiz.png",
    "assets/main_menu/glacoma_survey.png",
    "assets/main_menu/color_cube.png",
  ];

  List<String> titles = [
    "Visual Acuity",
    "Color Blindness",
    "Amsler Grid",
    "OKN Test",
    "Astigmatism Test",
    "Contrast Sensitivity",
    "Eye Exercise",
    "Eye Quiz",
    "Glaucoma Survey",
    "Color Matching",
  ];

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0.0,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        color: Colors.blue,
        width: width,
        child: Column(
          children: [
            Container(
              height: height * 0.2, // Adjust the height as needed
              width: width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/animation/animation.json', // Replace with your Lottie asset file path
                    width: 120, // Adjust the width as needed
                    height: 120, // Adjust the height as needed
                    fit: BoxFit.contain,
                  ),
                  Text(
                    "EYE TESTING SCREEN",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                padding: EdgeInsets.all(20), // Adjust padding as needed
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: width > height
                        ? 4
                        : 2, // Change the number of columns based on orientation
                    childAspectRatio: 1.1,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: imgData.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        // Navigate to a different page based on the index
                        switch (index) {
                          case 0:
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => InstructionAcuityScreen(),
                              ),
                            );
                            break;
                          case 1:
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    InstructionColorBlindnessScreen(),
                              ),
                            );
                            break;
                          case 2:
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AmslerGridInstructionsScreen(),
                              ),
                            );
                            break;
                          case 3:
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OKNTestScreen(),
                              ),
                            );
                            break;

                          case 4:
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AstigmatismTestScreen(),
                              ),
                            );
                            break;
                          case 5:
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ContrastSensitivityTestScreen(),
                              ),
                            );
                            break;
                          case 6:
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EyeExerciseScreen(),
                              ),
                            );
                            break;
                          case 7:
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WelcomeScreen(),
                              ),
                            );
                            break;
                          case 8:
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GlaucomaSurveyScreen(),
                              ),
                            );
                            break;

                          case 9:
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ColorMatchingGame(),
                              ),
                            );
                            break;

                          default:
                            break;
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.all(10), // Adjust margin as needed
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              spreadRadius: 1,
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _getRandomColor(),
                              ),
                              child: Center(
                                child: Image.asset(
                                  imgData[index],
                                  width: 50, // Adjust the image size as needed
                                ),
                              ),
                            ),
                            Text(
                              titles[index],
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getRandomColor() {
    final colors = [
      Colors.red.shade100,
      Colors.green.shade100,
      Colors.blue.shade100,
      Colors.orange.shade100,
      Colors.purple.shade100,
      Colors.yellow.shade100,
    ];
    return colors[DateTime.now().microsecondsSinceEpoch % colors.length];
  }
}
