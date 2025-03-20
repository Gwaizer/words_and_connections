import 'package:flutter/material.dart';
import 'package:words_and_connections/constants/hexagon/hexagon_button.dart';

class HexagonPanel extends StatefulWidget {
  final Function(String, int) onpressed;
  final BuildContext context;
  final List<Color> hexagonButtonColors;

  const HexagonPanel({super.key, required this.onpressed, required this.context, required this.hexagonButtonColors});

  @override
  State<HexagonPanel> createState() => _HexagonPanelState();
}

List<String> shuffleList(List<String> list) {
  List<String> shuffledList = List.from(list);
  shuffledList.shuffle();
  return shuffledList;
}

final List<String> arabicAlphabet = shuffleList(['ا', 'ب', 'ت', 'ث', 'ج', 'ح', 'خ', 'د', 'ذ', 'ر', 'ز', 'س', 'ش', 'ص', 'ض','ط', 'ظ', 'ع', 'غ', 'ف', 'ق', 'ك', 'ل', 'م', 'ن', 'ه', 'و', 'ي']);
int lastButtonIndex = -1;

class _HexagonPanelState extends State<HexagonPanel> {
  List<Widget> hexagonButtons = [];

  @override
  void initState() {
    super.initState();
    arabicAlphabet.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    double rowSpacing = 90;
    double columnSpacing = 120;
    hexagonButtons = List.generate(25, (index) {
      return HexagonButton(
        backgroundColor:
            lastButtonIndex == index ? Colors.yellow : widget.hexagonButtonColors[index],
        hoverColor:
          Colors.black12,
        onPressed: () {
          widget.onpressed(arabicAlphabet[index], index);
          setState(() {
            if (lastButtonIndex != index) {
            lastButtonIndex = index;
            }
            else {
              lastButtonIndex = -1;
            }
          });
        },
        child: Text(arabicAlphabet[index], style: TextStyle(fontSize: 40)),
      );
    });
    return Stack(
      children: List.generate(hexagonButtons.length, (index) {
        int row = index ~/ 5;
        int column = index % 5;

        double xOffset = column * columnSpacing;

        double yOffset = row * rowSpacing;

        if (row % 2 != 0) {
          xOffset += columnSpacing / 2;
        }

        return Positioned(
          left: xOffset,
          top: yOffset,
          height: 120,
          width: 120,
          child: hexagonButtons[index],
        );
      }),
    );
  }
}
