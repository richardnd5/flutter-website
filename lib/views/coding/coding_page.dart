import 'package:flutter/material.dart';
import 'package:flutter_website/views/inner_page_container.dart';
import 'dart:js' as js;

import '../home/home_page_view_model.dart';

class CodingPage extends StatelessWidget {
  const CodingPage({Key? key}) : super(key: key);

  final pageType = PageType.coding;

  final double imageSize = 86;

  Widget build(BuildContext context) {
    return InnerPageContainer(
      child: Column(
        children: [
          SizedBox(height: 64),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () => launchURL('https://github.com/richardnd5'),
                child: Image.asset(
                  'assets/images/github.png',
                  width: imageSize,
                  height: imageSize,
                ),
              ),
              InkWell(
                onTap: () => launchURL(
                    'https://apps.apple.com/us/app/sstories/id1455299421?ign-mpt=uo%3D2'),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    'assets/images/sStoriesReduced.jpg',
                    width: imageSize,
                    height: imageSize,
                  ),
                ),
              ),
              InkWell(
                onTap: () => launchURL(
                    'https://apps.apple.com/ph/app/carls-sporting-adventure/id1467429782'),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    'assets/images/CSA.jpg',
                    width: imageSize,
                    height: imageSize,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

void launchURL(String url) async {
  js.context.callMethod('open', [url]);
}
