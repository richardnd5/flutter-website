import 'package:flutter_website/navigation/nav_state.dart';
import 'package:flutter_website/views/pages/home/home_page_view_model.dart';

PageConfig getPageConfig(PageType type) {
  switch (type) {
    case PageType.coding:
      return codingPageConfig;
    case PageType.about:
      return aboutPageConfig;
    case PageType.music:
      return musicPageConfig;
    case PageType.contact:
      return contactPageConfig;
  }
}
