import 'package:flutter/material.dart';
import 'package:flutter_website/navigation/fade_page.dart';
import 'package:flutter_website/navigation/nav_router_delegate.dart';
import 'package:flutter_website/views/home/about_page.dart';
import 'package:flutter_website/views/home/coding_page.dart';
import 'package:flutter_website/views/home/contact_page.dart';
import 'package:flutter_website/views/home/home_page.dart';
import 'package:flutter_website/views/home/music_page.dart';

class NavState extends ChangeNotifier {
  NavState();
  List<PageConfig> pages = [homePageConfig];

  List<Page> getPages() {
    return pages.map((e) => e.page).toList();
  }

  setNewRoutePath(PageConfig config) {
    pages.clear();
    pages.add(config);
    notifyListeners();
  }

  goTo(PageConfig config) {
    print('go to called');
    pages.add(config);
    notifyListeners();
  }
}

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
