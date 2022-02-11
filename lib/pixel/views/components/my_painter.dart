import 'package:flutter/material.dart';
import 'package:flutter_website/pixel/services/canvas_service.dart';

class CanvasPainter extends CustomPainter {
  const CanvasPainter(this.service);

  final CanvasService service;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset(0, 0) & size, Paint()..color = Colors.white);
    service.currentScreen.asMap().forEach((index, cell) {
      var paint = Paint();
      paint.strokeWidth = service.gridLineWidth;
      paint.color = cell.on ? cell.color : Colors.transparent;
      paint.style = PaintingStyle.fill;

      Rect rect =
          Offset(cell.gridPos!.dx * cell.size!, cell.gridPos!.dy * cell.size!) &
              Size(cell.size!, cell.size!);

      canvas.drawRect(rect, paint);

      if (service.grid) {
        var gridStroke = Paint();
        gridStroke.strokeWidth = service.gridLineWidth;
        gridStroke.color = Colors.blue;
        gridStroke.style = PaintingStyle.stroke;
        canvas.drawRect(rect, gridStroke);
      }
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
