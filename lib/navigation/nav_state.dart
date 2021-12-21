import 'package:flutter/material.dart';
import 'package:flutter_website/navigation/nav_router_delegate.dart';
import 'package:flutter_website/navigation/page_configs.dart';
import 'package:flutter_website/views/pages/coding/coding_page.dart';
export 'package:flutter_website/navigation/page_configs.dart';

class NavState extends ChangeNotifier {
  NavState();
  List<PageConfig> pages = [homePageConfig];
  List<PageConfig> pixelPages = [homePageConfig, pixelPageConfig];

  bool _showPixel = false;

  bool get showPixel => _showPixel;

  set showPixel(bool pixel) {
    _showPixel = pixel;
  }

  List<Page> getPages() {
    return showPixel
        ? pixelPages.map((e) => e.page).toList()
        : [homePageConfig.page];
  }

  setNewRoutePath(PageConfig config) {
    // pages.clear();
    pages.add(config);
    notifyListeners();
  }

  goTo(PageConfig config) {
    if (config == pixelPageConfig) {
      showPixel = true;
      notifyListeners();
      print('pixel!');
    } else {
      showPixel = false;
      notifyListeners();
      print('pixel off!');
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
