import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:words_and_connections/views/game_view.dart';
import 'package:words_and_connections/views/questions_view.dart';
/// Determines whether the opened window is the main window ([GameView]) or the secondary window ([QuestionsView]).
/// If the [args] list contains any value, it indicates that the window is a secondary window. 
/// The third value in [args] is the [arguments] that will be passed to the [QuestionsView]. 
/// These arguments typically represent the letter of the question to be displayed in the secondary window.
void main(List<String> args) {
  if (args.firstOrNull == 'multi_window') {
    final arguments = jsonDecode(args[2]) as Map<String, dynamic>;
    runApp(MaterialApp(home: QuestionsView(args: arguments)));
  } else {
    runApp(MaterialApp(home: GameView()));
  }
}