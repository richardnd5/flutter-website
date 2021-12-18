import 'package:flutter/material.dart';

pageGradient(Color color1, Color color2) => BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [color1, color2],
      ),
    );
