import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_website/navigation/nav_router_delegate.dart';
import 'package:flutter_website/navigation/nav_state.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'home_page_view_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final double smallPercent = 0.1;
  final double largeHeight = 0.8;
  final double largeWidth = 0.9;

  @override
  void initState() {
    super.initState();
  }

  goToPage(BuildContext context, PageType type) {
    PageConfig selectedConfig;
    switch (type) {
      case PageType.coding:
        selectedConfig = codingPageConfig;
        break;
      case PageType.about:
        selectedConfig = aboutPageConfig;
        break;
      case PageType.music:
        selectedConfig = musicPageConfig;
        break;
      case PageType.contact:
        selectedConfig = contactPageConfig;
        break;
    }

    Provider.of<HomePageViewModel>(context, listen: false).selectedPage = type;
    Provider.of<NavState>(context, listen: false).goTo(selectedConfig);
  }

  @override
  Widget build(BuildContext context) {
    var watched = context.watch<HomePageViewModel>();
    return Stack(
      children: [
        GestureDetector(
          onTap: () => watched.selectedPage = null,
          child: Container(
            decoration: pageGradient(
              Color(0xff7a8ae6),
              Color(0xFF0b1652),
            ),
          ),
        ),
        _buildHomePageCell(context, PageType.about, Alignment.topLeft),
        _buildHomePageCell(context, PageType.music, Alignment.topRight),
        _buildHomePageCell(context, PageType.coding, Alignment.bottomLeft),
        _buildHomePageCell(context, PageType.contact, Alignment.bottomRight),
      ],
    );
  }

  AnimatedAlign _buildHomePageCell(
    BuildContext context,
    PageType type,
    Alignment deselectedAlignment,
  ) {
    var size = MediaQuery.of(context).size;
    var watched = context.watch<HomePageViewModel>();

    var animDuration = Duration(milliseconds: 400);
    var curve = Curves.easeIn;
    return AnimatedAlign(
      duration: animDuration,
      curve: curve,
      alignment:
          watched.selectedPage == type ? Alignment.center : deselectedAlignment,
      child: GestureDetector(
        onTap: () => goToPage(context, type),
        child: AnimatedContainer(
            duration: animDuration,
            curve: curve,
            width: watched.selectedPage == null
                ? size.width / 2
                : size.width *
                    (watched.selectedPage == type ? largeWidth : smallPercent),
            height: watched.selectedPage == null
                ? size.height / 2
                : size.height *
                    (watched.selectedPage == type ? largeHeight : smallPercent),
            child: Material(
              child: Container(
                color: type.getPageColor(),
                child: AnimatedPadding(
                  duration: animDuration,
                  curve: curve,
                  padding: EdgeInsets.only(
                      top: watched.selectedPage == type ? 16 : 0),
                  child: AnimatedAlign(
                    duration: animDuration,
                    curve: curve,
                    alignment: watched.selectedPage == type
                        ? Alignment.topCenter
                        : Alignment.center,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          FaIcon(type.getIcon()),
                          AnimatedOpacity(
                            duration: animDuration,
                            curve: curve,
                            opacity: watched.selectedPage == type ? 1.0 : 0,
                            child: AnimatedContainer(
                              duration: animDuration,
                              curve: curve,
                              height: watched.selectedPage == type
                                  ? size.height
                                  : 0,
                              child: type.getPageWidget(),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )),
      ),
    );
  }
}

pageGradient(Color color1, Color color2) => BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [color1, color2],
      ),
    );
