import 'package:flutter/material.dart';
import 'package:flutter_website/views/common/inner_page_container.dart';

import '../home/home_page_view_model.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({Key? key}) : super(key: key);
  final pageType = PageType.contact;
  Widget build(BuildContext context) {
    return InnerPageContainer(
      child: ListView(
        shrinkWrap: true,
        children: [
          Text(
            'Contact Page',
            style: Theme.of(context).textTheme.headline3,
          ),
          // SizedBox(height: 64),
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
