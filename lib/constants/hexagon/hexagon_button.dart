import 'package:flutter/material.dart';
import 'package:words_and_connections/constants/hexagon/hexagon_shape_border.dart';

/// A custom [StatefulWidget] that represents a hexagonal-shaped button used in the game.
/// This button is a [FloatingActionButton] with a custom hexagonal shape, and it can respond to user interactions
/// such as pressing and hovering. The button also supports custom background colors and hover effects.

class HexagonButton extends StatefulWidget {
  /// The callback function that is called when the button is pressed.
  /// This is used to handle the action when the button is clicked.
  final VoidCallback onPressed;

  /// The child widget to display inside the button. This is typically used to display text or icons inside the hexagon.
  final Widget child;

  /// The background color of the button. This color is displayed when the button is in its normal state (not pressed or hovered).
  final Color backgroundColor;

  /// Constructor for the [HexagonButton]. It requires an [onPressed] callback,
  /// a [child] widget, a [backgroundColor], and an optional [hoverColor].
  const HexagonButton({super.key, 
    required this.onPressed,
    required this.child,
    required this.backgroundColor,
  });

  @override
  HexagonButtonState createState() => HexagonButtonState();
}

/// The [State] class for [HexagonButton], which manages the state of the button.
/// This class defines the hexagonal button shape and the behavior of the button,
/// such as triggering the [onPressed] callback and changing hover color.
class HexagonButtonState extends State<HexagonButton> {
  @override
  Widget build(BuildContext context) {
    // A FloatingActionButton is used with a custom hexagonal shape.
    // When the button is pressed, the [onPressed] callback is executed.
    return FloatingActionButton(
      onPressed: () {
        widget.onPressed(); // Trigger the onPressed callback.
      },
      shape: HexagonShapeBorder(), // Custom shape for the hexagon button.
      backgroundColor: widget.backgroundColor, // Background color of the button.
      foregroundColor: Colors.black, // Color of the icon or text inside the button.
      child: widget.child, // The child widget inside the button (could be text or icon).
    );
  }
}
