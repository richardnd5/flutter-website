import 'package:flutter/material.dart';
import 'package:flutter_website/expanding_home_page.dart';
import 'package:flutter_website/navigation/page_config.dart';
import 'package:flutter_website/views/newHomePage/expandingHomePage2/expanding_home_page2.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'animated_button.dart';
import 'navigation/nav_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

enum Pages { about, games, music, apps }

class _HomePageState extends State<HomePage> {
  int? selectedCard;
  Pages? selectedPage;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double maxWidth = size.width / 3 > 200 ? 200 : size.width / 3;
    // var boxSize = Size(maxWidth, maxWidth);
    var boxSize = Size(100, 100);
    double iconSize = maxWidth * 0.16 < 48 ? 48 : maxWidth * 0.16;
    return ExpandingHomePage2();

    return Scaffold(
      body: Container(
        color: Colors.yellow,
        width: size.width,
        height: size.height,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Color(0xFF65b59a), Color(0xFF243363)],
            ),
          ),
          height: 400,
          width: size.width > 400 ? 400 : size.width,
          child: SingleChildScrollView(
            child: ListView(
              shrinkWrap: true,
              children: [
                // SizedBox(height: 48),
                // //Header
                // SizedBox(height: 48),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedButton(
                      AnimatedContainer(
                        duration: Duration(milliseconds: 400),
                        // width: 400,
                        // width: selectedPage == Pages.about
                        //     ? size.width
                        //     : boxSize.width,
                        // height: boxSize.height,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.red,
                              Colors.blue,
                            ],
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: FaIcon(
                          FontAwesomeIcons.question,
                          color: Colors.white54,
                          size: iconSize,
                        ),
                      ),
                      size: selectedPage == Pages.about ? size : boxSize,
                      buttonUp: () {
                        print('button pressed!');
                        setState(() => selectedPage == Pages.about
                            ? null
                            : selectedPage = Pages.about);
                      },
                    ),
                    AnimatedButton(
                      FaIcon(
                        FontAwesomeIcons.gamepad,
                        color: Colors.white,
                        size: iconSize,
                      ),
                      size: boxSize,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedButton(
                      FaIcon(
                        FontAwesomeIcons.music,
                        color: Colors.white,
                        size: iconSize,
                      ),
                      size: boxSize,
                      buttonUp: () =>
                          Provider.of<NavState>(context, listen: false)
                              .addPage(musicPageConfig),
                    ),
                    AnimatedButton(
                      FaIcon(
                        FontAwesomeIcons.code,
                        color: Colors.white,
                        size: iconSize,
                      ),
                      size: boxSize,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
