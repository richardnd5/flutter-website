import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_website/navigation/nav_state.dart';

class NavRouterDelegate extends RouterDelegate<PageConfig>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<PageConfig> {
  NavState state;

  @override
  PageConfig? get currentConfiguration => state.pages.last;

  NavRouterDelegate(this.state) {
    state.addListener(() {
      notifyListeners();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: state.getPages(),
      onPopPage: (route, result) => false,
    );
  }

  // @override
  // GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // GlobalKey<NavigatorState> get navigatorKey =>
  //     GlobalObjectKey<NavigatorState>(this);

  @override
  Future<void> setNewRoutePath(PageConfig configuration) async {
    print('set new route path');
    // state.setNewRoutePath(configuration);
  }

  @override
  // TODO: implement navigatorKey
  GlobalKey<NavigatorState>? get navigatorKey =>
      GlobalObjectKey<NavigatorState>(this);
}

class PageConfig {
  String path;
  Page page;

  PageConfig({required this.path, required this.page});
}
