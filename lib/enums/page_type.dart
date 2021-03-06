import 'package:flutter/material.dart';
import 'package:flutter_website/views/pages/about/about_page.dart';
import 'package:flutter_website/views/pages/coding/coding_page.dart';
import 'package:flutter_website/views/pages/contact/contact_page.dart';
import 'package:flutter_website/views/pages/music/music_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum PageType { coding, about, music, contact }

extension PageTypeExtension on PageType {
  String getName() {
    switch (this) {
      case PageType.about:
        return 'About';
      case PageType.music:
        return 'Music';
      case PageType.coding:
        return 'Coding';
      case PageType.contact:
        return 'Contact';
    }
  }

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

  IconData getIcon() {
    switch (this) {
      case PageType.about:
        return FontAwesomeIcons.userCircle;
      case PageType.music:
        return FontAwesomeIcons.music;
      case PageType.coding:
        return FontAwesomeIcons.code;
      case PageType.contact:
        return FontAwesomeIcons.envelope;
    }
  }

  Widget getPageWidget() {
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
}
