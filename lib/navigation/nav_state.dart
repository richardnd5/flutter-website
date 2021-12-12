import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_website/home_page.dart';
import 'package:flutter_website/navigation/page_config.dart';

import '../expanding_home_page.dart';

class NavState extends ChangeNotifier {
  List<PageConfig> get configList => _configList;
  List<PageConfig> _configList = [];

  // PageConfig get currentConfig => _configList.last;
  PageConfig _currentConfig = homePageConfig;
  PageConfig get currentConfig => _currentConfig;

  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  NavState() {
    _configList.add(homePageConfig);
  }

  set currentConfig(PageConfig config) {
    // print('setting current config');
    _currentConfig = config;
    notifyListeners();
  }

  addPage(PageConfig config) {
    // print('add page');
    // _configList.add(config);
    _currentConfig = config;

    notifyListeners();
  }

  bool pop() {
    // print('pop');
    // if (_configList.length > 1) {
    //   _configList.removeLast();
    //   _currentConfig = _configList.last;
    //   notifyListeners();
    //   return true;
    // }

    return false;
  }

  Future<bool> handleBackButton() async {
    // print('handle back button');
    return pop();
  }

  List<Page> getPageStack() {
    return [_currentConfig.page];
    // print('page stack called');
    return configList.map((e) => e.page).toList();
  }
}
