import 'package:flutter/material.dart';

class HexagonShapeBorder extends ShapeBorder {
  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(0);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    final path = Path();
    final double width = rect.width;
    final double height = rect.height;

    final List<Offset> innerPoints = [
      Offset(width / 2, height * 0.1),
      Offset(width * 0.85, height * 0.25),
      Offset(width * 0.85, height * 0.75),
      Offset(width / 2, height * 0.9),
      Offset(width * 0.15, height * 0.75),
      Offset(width * 0.15, height * 0.25),
    ];

    path.moveTo(innerPoints[0].dx, innerPoints[0].dy);
    for (int i = 1; i < innerPoints.length; i++) {
      path.lineTo(innerPoints[i].dx, innerPoints[i].dy);
    }
    path.close();

    return path;
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final path = Path();
    final width = rect.width;
    final height = rect.height;
    final List<Offset> points = [
      Offset(width / 2, 0),
      Offset(width, height * 0.25),
      Offset(width, height * 0.75),
      Offset(width / 2, height),
      Offset(0, height * 0.75),
      Offset(0, height * 0.25),
    ];

    path.moveTo(points[0].dx, points[0].dy);
    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }
    path.close();

    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    final paint =
        Paint()
          ..color = Colors.black
          ..style = PaintingStyle.stroke;

    canvas.drawPath(getOuterPath(rect, textDirection: textDirection), paint);
  }

  @override
  ShapeBorder scale(double t) {
    throw UnimplementedError();
  }
}