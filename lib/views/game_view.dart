import 'dart:convert';
import 'dart:math' show log;
import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/material.dart';
import 'package:words_and_connections/constants/hexagon/hexagon_button.dart';
import 'package:words_and_connections/constants/hexagon/hexagon_panel.dart';

/// [GameView] is the main game screen that displays the interactive game board.
/// It contains a hexagonal grid made of 25 [HexagonButton] widgets, which players can interact with.
/// The view manages the game state, such as the color of each button and the creation of new windows for the QuestionsView.
///
/// The game layout is responsive and adjusts based on the screen size, providing an optimal user experience on various devices.
class GameView extends StatefulWidget {
  const GameView({super.key});

  @override
  State<GameView> createState() => _GameViewState();
}

/// [buttonColors] defines the initial colors of each [HexagonButton] in the [HexagonPanel], and helps in setting up the initial visual state of the game.
/// Each button in the [HexagonPanel] starts with a default color (white), which can be changed by interacting with the buttons.
class _GameViewState extends State<GameView> {
  List<Color> buttonColors = List.generate(
    25,
    (index) => Colors.white,
  ); // List of colors for the hexagon buttons.

  WindowController?
  window; // The secondary window used to display the [QuestionsView].

  bool questionWindowIsOpen =
      true; // Boolean to track whether the question window is open.

  Image greenOrangeBorders = Image.asset(
    'assets/images/green_orange_borders.png',
  ); // Image used for visual borders in the game.

  /// Builds the [GameView] widget. This method contains the layout for the hexagonal grid, background image, and modal bottom sheet.
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width; // Get screen width.
    final screenHeight =
        MediaQuery.of(context).size.height; // Get screen height.

    // Calculate padding values to center the hexagonal grid based on screen size.
    final leftPadding =
        screenWidth > 660 ? (screenWidth - 660) / 2 : screenWidth;
    final topPadding =
        screenHeight > 480 ? (screenHeight - 480) / 2 : screenHeight;
    final rightPadding =
        screenWidth > 660 ? (screenWidth - 660) / 2 : screenWidth;
    final bottomPadding =
        screenHeight > 480 ? (screenHeight - 480) / 2 : screenHeight;

    // Calculate the size of the reset button based on screen width and height.
    final resetButtonSize = 10 * log(screenWidth * screenHeight / 1000);

    return Scaffold(
      backgroundColor:
          Colors.deepPurple, // Set the background color of the game view.
      body: Center(
        child: Stack(
          children: [
            // Background image with green and orange borders.
            Center(child: greenOrangeBorders),

            // Padding to center the HexagonPanel on the screen.
            Padding(
              padding: EdgeInsets.fromLTRB(
                leftPadding,
                topPadding,
                rightPadding,
                bottomPadding,
              ),
              child: HexagonPanel(
                hexagonButtonColors:
                    buttonColors, // Pass button colors to the HexagonPanel.
                context: context,
                onpressed: (buttonLetter, buttonIndex) {
                  // Display modal bottom sheet when a HexagonButton is pressed.
                  showModalBottomSheet(
                    barrierColor:
                        Colors
                            .transparent, // Transparent background for the modal.
                    context: context,
                    builder: (BuildContext context) {
                      return SizedBox(
                        height: 100,
                        width: 500,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Button to change the color of the pressed button to green.
                            FilledButton(
                              onPressed: () {
                                setState(() {
                                  buttonColors[buttonIndex] = Colors.green;
                                });
                                Navigator.pop(
                                  context,
                                ); // Close the modal after the action.
                              },
                              style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                  Colors.green,
                                ),
                              ),
                              child: const Text("أخضر"), // "Green" in Arabic.
                            ),
                            // Button to change the color of the pressed button to orange.
                            FilledButton(
                              onPressed: () {
                                setState(() {
                                  buttonColors[buttonIndex] = Colors.orange;
                                });
                                Navigator.pop(
                                  context,
                                ); // Close the modal after the action.
                              },
                              style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                  Colors.orange,
                                ),
                              ),
                              child: const Text(
                                "برتقالي",
                              ), // "Orange" in Arabic.
                            ),
                            // Button to reset the color of the pressed button to white.
                            FilledButton(
                              onPressed: () {
                                setState(() {
                                  buttonColors[buttonIndex] = Colors.white;
                                });
                                Navigator.pop(
                                  context,
                                ); // Close the modal after the action.
                              },
                              child: const Text("أبيض"), // "White" in Arabic.
                            ),
                            // Button to open the QuestionsView in a new window if not already open.
                            FilledButton(
                              onPressed: () async {
                                window
                                    ?.close(); // Close the existing window if it's open.
                                window = await DesktopMultiWindow.createWindow(
                                  jsonEncode(
                                    {'args1': buttonLetter},
                                  ), // Pass the selected letter to the QuestionsView.
                                );
                                window
                                  ?..setTitle(
                                    "سؤال وجوابه",
                                  ) // Set the title of the window.
                                  ..setFrame(
                                    const Offset(0, 0) &
                                        const Size(
                                          800,
                                          600,
                                        ), // Set the window size.
                                  )
                                  ..show(); // Show the new window with the questions.
                                questionWindowIsOpen = true;
                              },
                              child: const Text(
                                "إظهار سؤال",
                              ), // "Show Question" in Arabic.
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),

            // IconButton placed at the top right corner to reset the game.
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                tooltip:
                    "إعادة اللعبة من جديد", // Tooltip in Arabic ("Reset the game").
                onPressed:
                    () => showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text(
                            "تحذير",
                            textAlign: TextAlign.end,
                          ), // Alert dialog title ("Warning").
                          content: const Text(
                            "هل أنت متأكد أنك تريد إعادة تعيين اللعبة؟",
                          ), // Dialog content ("Are you sure you want to reset the game?").
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(
                                  context,
                                ).pop(); // Close the dialog when "No" is pressed.
                              },
                              child: const Text("لا"), // "No" in Arabic.
                            ),
                            TextButton(
                              onPressed: () {
                                // Reset the game by navigating to the GameView again.
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => GameView(),
                                  ),
                                );
                              },
                              child: const Text("نعم"), // "Yes" in Arabic.
                            ),
                          ],
                        );
                      },
                    ),
                icon: Icon(Icons.replay),
                color: Colors.white,
                iconSize:
                    resetButtonSize, // Dynamically set the size of the reset button.
              ),
            ),
          ],
        ),
      ),
    );
  }
}
