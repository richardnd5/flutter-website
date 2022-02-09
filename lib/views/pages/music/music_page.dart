import 'package:flutter/material.dart';
import 'package:flutter_website/models/web_link_item.dart';
import 'package:flutter_website/views/pages/about/about_page.dart';
import 'package:flutter_website/views/pages/coding/components/icon_text_button.dart';
import 'package:flutter_website/views/pages/music/components/vimeo_video.dart';
import 'package:video_player/video_player.dart';
import '../home/home_page_view_model.dart';

class MusicPage extends StatefulWidget {
  const MusicPage({Key? key}) : super(key: key);

  @override
  State<MusicPage> createState() => _MusicPageState();
}

final soundCloudOption = WebLinkOption(
  url: 'https://soundcloud.com/just-noodlin',
  label: 'SoundCloud',
  asset: 'https://cdn2.iconfinder.com/data/icons/minimalism/512/soundcloud.png',
  isNetworkImage: true,
);

class _MusicPageState extends State<MusicPage> {
  VideoPlayerController? _controller;

  final pageType = PageType.music;
  bool controllerLoading = false;

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
      url: VideoUrls.fred,
      label: 'Fred',
      asset: 'assets/images/fred.png',
    ),
    soundCloudOption,
  ];

  WebLinkOption? selectedOption;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

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
        controllerLoading = true;
      });

      _controller = VideoPlayerController.network(selectedOption!.url)
        ..initialize().then((_) {
          setState(() {
            controllerLoading = false;
          });
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => setState(() => selectedOption = null),
      child: Stack(
        alignment: Alignment.center,
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
          IgnorePointer(
            ignoring: selectedOption == null,
            child: GestureDetector(
              onTap: () => setState(() => selectedOption = null),
              child: FadeInOnInitWidget(
                duration: const Duration(milliseconds: 200),
                isVisible: selectedOption != null,
                child: Container(
                  width: size.width,
                  height: size.height,
                  color: Colors.black.withOpacity(0.6),
                ),
              ),
            ),
          ),
          FadeInOnInitWidget(
            isVisible: controllerLoading && selectedOption != null,
            duration: const Duration(milliseconds: 60),
            child: const Center(child: CircularProgressIndicator()),
          ),
          if (selectedOption != null)
            Stack(
              children: [
                FadeInOnInitWidget(
                  isVisible: !controllerLoading,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (_controller != null &&
                          _controller!.value.isInitialized)
                        Container(
                          color: Colors.black.withOpacity(0.7),
                          child: AspectRatio(
                            aspectRatio: _controller!.value.size.height >
                                    _controller!.value.size.width
                                ? _controller!.value.size.height /
                                    _controller!.value.size.width
                                : _controller!.value.size.width /
                                    _controller!.value.size.height,
                            child: VideoPlayer(_controller!),
                          ),
                        ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          SizedBox(
                            height: 45,
                            width: 80,
                            child: ElevatedButton(
                              onPressed: () => setState(
                                () {
                                  _controller?.value.isPlaying == true
                                      ? _controller?.pause()
                                      : _controller?.play();
                                },
                              ),
                              child: Icon(
                                _controller?.value.isPlaying == true
                                    ? Icons.pause
                                    : Icons.play_arrow,
                              ),
                            ),
                          ),
                          if (_controller?.value.isInitialized == true)
                            Expanded(
                              child: SizedBox(
                                height: 45,
                                child: VideoProgressIndicator(
                                  _controller!,
                                  allowScrubbing: true,
                                  padding: EdgeInsets.zero,
                                ),
                              ),
                            ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
