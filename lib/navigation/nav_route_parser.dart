import 'package:flutter/material.dart';
import 'package:flutter_website/navigation/nav_state.dart';
import 'package:flutter_website/views/pages/home/home_page_view_model.dart';
import 'package:provider/provider.dart';

class NavRouteParser extends RouteInformationParser<PageConfig> {
  static of(BuildContext context) => context.watch<NavRouteParser>();

  NavState state;
  HomePageViewModel vm;
  NavRouteParser(this.state, this.vm);
  @override
  Future<PageConfig> parseRouteInformation(RouteInformation routeInformation) {
    return setPageConfig(vm, state, routeInformation);
  }

  @override
  RouteInformation? restoreRouteInformation(PageConfig configuration) {
    return RouteInformation(location: configuration.path);
  }
}
