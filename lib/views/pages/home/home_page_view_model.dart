import 'package:flutter/material.dart';
import 'package:flutter_website/enums/page_type.dart';
import 'package:provider/provider.dart';
export 'package:flutter_website/enums/page_type.dart';

class HomePageViewModel extends ChangeNotifier {
  HomePageViewModel();

  static HomePageViewModel of(BuildContext context) {
    return Provider.of<HomePageViewModel>(context, listen: false);
  }

  static const animDuration = Duration(milliseconds: 400);
  static const curve = Curves.easeIn;

  bool hasInitialized = false;

  init() {
    hasInitialized = true;
  }

  PageType? get selectedPage => _selectedPage;
  PageType? _selectedPage;
  set selectedPage(PageType? page) {
    if (hasInitialized) {
      _selectedPage = page;
      notifyListeners();
    }
  }
}
