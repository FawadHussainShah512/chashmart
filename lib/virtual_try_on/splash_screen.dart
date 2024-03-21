import 'package:flutter/material.dart';

import 'camera_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3) , ()async {
       Navigator.push(context, MaterialPageRoute(builder: (context) => CameraScreen()));
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
            SizedBox(height: 10),
            Text("Virtual Eye glass try on App by Fawad Hussain", style: TextStyle(color: Colors.grey))
          ],
        ),
      )
    );
  }
}
