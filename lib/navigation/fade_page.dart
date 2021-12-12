import 'package:flutter/material.dart';

class FadePage extends Page {
  final Widget? child;

  const FadePage({Key? key, this.child}) : super(key: key as LocalKey?);
  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      pageBuilder: (context, anim1, anim2) {
        var curve = CurveTween(curve: Curves.easeInOut);

        return FadeTransition(
          opacity: anim1.drive(curve),
          child: child,
        );
      },
    );
  }
}
