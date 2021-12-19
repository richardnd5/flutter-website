import 'package:flutter/material.dart';
import 'package:flutter_website/models/web_link_item.dart';
import 'package:flutter_website/views/pages/coding/components/icon_text_button.dart';
import 'package:flutter_website/views/pages/home/components/expanding_page_container.dart';
import 'package:flutter_website/views/pages/music/components/vimeo_video.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:ui' as ui;

import '../home/home_page_view_model.dart';

class MusicPage extends StatefulWidget {
  const MusicPage({Key? key}) : super(key: key);

  @override
  State<MusicPage> createState() => _MusicPageState();
}

// VimeoVideo(height: 400, url: VideoUrls.padThai),
// VimeoVideo(height: 400, url: VideoUrls.fred),
// VimeoVideo(height: 400, url: VideoUrls.home),
// VimeoVideo(height: 400, url: VideoUrls.forUntoUs),
// VimeoVideo(height: 400, url: VideoUrls.nunc),

final soundCloudOption = WebLinkOption(
  url: 'https://soundcloud.com/just-noodlin',
  label: 'SoundCloud',
  asset: 'https://cdn2.iconfinder.com/data/icons/minimalism/512/soundcloud.png',
  isNetworkImage: true,
);

class _MusicPageState extends State<MusicPage> {
  final pageType = PageType.music;

  final List<WebLinkOption> optionList = [
    WebLinkOption(
      url: VideoUrls.padThai,
      label: 'Pad Thai',
      asset: 'assets/images/padThai.png',
    ),
    WebLinkOption(
      url: VideoUrls.home,
      label: 'Home',
      asset: 'assets/images/home.png',
    ),
    WebLinkOption(
      url: VideoUrls.nunc,
      label: 'Nunc dimittis',
      asset: 'assets/images/nunc.png',
    ),
    WebLinkOption(
      url: VideoUrls.fred,
      label: 'Fred',
      asset: 'assets/images/fred.png',
    ),
    soundCloudOption,
  ];

  WebLinkOption? selectedOption;

  // Widget build(BuildContext context) {
  int getCrossAxisCount(double width) {
    if (width < 600) return 2;
    if (width < 800) return 3;
    if (width < 1000) return 4;
    return 5;
  }

  _handleTap(WebLinkOption option) {
    if (option == soundCloudOption) {
      launchURL(option.url);
    } else {
      setState(() {
        selectedOption = option;
      });
    }
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: GridView.builder(
            padding: EdgeInsets.zero,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: getCrossAxisCount(size.width),
              mainAxisExtent: 150,
            ),
            itemCount: optionList.length,
            itemBuilder: (_, index) {
              return IconTextButton(
                assetPath: optionList[index].asset,
                label: optionList[index].label,
                onTap: () => _handleTap(optionList[index]),
                isNetworkImage: optionList[index].isNetworkImage,
                backgroundColor: optionList[index].isNetworkImage
                    ? Colors.white
                    : Colors.transparent,
              );
            },
          ),
        ),
        if (selectedOption != null)
          Expanded(
            child: AnimatedContainer(
              duration: HomePageViewModel.animDuration,
              curve: HomePageViewModel.curve,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        Container(
                          child: GestureDetector(
                            onTap: () => setState(() => selectedOption = null),
                            child: new BackdropFilter(
                              filter: new ui.ImageFilter.blur(
                                  sigmaX: 3.0, sigmaY: 3.0),
                              child: new Container(
                                decoration: new BoxDecoration(
                                  color: Colors.black.withOpacity(0.2),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: size.width,
                          height: size.height / 2,
                          child: VimeoVideo(
                            url: selectedOption!.url,
                            height: size.height / 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  GridView _buildVimeoGrid() {
    return GridView.count(
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      crossAxisCount: 2,
      children: [
        InkWell(
          onTap: () => launchURL('https://soundcloud.com/just-noodlin'),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              color: Colors.white,
              child: Image.network(
                'https://cdn2.iconfinder.com/data/icons/minimalism/512/soundcloud.png',
                width: 64,
                height: 64,
              ),
            ),
          ),
        ),
        VimeoVideo(height: 400, url: VideoUrls.padThai),
        VimeoVideo(height: 400, url: VideoUrls.fred),
        VimeoVideo(height: 400, url: VideoUrls.home),
        VimeoVideo(height: 400, url: VideoUrls.forUntoUs),
        VimeoVideo(height: 400, url: VideoUrls.nunc),
      ],
    );
  }
}
