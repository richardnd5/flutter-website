import 'package:flutter/material.dart';
import 'package:flutter_website/navigation/nav_router_delegate.dart';
import 'package:flutter_website/navigation/page_configs.dart';
export 'package:flutter_website/navigation/page_configs.dart';

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
    pages.add(config);
    notifyListeners();
  }
}
