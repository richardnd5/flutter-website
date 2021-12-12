import 'package:flutter/material.dart';
import 'package:flutter_website/navigation/nav_router_delegate.dart';
import 'package:provider/provider.dart';

import 'navigation/nav_route_parser.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: Provider.of<NavRouteParser>(context),
      routerDelegate: Provider.of<NavRouterDelegate>(context),
    );
  }
}
