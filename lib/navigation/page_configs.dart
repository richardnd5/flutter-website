import 'package:flutter/material.dart';
import 'package:flutter_website/navigation/fade_page.dart';
import 'package:flutter_website/navigation/nav_router_delegate.dart';
import 'package:flutter_website/views/about/about_page.dart';
import 'package:flutter_website/views/coding/coding_page.dart';
import 'package:flutter_website/views/contact/contact_page.dart';
import 'package:flutter_website/views/home/home_page.dart';
import 'package:flutter_website/views/music/music_page.dart';

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
