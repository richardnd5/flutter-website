// import 'dart:html';

import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_website/navigation/nav_router_delegate.dart';
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

    final spinner = document.getElementsByClassName('spinner');
    if (spinner.isNotEmpty) spinner.first.remove();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Nathan's Website",
      routeInformationParser: NavRouteParser.of(context),
      routerDelegate: NavRouterDelegate.of(context),
      theme: ThemeData(
        textTheme: GoogleFonts.reemKufiTextTheme(Theme.of(context).textTheme),
      ),
    );
  }
}
