import 'package:flutter/material.dart';
import 'package:flutter_website/navigation/page_configs.dart';

export 'package:flutter_website/navigation/page_configs.dart';

enum CustomPages { home, pixel, gameOfLife, ticTacToe, pendulum }

class NavState extends ChangeNotifier {
  NavState();
  List<PageConfig> pages = [homePageConfig];
  List<PageConfig> pixelPages = [homePageConfig, pixelPageConfig];
  List<PageConfig> gameOfLifePages = [homePageConfig, gameOfLifePageConfig];
  List<PageConfig> ticTacToePages = [homePageConfig, ticTacToePageConfig];
  List<PageConfig> pendulumPages = [homePageConfig, pendulumPageConfig];

  bool showPixel = false;

  CustomPages selectedPage = CustomPages.home;

  List<Page> getPages() {
    switch (selectedPage) {
      case CustomPages.home:
        return [homePageConfig.page];
      case CustomPages.pixel:
        return pixelPages.map((e) => e.page).toList();
      case CustomPages.gameOfLife:
        return gameOfLifePages.map((e) => e.page).toList();
      case CustomPages.ticTacToe:
        return ticTacToePages.map((e) => e.page).toList();
      case CustomPages.pendulum:
        return pendulumPages.map((e) => e.page).toList();
    }
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
    } else if (config == ticTacToePageConfig) {
      selectedPage = CustomPages.ticTacToe;
    } else if (config == pendulumPageConfig) {
      selectedPage = CustomPages.pendulum;
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
