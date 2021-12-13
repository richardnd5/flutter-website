import 'package:flutter/material.dart';
import 'package:flutter_website/views/inner_page_container.dart';

import '../home/home_page_view_model.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({Key? key}) : super(key: key);
  final pageType = PageType.contact;
  Widget build(BuildContext context) {
    return InnerPageContainer(
      child: Column(
        children: [Text('Contact Page')],
      ),
    );
  }
}
