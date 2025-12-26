import 'dart:io';

import 'package:FistulaCheck/quiz/quizservice.dart';
import 'package:FistulaCheck/resultai/resultaiscreen.dart';
import 'package:flutter/material.dart';


class Quizcontroller extends ChangeNotifier {
  final File image;
  Quizcontroller({required this.image}) ;
  List<bool?> answers = List.filled(7, null);
  quizService service = quizService() ;

  final questions = [
    "Question 1 : Avez-vous remarqué une rougeur importante ou une zone chaude autour de la fistule ? ",
    "Question 2 : Avez-vous constaté un gonflement inhabituel au niveau de la fistule ou du bras ? ",
    "Question 3 : Sentez-vous une diminution ou une disparaition du thrill(vibration) lorque vous posez votre main sur la fistule ?",
    "Question 4 : Avez-vous observé un soignement anormal ou un écoulement au niveau du point de ponction ?",
    "Question 5 : Avez-vous une douleur inhabutuelle , forte ou persistante dans le bras portant la fistule ?",
    "Question 6 : Avez-vous remarqué un changement de couleur du membrane (paleur) du coté de la fistule ?",
    "Question 7 : Avez-vous remarqué que la fistule est devenue plus grosse , déformé ou pulsatile comme un ballon ?",
  ];

  void submitForm(BuildContext context) async{
    if (answers.contains(null)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please answer all questions!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Form submitted successfully!")),
      );
      String? result = await service.ResponseChatGpt(image,answers);

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