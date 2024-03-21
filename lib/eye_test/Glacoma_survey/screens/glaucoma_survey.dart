
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(
    home: GlaucomaSurveyScreen(),
    theme: ThemeData(
      primaryColor: Colors.blue,
      hintColor: Colors.orange,
      fontFamily: 'Roboto',
    ),
  ));
}

class GlaucomaSurveyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: Colors.blue,),
        backgroundColor: Colors.blue,
        elevation: 0.0,
        title: Text(
          'Glaucoma Survey',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true, // This centers the title text
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SurveySection(
              title: 'Are you at risk for glaucoma?',
              content: 'Everyone is at risk for glaucoma, but certain groups are at higher risk than others. To determine your risk for glaucoma, please read and answer these questions below:',
            ),
            SurveySection(
              title: 'Are you over 60?',
              content: 'Glaucoma is much more common among older people. You are six times more likely to get glaucoma if you are over 60 years old.',
            ),
            SurveySection(
              title: 'Are you African-American?',
              content: 'Glaucoma is 6-8 times more common in African Americans than in Caucasians.',
            ),
            SurveySection(
              title: 'Are you Eastern-Asian?',
              content: 'People of Asian descent seem to be at increased risk for angle-closure glaucoma. Japanese people are at higher risk for normal-tension glaucoma.',
            ),
            SurveySection(
              title: 'Do you have a family history of glaucoma?',
              content: 'The most common type of glaucoma, primary open-angle glaucoma, is hereditary. If members of your family have or had glaucoma, you are at a much higher risk. Family history increases risk of glaucoma 4 to 9 times.',
            ),
            SurveySection(
              title: 'Do you use steroids?',
              content: 'Steroid users are at higher risk for glaucoma.',
            ),
            SurveySection(
              title: 'Do you have diabetes?',
              content: 'People with diabetes have a much higher chance of developing glaucoma.',
            ),
            SurveySection(
              title: 'Did you ever have eye surgery or eye injury?',
              content: 'Injury to the eye may cause secondary open-angle glaucoma. This type of glaucoma can occur after the injury or years later.',
            ),
            //
            SurveySection(
                title: 'Vision Problem',
                content: ' Do problems with your vision make it difficult to do some of the things you would like to do?'),
            SurveySection(
              title: 'Reading difficulty',
              content: 'Do you have difficulty reading regular print in the newspaper, magazines, books?',

            ),
            SurveySection(
              title: 'Watching difficulty',
              content: 'Do problems with your vision make it difficult to watch TV work on the computer or enjoy other activities?',

            ),
            SurveySection(
              title: 'Visual Acuity problems',
              content: 'Do you have problems seeing distant objects clearly? Or seeing close objects better than distant ones?',

            ),
            SurveySection(
              title: 'Near Vision Difficulties ',
              content: 'Do you have trouble reading mails, or seeing prices during shopping?',
            ),
            SurveySection(
              title: 'Vision Loss',
              content: 'Do you detect loss of vision?',
            ),
            SurveySection(
              title: 'Alert',
              content: 'If you answered YES to any of the above questions, you should get a complete eye exam, including eye dilation, every one or two years.',
            ),
            // Add more SurveySection widgets here
          ],
        ),
      ),
    );
  }
}

class SurveySection extends StatelessWidget {
  final String title;
  final String content;

  SurveySection({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width, // Set width to screen width
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color:Colors.black,
        border: Border.all(
          color: Colors.blue, // White border color
          width: 2, // Border width
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          SizedBox(height: 12),
          Text(
            content,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}
