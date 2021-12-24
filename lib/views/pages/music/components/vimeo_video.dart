import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_website/stubs/web_stubs.dart'
    if (dart.library.html) 'dart:html' as html;
import 'package:flutter_website/stubs/ui_stubs.dart'
    if (dart.library.html) 'dart:ui' as ui;
// import 'dart:html' as html;
// import 'dart:ui' as ui;

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

class VimeoVideo extends StatefulWidget {
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
  State<VimeoVideo> createState() => _VimeoVideoState();
}

class _VimeoVideoState extends State<VimeoVideo> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // if (kIsWeb) {
    //   // ignore: undefined_prefixed_name
    //   ui.platformViewRegistry.registerViewFactory(
    //     widget.url,
    //     (int id) => html.IFrameElement()
    //       ..src = widget.url
    //       ..style.border = 'none'
    //       ..style.width = '100vw'
    //       ..style.height = '50vh',
    //   );
    // }

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: HtmlElementView(
        key: UniqueKey(),
        viewType: widget.url,
      ),
    );
  }
}
