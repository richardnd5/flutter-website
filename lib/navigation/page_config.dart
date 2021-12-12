import 'package:flutter/material.dart';
import 'package:flutter_website/home_page.dart';
import 'package:flutter_website/music_page.dart';
import 'package:flutter_website/views/fade_page.dart';

const homePageConfig = PageConfig(
  '/',
  FadePage(
    child: HomePage(),
    // key: ValueKey('homePage'),
  ),
);

const musicPageConfig = PageConfig(
  '/music',
  FadePage(
    child: MusicPage2(),
    key: ValueKey('musicPage'),
  ),
);
const codingPageConfig = PageConfig(
  '/coding',
  FadePage(
    child: Text('Coding'),
    key: ValueKey('musicPage'),
  ),
);
PageConfig unknown(String path) => PageConfig(
      path,
      FadePage(
        // child: Text('Not Found'),
        key: ValueKey(path),
      ),
    );

class PageConfig {
  final String path;
  final Page page;

  const PageConfig(this.path, this.page);
}
