import 'package:flutter/material.dart';

class GameOfLifePainter extends CustomPainter {
  const GameOfLifePainter({
    required this.columns,
    required this.rows,
    required this.screenSize,
    required this.dotList,
    Key? key,
  });

  final Size screenSize;

  final int columns;
  final int rows;
  final List<List<int>> dotList;

  @override
  void paint(Canvas canvas, Size size) {
    int divider = rows > columns ? rows : columns;
    double squareWidth = screenSize.width / divider;
    double squareHeight = screenSize.height / divider;

    dotList.asMap().forEach((i, row) {
      row.asMap().forEach((j, column) {
        if (column == 1) {
          var dotPosition = Offset(j * squareWidth, i * squareHeight);
          Rect rect = Offset(dotPosition.dx, dotPosition.dy) &
              Size(squareWidth, squareHeight);
          canvas.drawRect(rect, Paint());
        }
      });
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
