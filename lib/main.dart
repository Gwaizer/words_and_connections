import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:words_and_connections/views/game_view.dart';
import 'package:words_and_connections/views/questions_view.dart';

void main(List<String> args) {
  if (args.firstOrNull == 'multi_window') {
    final arguments = jsonDecode(args[2]) as Map<String, dynamic>;
    runApp(MaterialApp(home: QuestionsView(args: arguments)));
  } else {
    runApp(MaterialApp(home: GameView()));
  }
}