import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AcuityTestingScreen extends StatefulWidget {
  @override
  _AcuityTestingScreenState createState() => _AcuityTestingScreenState();
}

class _AcuityTestingScreenState extends State<AcuityTestingScreen> {
  List<String> imagePaths = [
    'assets/visual_acuity/1.jpg',
    'assets/visual_acuity/2.jpg',
    'assets/visual_acuity/3.jpg',
    'assets/visual_acuity/4.jpg',
    'assets/visual_acuity/5.jpg',
    'assets/visual_acuity/6.jpg',
    'assets/visual_acuity/7.jpg',
    'assets/visual_acuity/8.jpg',
    'assets/visual_acuity/9.jpg',
    'assets/visual_acuity/10.jpg',
    // Add more image paths here for a total of 10 images
  ];

  int currentImageIndex = 0;

  List<String> customScores = [
    '20/200',
    '20/100',
    '20/70',
    '20/60',
    '20/50',
    '20/40',
    '20/35',
    '20/30',
    '20/25',
    '20/20',
  ];

  void handleUserChoice(int userChoice) {
    if (userChoice == 1) {
      String customScore = customScores[currentImageIndex];
      String instructions = getInstructionsForScore(customScore);

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Your Acuity Score'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Score: $customScore',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text(
                  'Instructions based on your score:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  instructions,
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
    } else if (userChoice == 2) {
      if (currentImageIndex < imagePaths.length - 1) {
        setState(() {
          currentImageIndex++;
        });
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Congratulations!'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('You have completed the acuity test successfully.'),
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
            );
          },
        );
      }
    }
  }

  String getInstructionsForScore(String customScore) {
    switch (customScore) {
      case '20/200':
        return 'You seem to have problems with seeing details at certain distances. You should visit an eye doctor to have an accurate test.';
      case '20/100':
        return 'You seem to have problems with seeing details at certain distances. You should visit an eye doctor to have an accurate test.';
      case '20/70':
        return 'You seem to have problems with seeing details at certain distances. You should visit an eye doctor to have an accurate test.';
      case '20/60':
        return 'You seem to have problems with seeing details at certain distances. You should visit an eye doctor to have an accurate test.';
      case '20/50':
        return 'You seem to have problems with seeing details at certain distances. You should visit an eye doctor to have an accurate test.';
      case '20/40':
        return 'You seem to have problems with seeing details at certain distances. You should visit an eye doctor to have an accurate test.';

      case '20/35':
        return 'You seem to have problems with seeing details at certain distances. You should visit an eye doctor to have an accurate test.';
      case '20/30':
        return 'You seem to have problems with seeing details at certain distances. You should visit an eye doctor to have an accurate test.';
      case '20/25':
        return 'Your acuity is great!You have normal vision';
      case '20/20':
        return 'Your acuity is great!You have normal vision';

      // ... Add more cases for other customScores
      default:
        return 'Perform your eye test.';
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
          'Visual Acuity Test',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true, // This centers the title text
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 350,
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imagePaths[currentImageIndex]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(160, 50),
                      primary: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10.0), // Adjust the radius as needed
                      ),
                    ),
                    onPressed: () => handleUserChoice(1),
                    child: Text(
                      "Stop",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 18, // Adjust the font size as needed
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(160, 50),
                      primary: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10.0), // Adjust the radius as needed
                      ),
                    ),
                    onPressed: () => handleUserChoice(2),
                    child: Text(
                      "Next",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 18, // Adjust the font size as needed
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: AcuityTestingScreen()));
