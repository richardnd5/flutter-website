import 'dart:js' as js;
import 'package:flutter/material.dart';

class IconTextButton extends StatelessWidget {
  const IconTextButton({
    Key? key,
    required this.imageSize,
    required this.assetPath,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  final double imageSize;
  final String assetPath;

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              assetPath,
              width: imageSize,
              height: imageSize,
            ),
          ),
        ),
        SizedBox(height: 16),
        Text(label)
      ],
    );
  }
}

void launchURL(String url) async {
  js.context.callMethod('open', [url]);
}
