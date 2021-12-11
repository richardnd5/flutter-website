import 'package:flutter/material.dart';
import 'hero_widget.dart';

class NewHomePage extends StatelessWidget {
  const NewHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(32.0),
        alignment: FractionalOffset.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            HeroWidget(
              tag: 'soup',
              title: 'Projects',
            ),
            HeroWidget(
              tag: 'noodle',
              title: 'About',
            ),
          ],
        ),
      ),
    );
  }
}
