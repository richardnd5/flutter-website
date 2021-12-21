import 'package:flutter/material.dart';
import 'package:flutter_website/pixel/models/cell.dart';

class CanvasPainter extends CustomPainter {
  const CanvasPainter(
    this.cells, {
    this.backgroundColor = Colors.white,
    required this.cellSize,
    this.gridLineWidth = 0.2,
    this.gridToggle = false,
    this.gridColor = Colors.blue,
    required this.gridDimensions,
    this.selectRect,
  });

  final Color backgroundColor;
  final List<Cell> cells;
  final double cellSize;
  final bool gridToggle;
  final Color gridColor;
  final double gridLineWidth;
  final Size gridDimensions;
  final Rect? selectRect;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset(0, 0) & size, Paint()..color = backgroundColor);
    cells.asMap().forEach((index, cell) {
      var paint = Paint();
      paint.strokeWidth = gridLineWidth;
      paint.color = cell.on ? cell.color : Colors.transparent;
      paint.style = PaintingStyle.fill;

      Rect rect =
          Offset(cell.gridPos!.dx * cell.size!, cell.gridPos!.dy * cell.size!) &
              Size(cell.size!, cell.size!);

      canvas.drawRect(rect, paint);

      if (gridToggle) {
        var gridStroke = Paint();
        gridStroke.strokeWidth = gridLineWidth;
        gridStroke.color = gridColor;
        gridStroke.style = PaintingStyle.stroke;
        canvas.drawRect(rect, gridStroke);
      }

      if (selectRect != null) {
        var paint = Paint()
          ..color = Colors.purple.withAlpha(1)
          ..style = PaintingStyle.fill;
        canvas.drawRect(selectRect!, paint);
      }
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
