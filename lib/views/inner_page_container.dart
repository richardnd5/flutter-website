import 'package:flutter/material.dart';

class InnerPageContainer extends StatelessWidget {
  const InnerPageContainer({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      child: child,
    );
  }
}
