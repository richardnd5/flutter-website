import 'package:flutter/material.dart';
import 'package:flutter_website/navigation/nav_router_delegate.dart';
import 'package:flutter_website/navigation/page_configs.dart';
import 'package:flutter_website/views/pages/coding/coding_page.dart';
export 'package:flutter_website/navigation/page_configs.dart';

enum CustomPages { home, pixel, gameOfLife }

class NavState extends ChangeNotifier {
  NavState();
  List<PageConfig> pages = [homePageConfig];
  List<PageConfig> pixelPages = [homePageConfig, pixelPageConfig];
  List<PageConfig> gameOfLifePages = [homePageConfig, gameOfLifePageConfig];

  bool _showPixel = false;
  bool get showPixel => _showPixel;
  set showPixel(bool pixel) {
    _showPixel = pixel;
  }

  CustomPages selectedPage = CustomPages.home;

  List<Page> getPages() {
    switch (selectedPage) {
      case CustomPages.home:
        return [homePageConfig.page];
      case CustomPages.pixel:
        return pixelPages.map((e) => e.page).toList();
      case CustomPages.gameOfLife:
        return gameOfLifePages.map((e) => e.page).toList();
    }

    // return showPixel
    //     ? pixelPages.map((e) => e.page).toList()
    //     : [homePageConfig.page];
  }

  setNewRoutePath(PageConfig config) {
    pages.add(config);
    notifyListeners();
  }

  goTo(PageConfig config) {
    if (config == pixelPageConfig) {
      selectedPage = CustomPages.pixel;
    } else if (config == gameOfLifePageConfig) {
      selectedPage = CustomPages.gameOfLife;
    } else {
      selectedPage = CustomPages.home;
    }
    pages.add(config);
    notifyListeners();
  }

  pop() {
    if (pages.length > 1) {
      pages.removeLast();
      notifyListeners();
    }
  }
}
