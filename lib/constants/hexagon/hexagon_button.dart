import 'package:flutter/material.dart';
import 'package:words_and_connections/constants/hexagon/hexagon_shape_border.dart';

class HexagonButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Color backgroundColor;
  final Color? hoverColor;

  HexagonButton({
    required this.onPressed,
    required this.child,
    required this.backgroundColor,
    required this.hoverColor,
  });

  @override
  HexagonButtonState createState() => HexagonButtonState();
}

class HexagonButtonState extends State<HexagonButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        widget.onPressed();
      },
      shape: HexagonShapeBorder(),
      backgroundColor: widget.backgroundColor,
      hoverColor: widget.hoverColor,
      foregroundColor: Colors.black,
      child: widget.child,
    );
  }
}