import 'package:flutter/material.dart';
import 'package:flutter_website/views/inner_page_container.dart';

import '../home/home_page_view_model.dart';

class MusicPage extends StatelessWidget {
  const MusicPage({Key? key}) : super(key: key);
  final pageType = PageType.music;

  Widget build(BuildContext context) {
    return InnerPageContainer(
      child: Column(
        children: [
          Text('Music Page'),
        ],
      ),
    );
  }
}
