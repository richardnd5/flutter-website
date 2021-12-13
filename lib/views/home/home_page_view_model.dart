import 'package:flutter/material.dart';
import 'package:flutter_website/enums/page_type.dart';
export 'package:flutter_website/enums/page_type.dart';

class HomePageViewModel extends ChangeNotifier {
  HomePageViewModel();

  PageType? get selectedPage => _selectedPage;
  PageType? _selectedPage;
  set selectedPage(PageType? page) {
    _selectedPage = page;
    notifyListeners();
  }
}
