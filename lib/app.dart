// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_website/gameOfLife/views/pages/game_of_life_page.dart';
import 'package:flutter_website/navigation/nav_router_delegate.dart';
import 'package:flutter_website/pixel/views/pages/pixel_page.dart';
import 'package:flutter_website/polarPlay/polar_play_page.dart';
import 'package:flutter_website/stubs/web_stubs.dart';
import 'package:google_fonts/google_fonts.dart';
import 'navigation/nav_route_parser.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();

    // final loader = document.getElementsByClassName('loading');
    // if (loader.isNotEmpty) {
    //   print('removing');
    //   loader.first.remove();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PolarPlayPage(),
    );
    return MaterialApp.router(
      routeInformationParser: NavRouteParser.of(context),
      routerDelegate: NavRouterDelegate.of(context),
      theme: ThemeData(
        textTheme: GoogleFonts.reemKufiTextTheme(Theme.of(context).textTheme),
      ),
    );
  }
}
