import 'package:flutter/material.dart';
import 'package:flutter_website/navigation/nav_router_delegate.dart';
import 'navigation/nav_route_parser.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: NavRouteParser.of(context),
      routerDelegate: NavRouterDelegate.of(context),
    );
  }
}
