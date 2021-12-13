import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_website/navigation/nav_router_delegate.dart';
import 'package:flutter_website/navigation/nav_state.dart';
import 'package:flutter_website/views/home/home_page_view_model.dart';

class NavRouteParser extends RouteInformationParser<PageConfig> {
  NavState state;
  HomePageViewModel vm;
  NavRouteParser(this.state, this.vm);
  @override
  Future<PageConfig> parseRouteInformation(RouteInformation routeInformation) {
    print('parse route information');
    Uri? uri = Uri.tryParse(routeInformation.location ?? '');

    if (uri?.pathSegments.isEmpty == true) {
      state.pages.add(homePageConfig);

      if (vm.selectedPage != null) {
        vm.selectedPage = null;
      }
      return SynchronousFuture(homePageConfig);
    }
    if (uri?.pathSegments.length == 1) {
      state.pop();
      if (uri?.pathSegments[0].contains('music') == true) {
        vm.selectedPage = PageType.music;
        return SynchronousFuture(musicPageConfig);
      }
      if (uri?.pathSegments[0].contains('contact') == true) {
        vm.selectedPage = PageType.contact;
        return SynchronousFuture(contactPageConfig);
      }
      if (uri?.pathSegments[0].contains('coding') == true) {
        vm.selectedPage = PageType.coding;
        return SynchronousFuture(codingPageConfig);
      }
      if (uri?.pathSegments[0].contains('about') == true) {
        vm.selectedPage = PageType.about;
        return SynchronousFuture(aboutPageConfig);
      }
    }
    return SynchronousFuture(unknownPageConfig);
  }

  @override
  RouteInformation? restoreRouteInformation(PageConfig configuration) {
    return RouteInformation(location: configuration.path);
  }
}
