import 'package:flutter/material.dart';
import 'package:flutter_website/views/newHomePage/models/website_page.dart';

import 'expanding_home_page_view_model.dart';

class HomePageSquare extends StatelessWidget {
  const HomePageSquare({
    Key? key,
    required this.page,
    required this.size,
    required this.onTap,
  }) : super(key: key);

  final Size size;
  final WebsitePage page;
  final Function(PageType) onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(page.type),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        color: page.color,
        width: page.enabled ? size.width : size.width / 2,
        height: page.enabled ? size.height : size.height / 2,
        // child: page.enabled ? page.page : null,
      ),
    );
  }
}
