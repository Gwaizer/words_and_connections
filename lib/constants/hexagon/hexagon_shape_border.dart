import 'package:flutter/material.dart';

/// A custom shape border that creates a hexagonal shape.
///
/// The [HexagonShapeBorder] class extends [ShapeBorder] and is used to create a hexagonal border for widgets, such as buttons or containers.
/// This border can be applied to a [FloatingActionButton] or any widget that supports custom borders.
///
/// The shape of the border is defined by six points, which form the vertices of a hexagon. The outer hexagon path is drawn with a stroke,
/// while the inner path is used to define the region that will be occupied by the widget's content.
///
/// **Note**: The inner path is not used for visual rendering but can be used for hit testing and defining content boundaries.
///
/// Example usage:
/// ```dart
/// FloatingActionButton(
///   onPressed: () {},
///   shape: HexagonShapeBorder(),
///   backgroundColor: Colors.blue,
///   child: Icon(Icons.star),
/// )
/// ```

class HexagonShapeBorder extends ShapeBorder {

  /// Returns the edge insets for the hexagonal shape.
  /// In this case, the dimensions are all set to zero, meaning there is no extra padding or margin around the shape.
  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(0);

  /// Returns the inner path of the hexagon, which defines the boundaries within which the content is displayed.
  ///
  /// This inner path follows a hexagonal pattern, defined by six points on the rectangle that represents the widget's size.
  /// The path is used to clip content within the hexagon, though it is typically not visible as the content is drawn inside the shape.
  ///
  /// [rect] defines the bounding box for the widget. The path is computed relative to this rectangle.
  /// The optional [textDirection] parameter is used to adjust for text layout direction, but is not used in this implementation.
  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    final path = Path();
    final double width = rect.width;
    final double height = rect.height;

    final List<Offset> innerPoints = [
      Offset(width / 2, height * 0.1),  // Top center point
      Offset(width * 0.85, height * 0.25), // Top-right
      Offset(width * 0.85, height * 0.75), // Bottom-right
      Offset(width / 2, height * 0.9),  // Bottom center
      Offset(width * 0.15, height * 0.75), // Bottom-left
      Offset(width * 0.15, height * 0.25), // Top-left
    ];

    path.moveTo(innerPoints[0].dx, innerPoints[0].dy);  // Start at the first point
    for (int i = 1; i < innerPoints.length; i++) {
      path.lineTo(innerPoints[i].dx, innerPoints[i].dy);  // Draw lines to subsequent points
    }
    path.close(); // Close the path to form the hexagon

    return path;
  }

  /// Returns the outer path of the hexagon, which defines the visible boundary of the shape.
  ///
  /// This path is used to draw the hexagonal outline, and it is based on six points that form the outer edges of the hexagon.
  /// The outer path is used to define the area that the border should be drawn around.
  ///
  /// [rect] defines the bounding box for the widget. The path is computed relative to this rectangle.
  /// The optional [textDirection] parameter is used to adjust for text layout direction, but is not used in this implementation.
  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final path = Path();
    final width = rect.width;
    final height = rect.height;
    final List<Offset> points = [
      Offset(width / 2, 0),  // Top center point
      Offset(width, height * 0.25), // Top-right
      Offset(width, height * 0.75), // Bottom-right
      Offset(width / 2, height),  // Bottom center
      Offset(0, height * 0.75), // Bottom-left
      Offset(0, height * 0.25), // Top-left
    ];

    path.moveTo(points[0].dx, points[0].dy);  // Start at the first point
    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);  // Draw lines to subsequent points
    }
    path.close(); // Close the path to form the hexagon

    return path;
  }

  /// Paints the hexagonal border on the canvas using the [outerPath].
  ///
  /// The border is drawn with a black stroke color.
  /// The [paint] object is configured to use a stroke style, meaning only the outline is drawn (no fill).
  ///
  /// [canvas] is the [Canvas] on which the border is painted, and [rect] defines the bounds within which the border is drawn.
  /// The optional [textDirection] parameter is used to adjust for text layout direction, but is not used in this implementation.
  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    final paint = Paint()
      ..color = Colors.black  // Set the color for the border
      ..style = PaintingStyle.stroke;  // Set the paint style to stroke (outline)

    // Draw the hexagonal border using the outer path
    canvas.drawPath(getOuterPath(rect, textDirection: textDirection), paint);
  }

  /// Scales the shape by a factor of [t]. Not implemented in this case.
  ///
  /// This method is part of the [ShapeBorder] class, but is not needed for this specific implementation.
  /// It throws an [UnimplementedError] if called.
  @override
  ShapeBorder scale(double t) {
    throw UnimplementedError(); // Not implemented for this shape
  }
}
