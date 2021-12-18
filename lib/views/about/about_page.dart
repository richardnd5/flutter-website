import 'package:flutter/material.dart';
import 'package:flutter_website/text_styles.dart';
import 'package:flutter_website/views/home/components/expanding_page_container.dart';
import 'package:flutter_website/views/home/home_page_view_model.dart';
import 'package:flutter_website/views/inner_page_container.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  final pageType = PageType.about;

  @override
  Widget build(BuildContext context) {
    return InnerPageContainer(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Text(
              'Hello! Welcome to my website. It holds a few creative projects I have done over the years. This website is still under construction.',
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
