import 'package:flutter/material.dart';
import 'package:flutter_website/global/global_variables.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class OurPage extends StatelessWidget {
  const OurPage({
    Key? key,
    required this.animation,
    required this.tag,
  }) : super(key: key);

  final String tag;
  final Animation animation;
  static Interval opacityCurve =
      const Interval(0.0, 0.75, curve: Curves.fastOutSlowIn);

  @override
  Widget build(BuildContext context) {
    timeDilation = 3.0;
    return Scaffold(
      body: Container(
        child: Hero(
          createRectTween: createRectTween,
          tag: tag,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Scaffold(
                body: Container(
                  color: Colors.blue,
                  alignment: Alignment.center,
                  child: Text('Our Page'),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
