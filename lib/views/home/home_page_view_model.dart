import 'package:flutter/material.dart';
import 'package:flutter_website/models/website_page.dart';

import '../about/about_page.dart';
import '../coding/coding_page.dart';
import '../contact/contact_page.dart';
import '../music/music_page.dart';

class HomePageViewModel extends ChangeNotifier {
  HomePageViewModel();

  PageType? get selectedPage => _selectedPage;
  PageType? _selectedPage;
  set selectedPage(PageType? page) {
    _selectedPage = page;
    notifyListeners();
  }

  // init(Size size) {
  //   List<Offset> offsetList = [
  //     Offset(0, 0),
  //     Offset(0, 1),
  //     Offset(1, 0),
  //     Offset(1, 1)
  //   ];
  //   PageType.values.asMap().forEach((i, element) {
  //     WebsitePage page = WebsitePage(
  //       type: element,
  //       page: element.getPageType(),
  //       color: element.getPageColor(),
  //       pos: offsetList[i],
  //       order: i,
  //     );

  //     switch (element) {
  //       case PageType.about:
  //         aboutPage = page;
  //         break;
  //       case PageType.music:
  //         musicPage = page;
  //         break;
  //       case PageType.coding:
  //         codingPage = page;
  //         break;
  //       case PageType.contact:
  //         contactPage = page;
  //         break;
  //     }
  //     // pageList.add(page);
  //     pages[element] = page;
  //   });

  //   pageList = [
  //     musicPage,
  //     aboutPage,
  //     contactPage,
  //     codingPage,
  //   ];
  //   notifyListeners();
  // }

  // handlePageTap(PageType type) {
  //   late WebsitePage selectedType;
  //   switch (type) {
  //     case PageType.about:
  //       selectedType = aboutPage;
  //       break;
  //     case PageType.music:
  //       selectedType = musicPage;
  //       break;
  //     case PageType.coding:
  //       selectedType = codingPage;
  //       break;
  //     case PageType.contact:
  //       selectedType = contactPage;
  //       break;
  //   }

  //   selectedType.enabled = !selectedType.enabled;

  //   // pageList.removeWhere((page) => page.type == selectedType.type);
  //   // pageList.add(selectedType);
  //   // pageList.

  //   notifyListeners();
  // }
}

enum PageType { coding, about, music, contact }

extension PageTypeExtension on PageType {
  Widget getPageType() {
    switch (this) {
      case PageType.about:
        return AboutPage();
      case PageType.music:
        return MusicPage();
      case PageType.coding:
        return CodingPage();
      case PageType.contact:
        return ContactPage();
    }
  }

  Color getPageColor() {
    switch (this) {
      case PageType.about:
        return Colors.blue;
      case PageType.music:
        return Colors.orange;
      case PageType.coding:
        return Colors.pink;
      case PageType.contact:
        return Colors.purple;
    }
  }
}
