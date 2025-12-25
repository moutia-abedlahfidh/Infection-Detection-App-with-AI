import 'dart:io';

import 'package:fistulacheck/quiz/quizservice.dart';
import 'package:fistulacheck/resultai/resultaiscreen.dart';
import 'package:flutter/material.dart';


class Quizcontroller extends ChangeNotifier {
  final File image;
  Quizcontroller({required this.image}) ;
  List<bool?> answers = List.filled(7, null);
  quizService service = quizService() ;

  final questions = [
    "Question 1?",
    "Question 2?",
    "Question 3?",
    "Question 4?",
    "Question 5?",
    "Question 6?",
    "Question 7?",
  ];

  void submitForm(BuildContext context) async{
    if (answers.contains(null)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please answer all questions!")),
      );
    } else {
      print("Answers: $answers");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Form submitted successfully!")),
      );
      String? result = await service.ResponseChatGpt(image);

      Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => AiResultPage(
      aiAnswer:
          result ?? "",
    ),
  ),
);

    }
  }

  void onChnageAnswer(bool val , int index) {
    answers[index] = val;
    notifyListeners();
  }
}