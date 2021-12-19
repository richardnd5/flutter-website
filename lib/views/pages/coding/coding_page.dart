import 'package:flutter/material.dart';
import 'package:flutter_website/views/pages/home/home_page_view_model.dart';
import 'package:provider/provider.dart';

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

final optionList = [
  sStories,
  csa,
  gitHub,
  sStories,
  csa,
  gitHub,
  sStories,
  csa,
  gitHub,
  sStories,
  csa,
  gitHub,
  sStories,
  csa,
  gitHub,
  sStories,
  csa,
  gitHub,
];

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
  int getCrossAxisCount(double width) {
    if (width < 600) return 2;
    if (width < 800) return 3;
    if (width < 1000) return 4;
    return 5;
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: getCrossAxisCount(size.width),
        mainAxisExtent: 150,
      ),
      itemCount: optionList.length,
      itemBuilder: (_, index) {
        return IconTextButton(
          assetPath: optionList[index].asset,
          label: optionList[index].label,
          onTap: () => launchURL(optionList[index].url),
        );
      },
    );
  }
}
