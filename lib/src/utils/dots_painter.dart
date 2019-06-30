import 'package:flutter/material.dart';

class DotsPainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.grey[500];
    paint.strokeWidth = 1;

    canvas.drawLine(
      Offset(size.width * 0.1, 0),
      Offset(size.width * 0.1, size.height),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}