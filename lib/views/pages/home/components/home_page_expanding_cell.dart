import 'package:flutter/material.dart';
import 'package:flutter_website/global/page_config_function.dart';
import 'package:flutter_website/navigation/nav_state.dart';
import 'package:flutter_website/views/pages/home/home_page_view_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class HomePageExpandingCell extends StatelessWidget {
  const HomePageExpandingCell(this.type, {Key? key}) : super(key: key);

  final double smallSize = 70;
  final double expandedHeightScale = 0.9;
  final double largeWidth = 1;
  final double maxWidth = 1000;
  final double maxHeight = 1000;
  final double selectedPadding = 8;

  final PageType type;

  _goToPage(BuildContext context, PageType type) {
    PageConfig selectedConfig = getPageConfig(type);

    Provider.of<HomePageViewModel>(context, listen: false).selectedPage = type;
    Provider.of<NavState>(context, listen: false).goTo(selectedConfig);
  }

  getPadding(double width) {
    return width > 700 ? 32 : selectedPadding;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var watched = context.watch<HomePageViewModel>();
    bool noPageSelected = watched.selectedPage == null;

    bool typeSelected = watched.selectedPage == type;

    double thePadding = noPageSelected ? 0 : selectedPadding;

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
          padding: EdgeInsets.all(thePadding),
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
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600,
                                      ),
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
    );
  }

  double _getHeights(HomePageViewModel watched, Size size, bool typeSelected) {
    if (watched.selectedPage == null) {
      return size.height / 2;
    }

    var maxHeightWithPadding = maxHeight - selectedPadding - smallSize;

    if (typeSelected) {
      return (size.height * expandedHeightScale) > maxHeight
          ? maxHeightWithPadding
          : size.height - (selectedPadding * 2) - smallSize - selectedPadding;
    }

    return smallSize;
  }

  double _getWidths(HomePageViewModel watched, Size size, bool typeSelected) {
    if (watched.selectedPage == null) {
      return size.width / 2;
    }

    if (typeSelected) {
      return (size.width * largeWidth) > maxWidth
          ? maxWidth - selectedPadding - smallSize
          : size.width * largeWidth;
    }

    return smallSize;
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
