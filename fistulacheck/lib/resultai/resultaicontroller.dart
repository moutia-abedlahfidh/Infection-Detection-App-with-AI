import 'dart:async';

import 'package:flutter/material.dart';


class Resultcontroller extends ChangeNotifier {
  final String aiAnswer = ''; 
  String displayedText = "";
  int charIndex = 0;

  void _startTyping() {
    Timer.periodic(const Duration(milliseconds: 40), (timer) {
      if (charIndex < aiAnswer.length) {
          displayedText += aiAnswer[charIndex];
          charIndex++;
          notifyListeners();
      } else {
        timer.cancel();
      }
    });
  }

}