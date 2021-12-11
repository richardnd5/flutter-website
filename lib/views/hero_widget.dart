import 'package:flutter/material.dart';
import 'package:flutter_website/global/global_variables.dart';
import 'our_page.dart';

class HeroWidget extends StatelessWidget {
  const HeroWidget({
    Key? key,
    required this.tag,
    required this.title,
  }) : super(key: key);

  final String tag;
  final String title;

  navigateToOurPage(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder<void>(
        pageBuilder: (context, animation, secondaryAnimation) {
          return OurPage(animation: animation, tag: tag);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      createRectTween: createRectTween,
      tag: tag,
      child: SizedBox(
        width: 50,
        height: 50,
        child: GestureDetector(
          child: Scaffold(
            body: Container(
              color: Colors.blue,
              alignment: Alignment.center,
              child: Text(title),
            ),
          ),
          onTap: () => navigateToOurPage(context),
        ),
      ),
    );
  }
}
