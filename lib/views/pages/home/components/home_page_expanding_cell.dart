import 'package:flutter/material.dart';
import 'package:flutter_website/navigation/nav_state.dart';
import 'package:flutter_website/views/pages/home/home_page_view_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class HomePageExpandingCell extends StatelessWidget {
  const HomePageExpandingCell(this.type, {Key? key}) : super(key: key);

  final double smallPercent = 0.1;
  final double largeHeight = 0.9;
  final double largeWidth = 1;
  final double maxWidth = 1000;
  final double maxHeight = 1000;
  final double selectedPadding = 16;

  final PageType type;

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

    bool typeSelected = watched.selectedPage == type;

    return AnimatedAlign(
      duration: HomePageViewModel.animDuration,
      curve: HomePageViewModel.curve,
      alignment: typeSelected
          ? Alignment.topCenter
          : watched.selectedPage == null
              ? _getNullAlignment()
              : _getDeselectedAlignment(watched.selectedPage!),
      child: GestureDetector(
        onTap: () => _goToPage(context, type),
        child: AnimatedPadding(
          duration: HomePageViewModel.animDuration,
          curve: HomePageViewModel.curve,
          padding: EdgeInsets.all(
            watched.selectedPage == null || !typeSelected ? 0 : selectedPadding,
          ),
          child: AnimatedContainer(
            duration: HomePageViewModel.animDuration,
            curve: HomePageViewModel.curve,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  watched.selectedPage == null
                      ? 0
                      : typeSelected
                          ? 24
                          : 6,
                ),
              ),
            ),
            clipBehavior: Clip.hardEdge,
            width: _getWidths(watched, size, typeSelected) <= 50
                ? 50
                : _getWidths(watched, size, typeSelected),
            height: _getHeights(watched, size, typeSelected) <= 50
                ? 50
                : _getHeights(watched, size, typeSelected),
            child: Material(
              child: Container(
                color: type.getPageColor(),
                child: AnimatedPadding(
                  duration: HomePageViewModel.animDuration,
                  curve: HomePageViewModel.curve,
                  padding: EdgeInsets.only(top: typeSelected ? 16 : 0),
                  child: AnimatedAlign(
                    duration: HomePageViewModel.animDuration,
                    curve: HomePageViewModel.curve,
                    alignment: _getAligment(typeSelected),
                    child: AnimatedSwitcher(
                      duration: HomePageViewModel.animDuration,
                      switchInCurve: HomePageViewModel.curve,
                      switchOutCurve: HomePageViewModel.curve,
                      child: typeSelected
                          ? AnimatedOpacity(
                              duration: HomePageViewModel.animDuration,
                              curve: HomePageViewModel.curve,
                              opacity: typeSelected ? 1.0 : 0,
                              child: AnimatedContainer(
                                duration: HomePageViewModel.animDuration,
                                curve: HomePageViewModel.curve,
                                height: typeSelected ? size.height : 0,
                                child: type.getPageWidget(),
                              ),
                            )
                          : FittedBox(
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    FaIcon(
                                      type.getIcon(),
                                      size: 50,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 16),
                                      child: Text(
                                        type.getName(),
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  double _getHeights(HomePageViewModel watched, Size size, bool typeSelected) {
    return (watched.selectedPage == null
        ? size.height / 2
        : (size.height * (typeSelected ? largeHeight : smallPercent)) >
                maxHeight
            ? maxHeight - selectedPadding
            : (size.height * (typeSelected ? largeHeight : smallPercent)) -
                selectedPadding);
  }

  double _getWidths(HomePageViewModel watched, Size size, bool typeSelected) {
    return watched.selectedPage == null
        ? size.width / 2
        : (size.width * (typeSelected ? largeWidth : smallPercent)) > maxWidth
            ? maxWidth - selectedPadding
            : (size.width * (typeSelected ? largeWidth : smallPercent)) -
                selectedPadding;
  }

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

  Alignment _getAligment(bool typeSelected) {
    return typeSelected ? Alignment.topCenter : Alignment.center;
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
}
