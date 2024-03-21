import 'package:flutter/material.dart';

import '../../screens/search_screen.dart';
import '../subtitle_text.dart';

class CategoryRoundedWidget extends StatelessWidget {
  const CategoryRoundedWidget({
    super.key,
    required this.image,
    required this.name,
  });

  final String image, name;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, SearchScreen.routeName, arguments: name);
      },
      child: Column(
        children: [
          Image.asset(
            image,
            height: 45,
            width: 45,
          ),
          const SizedBox(
            height: 4,
          ),
          SubtitleTextWidget(
            label: name,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          )
        ],
      ),
    );
  }
}
