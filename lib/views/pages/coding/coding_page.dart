import 'package:flutter/material.dart';
import 'package:flutter_website/views/components/inner_page_container.dart';
import 'package:flutter_website/views/pages/home/home_page_view_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'components/icon_text_button.dart';

final gitHub = CodingOption(
  url: 'https://github.com/richardnd5',
  asset: 'assets/images/github.png',
  label: 'Github',
);
final sStories = CodingOption(
  url: 'https://apps.apple.com/us/app/sstories/id1455299421?ign-mpt=uo%3D2',
  asset: 'assets/images/sStoriesReduced.jpg',
  label: 'sStories',
);
final csa = CodingOption(
  url: 'https://apps.apple.com/ph/app/carls-sporting-adventure/id1467429782',
  asset: 'assets/images/CSA.jpg',
  label: "Carl's Sporting Adventure",
);

class CodingOption {
  CodingOption({
    required this.url,
    required this.label,
    required this.asset,
  });
  final String label;
  final String url;
  final String asset;
}

class CodingPage extends StatefulWidget {
  const CodingPage({Key? key}) : super(key: key);

  @override
  State<CodingPage> createState() => _CodingPageState();
}

class _CodingPageState extends State<CodingPage> {
  final pageType = PageType.coding;

  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      var imageSize = constraints.maxWidth / 6;
      return InnerPageContainer(
        child: ListView(
          shrinkWrap: true,
          children: [
            Center(child: FaIcon(FontAwesomeIcons.code)),
            Padding(
              padding: const EdgeInsets.only(top: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconTextButton(
                    imageSize: imageSize,
                    assetPath: gitHub.asset,
                    label: gitHub.label,
                    onTap: () => launchURL(gitHub.url),
                  ),
                  IconTextButton(
                    imageSize: imageSize,
                    assetPath: sStories.asset,
                    label: sStories.label,
                    onTap: () => launchURL(sStories.url),
                  ),
                  IconTextButton(
                    imageSize: imageSize,
                    assetPath: csa.asset,
                    label: csa.label,
                    onTap: () => launchURL(csa.url),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
