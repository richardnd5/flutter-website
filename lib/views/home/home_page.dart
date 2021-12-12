import 'package:flutter/material.dart';
import 'package:flutter_website/navigation/nav_route_parser.dart';
import 'package:flutter_website/navigation/nav_router_delegate.dart';
import 'package:flutter_website/navigation/nav_state.dart';

import 'package:provider/provider.dart';
import 'home_page_view_model.dart';
import 'components/expanding_page_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey homeKey = GlobalKey();
  GlobalKey musicKey = GlobalKey();
  GlobalKey contactKey = GlobalKey();
  GlobalKey codingKey = GlobalKey();
  GlobalKey noKey = GlobalKey();

  Widget? selectedWidget;

  bool isAnimating = false;

  addPageToStack(BuildContext context, PageType type, Color color) async {
    PageConfig selectedPage;

    switch (type) {
      case PageType.coding:
        selectedPage = codingPageConfig;
        break;
      case PageType.about:
        selectedPage = aboutPageConfig;
        break;
      case PageType.music:
        selectedPage = musicPageConfig;
        break;
      case PageType.contact:
        selectedPage = contactPageConfig;
        break;
    }

    Provider.of<NavState>(context, listen: false).goTo(selectedPage);
    await Future.delayed(Duration(milliseconds: 800));
    _whenShrinkAnimFinished();
  }

  _handleSquareTap(
    BuildContext context,
    PageType type,
    Offset globalPos,
  ) {
    print(type);
    var size = MediaQuery.of(context).size;

    if (!isAnimating) {
      setState(() {
        isAnimating = true;
      });
      setState(() {
        selectedWidget = ExpandingPageContainer(
          startOffset: getPos(type.index),
          startSize: Size(size.width / 2, size.height / 2),
          shrinkFinished: _whenShrinkAnimFinished,
          animateFinished: () => addPageToStack(
            context,
            type,
            type.getPageColor(),
          ),
          color: type.getPageColor(),
          width: size.width,
        );
      });
    }
  }

  _whenShrinkAnimFinished() {
    setState(() {
      selectedWidget = null;
      isAnimating = false;
    });
  }

  GlobalKey getKey(int index) {
    if (index == 0) return homeKey;
    if (index == 1) return musicKey;
    if (index == 2) return contactKey;
    if (index == 3) return codingKey;
    return noKey;
  }

  Offset getPos(int index) {
    final box = getKey(index).currentContext!.findRenderObject() as RenderBox;
    return box.localToGlobal(Offset.zero);
  }

  List<Offset> getListOfOffsets(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return [
      Offset(0, 0),
      Offset(0, size.width / 2),
      Offset(size.height / 2, 0),
      Offset(size.height / 2, size.width / 2),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        buildBackground(context),
        selectedWidget ?? Container(),
      ],
    );
  }

  Widget buildBackground(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final offsetList = getListOfOffsets(context);
    return Stack(
      children: PageType.values
          .map(
            (e) => AnimatedPositioned(
              key: getKey(e.index),
              left: offsetList[e.index].dy,
              top: offsetList[e.index].dx,
              duration: Duration(milliseconds: 300),
              child: GestureDetector(
                onTapUp: (details) =>
                    _handleSquareTap(context, e, details.globalPosition),
                child: Container(
                  color: e.getPageColor(),
                  width: size.width / 2,
                  height: size.height / 2,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
