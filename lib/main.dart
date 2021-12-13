import 'package:flutter/material.dart';
import 'package:flutter_website/app.dart';
import 'package:flutter_website/navigation/nav_route_parser.dart';
import 'package:flutter_website/navigation/nav_router_delegate.dart';
import 'package:flutter_website/views/home/home_page_view_model.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

import 'navigation/nav_state.dart';

void main() {
  setPathUrlStrategy();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => NavState(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (context) => HomePageViewModel(),
          lazy: false,
        ),
        ChangeNotifierProxyProvider<NavState, NavRouterDelegate>(
          create: (context) => NavRouterDelegate(
            Provider.of<NavState>(context, listen: false),
          ),
          update: (context, state, delegate) {
            print('update state called');
            delegate!.state = state;
            return delegate;
          },
        ),
        ProxyProvider2<NavState, HomePageViewModel, NavRouteParser>(
          create: (context) => NavRouteParser(
            Provider.of<NavState>(context, listen: false),
            Provider.of<HomePageViewModel>(context, listen: false),
          ),
          update: (context, state, vm, parser) {
            print('update state called');
            parser!.state = state;
            return parser;
          },
        ),
      ],
      child: const App(),
    ),
  );
}
