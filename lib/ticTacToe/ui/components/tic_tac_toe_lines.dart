import 'package:flutter/material.dart';

class TicTacToeLines extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2;
    var vert1Start = Offset(size.width / 3, 0);
    var vert1End = Offset(size.width / 3, size.height);

    var vert2Start = Offset((size.width / 3) * 2, 0);
    var vert2End = Offset((size.width / 3) * 2, size.height);

    var hor1Start = Offset(0, size.height / 3);
    var hor1End = Offset(size.width, size.height / 3);

    var hor2Start = Offset(0, (size.height / 3) * 2);
    var hor2End = Offset(size.width, (size.height / 3) * 2);

    canvas.drawLine(vert1Start, vert1End, paint);
    canvas.drawLine(vert2Start, vert2End, paint);
    canvas.drawLine(hor1Start, hor1End, paint);
    canvas.drawLine(hor2Start, hor2End, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
