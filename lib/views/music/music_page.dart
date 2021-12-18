import 'package:flutter/material.dart';
import 'package:flutter_website/views/coding/coding_page.dart';
import 'package:flutter_website/views/coding/components/icon_text_button.dart';
import 'package:flutter_website/views/common/inner_page_container.dart';
import 'package:flutter_website/views/music/music_page_new.dart';

import '../home/home_page_view_model.dart';

class MusicPage extends StatelessWidget {
  const MusicPage({Key? key}) : super(key: key);
  final pageType = PageType.music;

  Widget build(BuildContext context) {
    return InnerPageContainer(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: GridView.count(
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
        ),
      ),
    );
  }
}
