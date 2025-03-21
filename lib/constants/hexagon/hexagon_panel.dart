import 'package:flutter/material.dart';
import 'package:words_and_connections/constants/hexagon/hexagon_button.dart';

/// A [StatefulWidget] that represents a panel of [HexagonButton] for a game.
/// This widget displays 25 hexagonal buttons arranged in a grid, each button representing a letter from the Arabic alphabet.
/// When a button is pressed, it calls the provided [onpressed] function with the corresponding letter and index.
/// 
/// The color of the hexagon buttons is customizable through the [hexagonButtonColors] list. The selected button
/// is highlighted in yellow to indicate that it has been pressed.
///
/// The layout of the buttons is generated dynamically based on the screen size, and their positions adjust
/// accordingly in a hexagonal grid pattern.

class HexagonPanel extends StatefulWidget {
  /// A callback function that is invoked when a hexagon button is pressed.
  /// [String] is the letter corresponding to the pressed button, and [int] is the index of the button.
  final Function(String, int) onpressed;

  /// The [BuildContext] for the widget. This is required to access various parts of the widget tree.
  final BuildContext context;

  /// A list of colors to assign to each hexagon button. Each color corresponds to a button in the [hexagonButtons] list.
  final List<Color> hexagonButtonColors;

  const HexagonPanel({
    super.key,
    required this.onpressed,
    required this.context,
    required this.hexagonButtonColors,
  });

  @override
  State<HexagonPanel> createState() => _HexagonPanelState();
}

/// Shuffles the Arabic alphabet list and returns the shuffled version.
/// The shuffled list is used to randomize the order of the Arabic letters on the hexagon buttons.
List<String> shuffleList(List<String> list) {
  List<String> shuffledList = List.from(list);
  shuffledList.shuffle();
  return shuffledList;
}

/// The Arabic alphabet letters are shuffled for the game display order.
final List<String> arabicAlphabet = shuffleList([
  'ا', 'ب', 'ت', 'ث', 'ج', 'ح', 'خ', 'د', 'ذ', 'ر', 'ز', 'س', 'ش', 'ص', 'ض', 'ط', 'ظ', 'ع', 'غ', 'ف', 'ق', 'ك', 'ل', 'م', 'ن', 'ه', 'و', 'ي'
]);

/// The index of the last pressed button. Initially set to -1 (indicating no button has been pressed).
int lastButtonIndex = -1;

/// The state class for [HexagonPanel], which manages the state of the hexagonal buttons and their interactions.
/// The layout of the buttons is dynamically created in a hexagonal grid, and pressing a button updates the state.
class _HexagonPanelState extends State<HexagonPanel> {
  /// A list of hexagon buttons that will be displayed on the panel.
  List<Widget> hexagonButtons = [];

  @override
  void initState() {
    super.initState();
    // Shuffle the Arabic alphabet each time the state is initialized.
    arabicAlphabet.shuffle();
  }

  /// Resets the game by reshuffling the Arabic alphabet and rebuilding the widget.
  void reset() {
    arabicAlphabet.shuffle();
    setState(() {
      
    });
  }
  @override
  Widget build(BuildContext context) {
    double rowSpacing = 90; // The vertical spacing between rows of hexagons.
    double columnSpacing = 120; // The horizontal spacing between columns of hexagons.
    
    // Generate the hexagon buttons dynamically based on the shuffled Arabic alphabet.
    hexagonButtons = List.generate(25, (index) {
      return HexagonButton(
        backgroundColor: lastButtonIndex == index
            ? Colors.yellow // Highlight the selected button in yellow.
            : widget.hexagonButtonColors[index], // Use the provided colors list for other buttons.
        onPressed: () {
          // Call the provided onPressed callback with the corresponding letter and index.
          widget.onpressed(arabicAlphabet[index], index);
          setState(() {
            // Update the last pressed button's index to highlight it.
            lastButtonIndex = index;
          });
        },
        child: Text(arabicAlphabet[index], style: TextStyle(fontSize: 40)), // Display the letter on the button.
      );
    });

    // Build the hexagonal grid using a Stack to position the buttons.
    return Stack(
      children: List.generate(hexagonButtons.length, (index) {
        int row = index ~/ 5; // Calculate the row position (integer division by 5).
        int column = index % 5; // Calculate the column position (remainder of division by 5).

        // Calculate the x and y offsets to position each hexagon button.
        double xOffset = column * columnSpacing;
        double yOffset = row * rowSpacing;

        // Adjust the xOffset for every other row to create the hexagonal pattern.
        if (row % 2 != 0) {
          xOffset += columnSpacing / 2;
        }

        // Position the hexagon buttons using the calculated offsets.
        return Positioned(
          left: xOffset,
          top: yOffset,
          height: 120, // Height of each hexagon button.
          width: 120, // Width of each hexagon button.
          child: hexagonButtons[index], // Place the button at the calculated position.
        );
      }),
    );
  }
}
