import 'package:flutter/material.dart';

class PixelButton extends StatelessWidget {
  const PixelButton({
    Key? key,
    required this.child,
    this.onPressed,
    this.backgroundColor,
    this.minSize = const Size(8, 8),
  }) : super(key: key);

  final Widget child;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Size minSize;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: backgroundColor,
        minimumSize: minSize,
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
