import 'package:flutter/material.dart';
import 'package:flutter_website/navigation/fade_page.dart';
import 'package:flutter_website/views/pages/about/about_page.dart';
import 'package:flutter_website/views/pages/coding/coding_page.dart';
import 'package:flutter_website/views/pages/contact/contact_page.dart';
import 'package:flutter_website/views/pages/home/home_page.dart';
import 'package:flutter_website/views/pages/music/music_page.dart';

final homePageConfig = PageConfig(
  path: '/',
  page: const FadePage(
    child: HomePage(),
  ),
);
final musicPageConfig = PageConfig(
  path: '/music',
  page: const FadePage(
    child: MusicPage(),
  ),
);
final contactPageConfig = PageConfig(
  path: '/contact',
  page: const FadePage(
    child: ContactPage(),
  ),
);
final codingPageConfig = PageConfig(
  path: '/coding',
  page: const FadePage(
    child: CodingPage(),
  ),
);
final aboutPageConfig = PageConfig(
  path: '/about',
  page: const FadePage(
    child: AboutPage(),
  ),
);
final unknownPageConfig = PageConfig(
  path: '/404',
  page: const FadePage(
    child: Scaffold(
      body: Text('Unknown!'),
    ),
  ),
);

class PageConfig {
  String path;
  Page page;

  PageConfig({
    required this.path,
    required this.page,
  });
}
