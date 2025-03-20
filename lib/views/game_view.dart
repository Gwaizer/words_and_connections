import 'dart:convert';

import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/material.dart';
import 'package:words_and_connections/constants/hexagon/hexagon_panel.dart';

class GameView extends StatefulWidget {
  const GameView({super.key});

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  final List<Color> buttonColors = List.generate(25, (index) => Colors.white);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final leftPadding =
        screenWidth > 660 ? (screenWidth - 660) / 2 : screenWidth;
    final topPadding =
        screenHeight > 480 ? (screenHeight - 480) / 2 : screenHeight;
    final rightPadding =
        screenWidth > 660 ? (screenWidth - 660) / 2 : screenWidth;
    final bottomPadding =
        screenHeight > 480 ? (screenHeight - 480) / 2 : screenHeight;

    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: Stack(
          children: [
            Center(
              child: 
            Image.asset('assets/images/Untitled.png') ,
            ),
            Padding(
            padding: EdgeInsets.fromLTRB(
              leftPadding,
              topPadding,
              rightPadding,
              bottomPadding,
            ),
            child: HexagonPanel(
              hexagonButtonColors: buttonColors,
              context: context,
              onpressed: (buttonLetter, buttonIndex) {
                showModalBottomSheet(
                  barrierColor: Colors.transparent,
                  context: context,
                  builder: (BuildContext context) {
                    return SizedBox(
                      height: 100,
                      width: 500,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FilledButton(
                            onPressed: () {
                              setState(() {
                                buttonColors[buttonIndex] = Colors.green;
                              });
                              Navigator.pop(context);
                            },
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                Colors.green,
                              ),
                            ),
                            child: const Text("Green"),
                          ),
          
                          FilledButton(
                            onPressed: () {
                              setState(() {
                                buttonColors[buttonIndex] = Colors.orange;
                              });
                              Navigator.pop(context);
                            },
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                Colors.orange,
                              ),
                            ),
                            child: const Text("Orange"),
                          ),
          
                          FilledButton(
                            onPressed: () {
                              setState(() {
                                buttonColors[buttonIndex] = Colors.white;
                              });
                              Navigator.pop(context);
                            },
                            child: const Text("Clear"),
                          ),
          
                          FilledButton(
                            onPressed: () async {
                              final window =
                                  await DesktopMultiWindow.createWindow(
                                    jsonEncode({'args1': buttonLetter}),
                                  );
                              window
                                ..setTitle("سؤال وجوابه")
                                ..setFrame(
                                  const Offset(0, 0) & const Size(600, 200),
                                )
                                ..show();
                            },
                            child: const Text("Question"),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          ]
        ),
      ),
    );
  }
}