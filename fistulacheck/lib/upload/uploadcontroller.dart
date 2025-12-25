import 'dart:io';

import 'package:fistulacheck/quiz/quizscreen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class Uploadcontroller extends ChangeNotifier {

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(BuildContext context) async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => QuestionnairePage(image: File(image.path)),
      ),
    );
  }
}