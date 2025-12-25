

import 'dart:io';
import 'package:fistulacheck/resultai/resultaiscreen.dart';
import 'package:flutter/material.dart';

class QuestionnairePage extends StatefulWidget {
  final File image;
  QuestionnairePage({required this.image});

  @override
  _QuestionnairePageState createState() => _QuestionnairePageState();
}

class _QuestionnairePageState extends State<QuestionnairePage> {
  // Store answers
  List<bool?> answers = List.filled(7, null);

  final questions = [
    "Question 1?",
    "Question 2?",
    "Question 3?",
    "Question 4?",
    "Question 5?",
    "Question 6?",
    "Question 7?",
  ];

  void _submitForm() {
    if (answers.contains(null)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please answer all questions!")),
      );
    } else {
      print("Answers: $answers");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Form submitted successfully!")),
      );
      Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => AiResultPage(
      aiAnswer:
          "Based on the uploaded image and your answers, no major issues were detected. "
          "Everything looks normal at this stage.",
    ),
  ),
);

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Questionnaire'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Image.file(widget.image, height: 200),
            SizedBox(height: 20),
            ...List.generate(7, (index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(questions[index], style: TextStyle(fontSize: 16)),
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile<bool>(
                          title: Text('Yes'),
                          value: true,
                          groupValue: answers[index],
                          onChanged: (val) {
                            setState(() {
                              answers[index] = val;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<bool>(
                          title: Text('No'),
                          value: false,
                          groupValue: answers[index],
                          onChanged: (val) {
                            setState(() {
                              answers[index] = val;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                ],
              );
            }),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
