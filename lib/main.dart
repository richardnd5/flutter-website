/*
Imagine a game with a flat 2d canvas.

You have a character that can walk it, and then own it.
*/

import 'package:flutter/material.dart';
import 'package:flutter_website/home_page.dart';
import 'package:flutter_website/navigation/nav_state.dart';
import 'package:flutter_website/views/newHomePage/expandingHomePage2/expanding_home_page_view_model.dart';
import 'package:provider/provider.dart';

import 'navigation/app_navigation_delegate.dart';
import 'navigation/app_navigation_parser.dart';
import 'navigation/back_button_dispatcher.dart';
import 'new_page.dart';

const String FlutterPageKey = 'flutterPageKey';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ExpandingHomePageViewModel(),
          lazy: false,
        ),
        ChangeNotifierProvider(create: (context) => NavState()),
        Provider(create: (context) => AppNavigationParser()),
        ChangeNotifierProxyProvider<NavState, AppNavigationDelegate>(
          create: (context) => AppNavigationDelegate(
            navState: Provider.of<NavState>(context, listen: false),
          ),
          update: (context, nav, delegate) => delegate!,
        ),
        ProxyProvider<NavState, AppBackButtonDispatcher>(
          create: (context) => AppBackButtonDispatcher(
            Provider.of<NavState>(context, listen: false),
          ),
          update: (context, nav, delegate) => delegate!,
        ),
      ],
      child: MaterialApp(home: MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: Provider.of<AppNavigationDelegate>(context),
      routeInformationParser: Provider.of<AppNavigationParser>(context),
      backButtonDispatcher: Provider.of<AppBackButtonDispatcher>(context),
    );
  }
}
