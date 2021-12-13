import 'package:flutter/material.dart';
import 'package:flutter_website/views/home/components/expanding_page_container.dart';
import 'package:flutter_website/views/home/home_page_view_model.dart';
import 'package:flutter_website/views/inner_page_container.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  final pageType = PageType.about;

  @override
  Widget build(BuildContext context) {
    return InnerPageContainer(
      child: Column(
        children: [
          Text('About Page'),
        ],
      ),
    );
  }
}
