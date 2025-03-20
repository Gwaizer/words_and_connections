import 'package:flutter/material.dart';
import 'package:words_and_connections/constants/questions.dart';

class QuestionsView extends StatefulWidget {
  final Map? args;

  const QuestionsView({super.key, this.args});

  @override
  State<QuestionsView> createState() => _QuestionsViewState();
}
class _QuestionsViewState extends State<QuestionsView> {

  String? letter;
  List<(String, String)>? questions;
  (String,String)? questionAndAnswer;
  @override
  void initState() {
    super.initState();
    letter = widget.args?['args1'];
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
    _ => null,
    };
    questions?.shuffle();
    questionAndAnswer = questions?.removeLast();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('سؤال جوابه بحرف ال $letter'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 600,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
              ),
              alignment: Alignment.center,
              child: Text(questionAndAnswer!.$1),
            ),
            Container(
              width: 500,
              height: 30,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              alignment: Alignment.center,
              child: Text(questionAndAnswer!.$2),
            ),
            FilledButton(
              onPressed: (){
                setState(() {
                  questionAndAnswer = questions!.isNotEmpty ? questions?.removeLast() : ("لا يوجد سؤال", "لا يوجد سؤال");
                });
              },
              child: Text("سؤال اخر"),
              ),
          ],
        ),
      ),
    );
  }
}