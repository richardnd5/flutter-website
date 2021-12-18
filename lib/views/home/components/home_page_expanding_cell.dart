import 'package:flutter/material.dart';
import 'package:flutter_website/navigation/nav_router_delegate.dart';
import 'package:flutter_website/navigation/nav_state.dart';
import 'package:flutter_website/views/home/home_page_view_model.dart';
import 'package:provider/provider.dart';

class HomePageExpandingCell extends StatelessWidget {
  const HomePageExpandingCell(this.type, {Key? key}) : super(key: key);

  final double smallPercent = 0.1;
  final double largeHeight = 0.9;
  final double largeWidth = 1;
  final PageType type;

  Alignment _getDeselectedAlignment(PageType selectedPage) {
    switch (type) {
      case PageType.about:
        return selectedPage == PageType.coding
            ? Alignment.bottomLeft
            : Alignment.bottomRight;
      case PageType.music:
        return selectedPage == PageType.contact
            ? Alignment.bottomCenter
            : Alignment.bottomRight;
      case PageType.coding:
        return Alignment.bottomLeft;
      case PageType.contact:
        return Alignment.bottomCenter;
    }
  }

  Alignment _getAligment(HomePageViewModel watched) {
    return watched.selectedPage == type
        ? Alignment.topCenter
        : Alignment.center;
  }

  Alignment _getNullAlignment() {
    switch (type) {
      case PageType.about:
        return Alignment.topLeft;
      case PageType.music:
        return Alignment.topRight;
      case PageType.coding:
        return Alignment.bottomLeft;
      case PageType.contact:
        return Alignment.bottomRight;
    }
  }

  _goToPage(BuildContext context, PageType type) {
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
    var size = MediaQuery.of(context).size;
    var watched = context.watch<HomePageViewModel>();

    return AnimatedAlign(
      duration: HomePageViewModel.animDuration,
      curve: HomePageViewModel.curve,
      alignment: watched.selectedPage == type
          ? Alignment.topCenter
          : watched.selectedPage == null
              ? _getNullAlignment()
              : _getDeselectedAlignment(watched.selectedPage!),
      child: GestureDetector(
        onTap: () => _goToPage(context, type),
        child: AnimatedContainer(
            duration: HomePageViewModel.animDuration,
            curve: HomePageViewModel.curve,
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
                  duration: HomePageViewModel.animDuration,
                  curve: HomePageViewModel.curve,
                  padding: EdgeInsets.only(
                      top: watched.selectedPage == type ? 16 : 0),
                  child: AnimatedAlign(
                    duration: HomePageViewModel.animDuration,
                    curve: HomePageViewModel.curve,
                    alignment: _getAligment(watched),
                    child: AnimatedOpacity(
                      duration: HomePageViewModel.animDuration,
                      curve: HomePageViewModel.curve,
                      opacity: watched.selectedPage == type ? 1.0 : 0,
                      child: AnimatedContainer(
                        duration: HomePageViewModel.animDuration,
                        curve: HomePageViewModel.curve,
                        height: watched.selectedPage == type ? size.height : 0,
                        child: type.getPageWidget(),
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
