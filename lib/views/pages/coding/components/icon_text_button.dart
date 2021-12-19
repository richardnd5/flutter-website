import 'dart:js' as js;
import 'package:flutter/material.dart';

class IconTextButton extends StatelessWidget {
  const IconTextButton({
    Key? key,
    required this.assetPath,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  final String assetPath;

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
          onTap: onTap,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              assetPath,
              height: 60,
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle1,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
    return LayoutBuilder(builder: (context, constraints) {
      print('${constraints.maxHeight},${constraints.maxWidth}');

      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            onTap: onTap,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                assetPath,
                height: 60,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle1,
              // overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      );
    });
  }
}

void launchURL(String url) async {
  js.context.callMethod('open', [url]);
}
