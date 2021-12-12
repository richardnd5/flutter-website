import 'package:flutter/material.dart';

import 'home_page_view_model.dart';

class CodingPage extends StatelessWidget {
  const CodingPage({Key? key}) : super(key: key);

  final pageType = PageType.coding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageType.getPageColor(),
      body: Center(
        child: Text('Coding Page'),
      ),
    );
  }
}
