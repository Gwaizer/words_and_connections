import 'package:flutter/material.dart';
import 'package:words_and_connections/constants/questions.dart';

/// The [QuestionsView] is a stateful widget that displays a question and its corresponding answer, 
/// with the ability to hide and show both the question and the answer.
/// It also allows for navigating through different questions, revealing and hiding them
/// as needed. The questions are related to Arabic letters, and the current question is
/// dynamically selected based on the argument passed when the view is created.
///
/// This widget is designed for a language-learning game where users are shown Arabic alphabet letters
/// and their corresponding questions and answers.

class QuestionsView extends StatefulWidget {
  /// An optional argument [args] passed to the widget to determine the initial question set.
  /// The value of [args1] in the map determines the starting letter for the question set.
  final Map? args;

  /// Constructor for the [QuestionsView], where the [args] parameter is passed to determine the
  /// starting question set based on the provided letter.
  const QuestionsView({super.key, this.args});

  @override
  State<QuestionsView> createState() => _QuestionsViewState();
}

/// The [State] class for [QuestionsView], which manages the state of the widget.
/// It handles the logic for hiding and showing questions/answers, switching to a new question,
/// and selecting the correct question list based on the starting letter from [args].
class _QuestionsViewState extends State<QuestionsView> {
  bool hiddenQuestion = true;  // Boolean to track if the question is hidden.
  bool hiddenAnswer = true;    // Boolean to track if the answer is hidden.
  String? letter;              // The letter of the Arabic alphabet passed from the arguments.
  List<(String, String)>? questions; // List of tuples (question, answer) based on the Arabic letter.
  (String, String)? questionAndAnswer;  // The current question-answer tuple.

  @override
  void initState() {
    super.initState();
    letter = widget.args?['args1']; // Extract the letter from the passed arguments.

    // Select the correct set of questions based on the Arabic letter.
    questions = switch (letter) {
      'ا' => List.from(alifQuestionsList),
      'ب' => List.from(baQuestionsList),
      'ت' => List.from(taQuestionsList),
      'ث' => List.from(thaQuestionsList),
      'ج' => List.from(jeemQuestionsList),
      'ح' => List.from(haQuestionsList),
      'خ' => List.from(khaQuestionsList),
      'د' => List.from(dalQuestionsList),
      'ذ' => List.from(thalQuestionsList),
      'ر' => List.from(raQuestionsTuples),
      'ز' => List.from(zayQuestionsList),
      'س' => List.from(seenQuestionsList),
      'ش' => List.from(sheenQuestionsList),
      'ص' => List.from(saadQuestionsList),
      'ض' => List.from(dadQuestionsList),
      'ط' => List.from(ta2QuestionsList),
      'ظ' => List.from(dhaQuestionsList),
      'ع' => List.from(ainQuestionsList),
      'غ' => List.from(ghainQuestionsList),
      'ف' => List.from(faQuestionsList),
      'ق' => List.from(qafQuestionsList),
      'ك' => List.from(kafQuestionsList),
      'ل' => List.from(lamQuestionsList),
      'م' => List.from(meemQuestionsList),
      'ن' => List.from(noonQuestionsList),
      'ه' => List.from(ha2QuestionsList),
      'و' => List.from(wawQuestionsList),
      'ي' => List.from(yaQuestionsList),
      _ => null, // Default to null if the letter doesn't match any predefined letter.
    };

    // Shuffle the questions to randomize the order.
    questions?.shuffle();
    
    // Set the first question-answer pair.
    questionAndAnswer = questions?.removeLast();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,  // Set the background color of the Scaffold.
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Widget for displaying the current question. It toggles visibility based on [hiddenQuestion].
            Builder(
              builder: (context) {
                double width = MediaQuery.of(context).size.width / 1.2;
                double height = MediaQuery.of(context).size.height / 10;
                return Container(
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                    color: hiddenQuestion ? Colors.black : Colors.blue, // Switch between black and blue.
                    borderRadius: BorderRadius.circular(20),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    hiddenQuestion ? "السؤال مخفي" : questionAndAnswer!.$1, // Show the question or "Hidden".
                    style: TextStyle(
                      fontSize: height * 0.5,
                      color: hiddenQuestion ? Colors.white : Colors.black,
                    ),
                  ),
                );
              },
            ),
            // Widget for displaying the current answer. It toggles visibility based on [hiddenAnswer].
            Builder(
              builder: (context) {
                double width = MediaQuery.of(context).size.width / 1.2;
                double height = MediaQuery.of(context).size.height / 10;
                return Container(
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(20),
                    color: hiddenAnswer ? Colors.black : Colors.amber, // Switch between black and amber.
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    hiddenAnswer ? "الإجابة مخفية" : questionAndAnswer!.$2, // Show the answer or "Hidden".
                    style: TextStyle(
                      fontSize: height * 0.5,
                      color: hiddenAnswer ? Colors.white : Colors.black,
                    ),
                  ),
                );
              },
            ),
            // Row with buttons to control the view, such as revealing a new question or toggling visibility of question/answer.
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Button to load the next question.
                FilledButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.white),
                  ),
                  onPressed: () {
                    setState(() {
                      questionAndAnswer =
                          questions!.isNotEmpty
                              ? questions?.removeLast() // Get the next question-answer pair.
                              : ("نفذت الأسئلة :(", "نفذت الأسئلة :("); // Display "No more questions" if the list is empty.
                    });
                  },
                  child: Text(
                    "سؤال اخر", // "Next question" in Arabic.
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                // Button to toggle the visibility of the question.
                FilledButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.white),
                  ),
                  onPressed: () {
                    setState(() {
                      hiddenQuestion = !hiddenQuestion; // Toggle visibility of the question.
                    });
                  },
                  child: Text(
                    hiddenQuestion ? "إظهار السؤال" : "إخفاء السؤال", // "Show question" / "Hide question" in Arabic.
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                // Button to toggle the visibility of the answer.
                FilledButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.white),
                  ),
                  onPressed: () {
                    setState(() {
                      hiddenAnswer = !hiddenAnswer; // Toggle visibility of the answer.
                    });
                  },
                  child: Text(
                    hiddenAnswer ? "إظهار الإجابة" : "إخفاء الإجابة", // "Show answer" / "Hide answer" in Arabic.
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
