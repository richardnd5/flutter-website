import 'package:flutter/material.dart';
import 'package:flutter_website/navigation/nav_state.dart';

class AppBackButtonDispatcher extends RootBackButtonDispatcher {
  final NavState nav;

  AppBackButtonDispatcher(this.nav);
  @override
  Future<bool> didPopRoute() {
    print('did pop route');
    return nav.handleBackButton();
  }
}
