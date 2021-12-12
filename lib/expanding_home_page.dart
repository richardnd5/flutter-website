import 'package:flutter/material.dart';
import 'package:flutter_website/music_page.dart';
import 'expanding_page.dart';
// import 'dart:html' as html;
// import 'dart:ui' as ui;

enum SelectedKudo { school, funny, nsfw }

class ExpandingHomePage extends StatefulWidget {
  const ExpandingHomePage({Key? key}) : super(key: key);

  @override
  _ExpandingHomePageState createState() => _ExpandingHomePageState();
}

class _ExpandingHomePageState extends State<ExpandingHomePage> {
  bool selected = false;

  SelectedKudo? selectedKudo;
  GlobalKey containerKey = GlobalKey();
  Widget? selectedWidget;

  @override
  void initState() {
    super.initState();
  }

  handleKudoTapped(SelectedKudo kudo) {
    setState(() {
      selectedKudo = selectedKudo == kudo ? null : kudo;
    });
  }

  handleTap(TapUpDetails details, Color color) {
    setState(() {
      selectedWidget = ExpandingPage(
        color: color,
        shrinkFinished: destroyWidget,
        startOffset: details.globalPosition,
        child: MusicPage2(),
      );
    });
  }

  destroyWidget() {
    setState(() {
      selectedWidget = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTapUp: (details) => handleTap(details, Colors.lightBlue),
                    child: Container(color: Colors.lightBlue),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTapUp: (details) => handleTap(details, Colors.green),
                    child: Container(color: Colors.green),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTapUp: (details) => handleTap(details, Colors.purple),
                    child: Container(color: Colors.purple),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTapUp: (details) => handleTap(details, Colors.cyan),
                    child: Container(color: Colors.cyan),
                  ),
                ),
              ],
            ),
            selectedWidget ?? Container()
          ],
        ),
      ),
    );
  }
}
