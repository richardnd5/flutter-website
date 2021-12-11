import 'package:flutter/material.dart';
import 'package:flutter_website/navigation/page_config.dart';

class AppNavigationParser extends RouteInformationParser<PageConfig> {
  @override
  Future<PageConfig> parseRouteInformation(
      RouteInformation routeInformation) async {
    var uri = Uri.parse(routeInformation.location!);
    // print('parse route information');

    if (uri.pathSegments.length == 0) {
      // print('returns no path segments');
      return homePageConfig;
    } else if (uri.pathSegments[1].contains('music')) {
      // print('returns music');

      return musicPageConfig;
    }

    // print('returns unknown');
    return unknown(routeInformation.location ?? 'not-found');
  }

  @override
  RouteInformation? restoreRouteInformation(PageConfig config) {
    return RouteInformation(location: config.path);
  }
}
