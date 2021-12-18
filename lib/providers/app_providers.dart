import 'package:flutter/material.dart';
import 'package:flutter_website/app.dart';
import 'package:flutter_website/navigation/nav_route_parser.dart';
import 'package:flutter_website/navigation/nav_router_delegate.dart';
import 'package:flutter_website/navigation/nav_state.dart';
import 'package:flutter_website/views/pages/home/home_page_view_model.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

final appProviders = [
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
      parser!.state = state;
      return parser;
    },
  ),
];
