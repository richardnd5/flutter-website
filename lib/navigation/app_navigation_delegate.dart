import 'package:flutter/material.dart';
import 'package:flutter_website/expanding_home_page.dart';
import 'package:flutter_website/home_page.dart';
import 'package:flutter_website/navigation/nav_state.dart';
import 'package:flutter_website/expanding_page.dart';
import 'package:flutter_website/navigation/page_config.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

class AppNavigationDelegate extends RouterDelegate<PageConfig>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<PageConfig> {
  NavState navState;

  @override
  GlobalKey<NavigatorState> get navigatorKey => navState.navigatorKey;

  AppNavigationDelegate({required this.navState}) {
    navState.addListener(() {
      // print('nav state listener!!!');
      notifyListeners();
    });
  }

  @override
  PageConfig get currentConfiguration {
    print('getting current config from delegate');
    // return navState.configList.last;
    return navState.currentConfig;
  }

  @override
  Widget build(BuildContext context) {
    var nav = context.watch<NavState>();
    // print('delegate build called');
    return Navigator(
      key: nav.navigatorKey,
      pages: nav.getPageStack(),
      onPopPage: (route, result) {
        // print('on pop page');
        nav.pop();
        return route.didPop(result);
      },
    );
  }

  @override
  Future<void> setNewRoutePath(PageConfig config) async {
    print('set new route path ${config.path}');
    // navState.configList.clear();
    // navState.addPage(config);
    // navState.currentConfig = config;
    navState.currentConfig = config;
    notifyListeners();
  }
}
