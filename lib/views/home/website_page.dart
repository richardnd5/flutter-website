import 'package:flutter/material.dart';

import 'home_page_view_model.dart';

class WebsitePage {
  bool enabled;
  bool showContent;
  Offset pos;
  Color color;
  Widget page;
  PageType type;
  int order;

  WebsitePage({
    required this.type,
    required this.pos,
    this.enabled = false,
    this.showContent = false,
    required this.page,
    required this.color,
    required this.order,
  });
}
