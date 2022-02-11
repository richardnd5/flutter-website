import 'package:flutter/material.dart';
import 'package:flutter_website/models/web_link_item.dart';
import 'package:flutter_website/navigation/nav_state.dart';
import 'package:provider/provider.dart';

import 'components/icon_text_button.dart';

final gitHub = WebLinkOption(
  url: 'https://github.com/richardnd5',
  asset: 'assets/images/github.png',
  label: 'Github',
);
final sStories = WebLinkOption(
  url: 'https://apps.apple.com/us/app/sstories/id1455299421?ign-mpt=uo%3D2',
  asset: 'assets/images/sStoriesReduced.jpg',
  label: 'sStories',
);
final csa = WebLinkOption(
  url: 'https://apps.apple.com/ph/app/carls-sporting-adventure/id1467429782',
  asset: 'assets/images/CSA.jpg',
  label: "Carl's Sporting Adventure",
);
final pixel = WebLinkOption(
  url: '',
  asset: 'assets/images/pixel.png',
  label: "Pixel",
);
final gameOfLife = WebLinkOption(
  url: '',
  asset: 'assets/images/pixel.png',
  label: "Game of Life",
);
final ticTacToe = WebLinkOption(
  url: '',
  asset: 'assets/images/ticTacToe.png',
  label: "TicTacToe",
);

final optionList = [
  sStories,
  csa,
  gitHub,
  ticTacToe,
  pixel,
  gameOfLife,
];

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

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: getCrossAxisCount(size.width),
          mainAxisExtent: 150,
        ),
        itemCount: optionList.length,
        itemBuilder: (_, index) {
          return IconTextButton(
            assetPath: optionList[index].asset,
            label: optionList[index].label,
            onTap: () {
              if (optionList[index] == pixel) {
                Provider.of<NavState>(context, listen: false)
                    .goTo(pixelPageConfig);
              } else if (optionList[index] == gameOfLife) {
                Provider.of<NavState>(context, listen: false)
                    .goTo(gameOfLifePageConfig);
              } else if (optionList[index] == ticTacToe) {
                Provider.of<NavState>(context, listen: false)
                    .goTo(ticTacToePageConfig);
              } else {
                launchURL(optionList[index].url);
              }
            },
          );
        },
      ),
    );
  }
}
