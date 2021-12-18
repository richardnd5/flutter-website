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

  var optionList = [
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

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisExtent: 120,
      ),
      itemCount: optionList.length,
      itemBuilder: (_, index) {
        return IconTextButton(
          imageSize: 120,
          assetPath: optionList[index].asset,
          label: optionList[index].label,
          onTap: () => launchURL(optionList[index].url),
        );
      },
    );
    // return LayoutBuilder(
    //   builder: (context, constraints) {
    //     double imageSize =
    //         constraints.maxWidth / 6 >= 120 ? 120 : constraints.maxWidth / 6;
    //     return InnerPageContainer(
    //       child: ListView(
    //         children: [
    //           Center(child: FaIcon(FontAwesomeIcons.code)),
    //           SizedBox(height: 32),
    //           GridView.builder(
    //             // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //             // crossAxisAlignment: CrossAxisAlignment.start,
    //             gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
    //                 maxCrossAxisExtent: 200,
    //                 childAspectRatio: 1,
    //                 crossAxisSpacing: 20,
    //                 mainAxisSpacing: 20),
    //             itemCount: optionList.length,
    //             itemBuilder: (_, index) {
    //               return IconTextButton(
    //                 imageSize: 60,
    //                 assetPath: optionList[index].asset,
    //                 label: optionList[index].label,
    //                 onTap: () => launchURL(optionList[index].url),
    //               );
    //             },
    //           ),
    //         ],
    //       ),
    //     );
    //   },
    // );
  }
}
