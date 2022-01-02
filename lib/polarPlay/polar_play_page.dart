import 'package:flutter/material.dart';
import 'package:flutter_website/polarPlay/polar_play_view_model.dart';
import 'dart:math' as math;

import 'package:provider/provider.dart';

class PolarPlayPage extends StatelessWidget {
  const PolarPlayPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (context) => PolarPlayViewModel(size),
      builder: (context, builder) {
        return Scaffold(
          body: CustomPaint(
            size: size,
            painter: PolarPlayPainter(
              vm: context.watch<PolarPlayViewModel>(),
            ),
          ),
        );
      },
    );
  }
}

class PolarPlayPainter extends CustomPainter {
  const PolarPlayPainter({
    // required this.screenSize,
    required this.vm,
    Key? key,
  });

  // final Size screenSize;
  final PolarPlayViewModel vm;

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = Colors.blue;

    // double r = size.width / 4;
    // var a = math.pi * 2;

    var x = vm.x;
    var y = vm.y;
    // var y = size.height / 2 + r * math.sin(a);

    canvas.drawCircle(Offset(x, y), 10, paint);
    var black = Paint()
      ..color = Colors.black
      ..strokeWidth = 2;
    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(size.width, size.height / 2),
      black,
    );
    canvas.drawLine(
      Offset(size.width / 2, 0),
      Offset(size.width / 2, size.height),
      black,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
