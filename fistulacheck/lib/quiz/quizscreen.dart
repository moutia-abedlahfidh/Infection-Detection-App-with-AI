
import 'dart:io';

import 'package:FistulaCheck/quiz/quizcontroller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuestionnairePage extends StatelessWidget {
  final File image;
  QuestionnairePage({required this.image});
  

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (_)=>Quizcontroller(image : image),
    child: Consumer<Quizcontroller>(builder: (context, controller, child) {
      return Scaffold(
      appBar: AppBar(
        title: Text('Questionnaire'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Image.file(image, height: 200),
            SizedBox(height: 20),
            ...List.generate(7, (index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(controller.questions[index], style: TextStyle(fontSize: 16)),
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile<bool>(
                          title: Text('Yes'),
                          value: true,
                          groupValue: controller.answers[index],
                          onChanged: (val) {
                            controller.onChnageAnswer(val ?? false,index);
                              
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<bool>(
                          title: Text('No'),
                          value: false,
                          groupValue: controller.answers[index],
                          onChanged: (val) {
                              controller.onChnageAnswer(val ?? false,index);
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
              onPressed: ()=>controller.submitForm(context),
              child: Text("Submit"),
            ),
          ],
        ),
      ),
    );
    },),);
  }
}
