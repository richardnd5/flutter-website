import 'package:flutter/material.dart';
import 'package:flutter_website/views/components/inner_page_container.dart';

import '../home/home_page_view_model.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({Key? key}) : super(key: key);
  final pageType = PageType.contact;
  Widget build(BuildContext context) {
    return InnerPageContainer(
      child: ListView(
        children: [
          Text(
            'Contact Page',
            style: Theme.of(context).textTheme.headline3,
            textAlign: TextAlign.center,
          ),
          Text(
            'nathan at byeahwecan dot com',
            style: Theme.of(context).textTheme.headline6,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
