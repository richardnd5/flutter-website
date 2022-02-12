import 'package:flutter/material.dart';
import 'package:flutter_website/navigation/nav_state.dart';
import 'package:provider/provider.dart';

class NavRouterDelegate extends RouterDelegate<PageConfig>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<PageConfig> {
  static of(BuildContext context) => context.watch<NavRouterDelegate>();
  NavState state;

  @override
  PageConfig? get currentConfiguration => state.pages.last;

  NavRouterDelegate(this.state) {
    state.addListener(notifyListeners);
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: state.getPages(),
      onPopPage: (route, result) => false,
    );
  }

  @override
  Future<void> setNewRoutePath(PageConfig configuration) async {
    return;
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey =>
      GlobalObjectKey<NavigatorState>(this);
}
