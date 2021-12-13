import 'package:flutter/material.dart';
import 'package:flutter_website/navigation/nav_router_delegate.dart';
import 'package:flutter_website/navigation/nav_state.dart';
import 'package:provider/provider.dart';
import 'home_page_view_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final double smallPercent = 0.1;
  final double largePercent = 0.8;

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
    return AnimatedAlign(
      duration: Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      alignment:
          watched.selectedPage == type ? Alignment.center : deselectedAlignment,
      child: GestureDetector(
        onTap: () => goToPage(context, type),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 400),
          curve: Curves.easeInOut,
          width: watched.selectedPage == null
              ? size.width / 2
              : size.width *
                  (watched.selectedPage == type ? largePercent : smallPercent),
          height: watched.selectedPage == null
              ? size.height / 2
              : size.height *
                  (watched.selectedPage == type ? largePercent : smallPercent),
          color: type.getPageColor(),
        ),
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
