import 'package:flutter/material.dart';

import 'home_page_view_model.dart';

class MusicPage extends StatelessWidget {
  const MusicPage({Key? key}) : super(key: key);
  final pageType = PageType.music;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageType.getPageColor(),
      body: Center(
        child: Text('Music Page'),
      ),
    );
  }
}
