import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_website/navigation/nav_router_delegate.dart';
import 'package:flutter_website/navigation/nav_state.dart';

class NavRouteParser extends RouteInformationParser<PageConfig> {
  NavState state;
  NavRouteParser(this.state);
  @override
  Future<PageConfig> parseRouteInformation(RouteInformation routeInformation) {
    print('parse route information');
    Uri? uri = Uri.tryParse(routeInformation.location ?? '');

    if (uri?.pathSegments.isEmpty == true) {
      state.pages.clear();
      state.pages.add(homePageConfig);
      return SynchronousFuture(homePageConfig);
    }

    if (uri!.pathSegments.length == 1) {
      if (uri.pathSegments.elementAt(1) == 'music') {
        print('found music returning it');
        state.pages.clear();
        state.pages.add(musicPageConfig);
        return SynchronousFuture(musicPageConfig);
      } else {
        print('found unknown');
        state.pages.clear();
        state.pages.add(unknownPageConfig);
        return SynchronousFuture(unknownPageConfig);
      }
    }
    print('found unknown after all conditionals');
    return SynchronousFuture(unknownPageConfig);
  }

  @override
  RouteInformation? restoreRouteInformation(PageConfig configuration) {
    return RouteInformation(location: configuration.path);
  }
}
