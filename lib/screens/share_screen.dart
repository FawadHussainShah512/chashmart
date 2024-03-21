// import 'package:flutter/material.dart';
// import 'package:share_plus/share_plus.dart';
//
// class ShareApp extends StatefulWidget {
//   const ShareApp({Key? key}) : super(key: key);
//
//   @override
//   State<ShareApp> createState() => _ShareAppState();
// }
//
// class _ShareAppState extends State<ShareApp> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             Share.share('com.example.chashmart');
//           },
//           child: Text('Share App'),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareApp extends StatelessWidget {
  const ShareApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Share Plus"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Share Chashmart with your friends:'),
            SizedBox(height: 10),
            IconButton(
              onPressed: () => sharePressed(context),
              icon: Icon(Icons.share, color: Colors.redAccent),
            ),
            Image.asset(
              "assets/share.jpg",
              width: MediaQuery.of(context).size.width * 0.6,
            ),
          ],
        ),
      ),
    );
  }

  void sharePressed(BuildContext context) {
    String message =
        'Check out chashmart, an all in one eye solution for all your needs: com.example.chashmart';
    Share.share(message, subject: 'Explore Chashmart');
  }
}
