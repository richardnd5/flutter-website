import 'package:flutter/material.dart';
import 'expanding_page.dart';
import 'package:flutter_website/web_stubs.dart'
    if (dart.library.html) 'dart:html' as html;
// import 'dart:html' as html;
import 'dart:ui' as ui;

class VideoUrls {
  static const fred =
      'https://player.vimeo.com/video/614950523?h=835c83b140&amp;badge=0&amp;autopause=0&amp;player_id=0&amp;app_id=58479';
  static const home =
      'https://player.vimeo.com/video/614963762?h=a647c2a7b3&amp;badge=0&amp;autopause=0&amp;player_id=0&amp;app_id=58479';

  static const padThai =
      'https://player.vimeo.com/video/614964673?h=1bbeefc4de&amp;badge=0&amp;autopause=0&amp;player_id=0&amp;app_id=58479';
  static const nunc =
      'https://player.vimeo.com/video/614963851?h=650f6fcac4&amp;badge=0&amp;autopause=0&amp;player_id=0&amp;app_id=58479';

  static const forUntoUs =
      'https://player.vimeo.com/video/614963741?h=141955f728&amp;badge=0&amp;autopause=0&amp;player_id=0&amp;app_id=58479';
}

class MusicPage2 extends StatelessWidget {
  const MusicPage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: [
          VimeoVideo(height: 300, url: VideoUrls.fred),
          VimeoVideo(height: 300, url: VideoUrls.home),
          VimeoVideo(height: 300, url: VideoUrls.padThai),
          VimeoVideo(height: 300, url: VideoUrls.forUntoUs),
          VimeoVideo(height: 300, url: VideoUrls.nunc),
          // HtmlElementView(viewType: viewID),
          // HtmlElementView(viewType: viewID)
        ],
      ),
    );
  }
}

class VimeoVideo extends StatelessWidget {
  const VimeoVideo({
    Key? key,
    required this.url,
    this.width,
    this.height,
  }) : super(key: key);

  final String url;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    // String viewID = "your-view-id";

    // return Text('what?');

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      url,
      (int id) => html.IFrameElement()
        ..width = MediaQuery.of(context).size.width.toString()
        ..height = MediaQuery.of(context).size.height.toString()
        ..src = url
        ..style.border = 'none',
    );

    return SizedBox(
      width: width,
      height: height,
      child: HtmlElementView(viewType: url),
    );
  }
}
