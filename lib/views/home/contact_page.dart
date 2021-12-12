import 'package:flutter/material.dart';

import 'home_page_view_model.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({Key? key}) : super(key: key);
  final pageType = PageType.contact;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageType.getPageColor(),
      body: Center(
        child: Text('Contact Page'),
      ),
    );
  }
}
