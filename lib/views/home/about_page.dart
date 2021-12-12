import 'package:flutter/material.dart';
import 'package:flutter_website/views/home/home_page_view_model.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  final pageType = PageType.about;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageType.getPageColor(),
      body: Center(
        child: Text('About Page'),
      ),
    );
  }
}
