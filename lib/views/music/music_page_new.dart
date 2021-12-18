import 'package:flutter/material.dart';
import 'package:flutter_website/stubs/web_stubs.dart'
    if (dart.library.html) 'dart:html' as html;
// import 'dart:html' as html;
import 'dart:ui' as ui;

class VideoUrls {
  static const fred =
      'https://player.vimeo.com/video/614950523?h=835c83b140&amp;badge=0&amp;autopause=0&amp;player_id=0&amp;app_id=58479&amp;';
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
    return ListView(
      children: [
        VimeoVideo(height: 300, url: VideoUrls.padThai),
        VimeoVideo(height: 300, url: VideoUrls.fred),
        VimeoVideo(height: 300, url: VideoUrls.home),
        VimeoVideo(height: 300, url: VideoUrls.forUntoUs),
        VimeoVideo(height: 300, url: VideoUrls.nunc),
      ],
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
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      url,
      (int id) => html.IFrameElement()
        ..src = url
        ..style.border = 'none'
        ..style.width = '100%'
        ..style.height = '100%',
    );

    return SizedBox(
      width: width,
      height: height,
      child: HtmlElementView(viewType: url),
    );
  }
}
