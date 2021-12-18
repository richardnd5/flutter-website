import 'package:flutter/material.dart';
import 'package:flutter_website/views/pages/home/home_page_view_model.dart';
import 'package:flutter_website/views/components/inner_page_container.dart';

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
        child: ListView(
          children: [
            Text(
              'Welcome! This website is an experiment with new navigation patterns for the web. It is built in Flutter.',
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
