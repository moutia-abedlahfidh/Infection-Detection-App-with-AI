import 'dart:io';
import 'package:fistulacheck/result.dart';
import 'package:fistulacheck/settings.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Two Pages Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UploadImagePage(),
    );
  }
}

class UploadImagePage extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(BuildContext context) async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => QuestionnairePage(image: File(image.path)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Accueil"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Description
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  "Cette application est conçue pour accompagner les patients "
                  "hémodialysés porteurs d’une fistule artério-veineuse (FAV).\n\n"
                  "Elle permet de surveiller l’état de la fistule, d’envoyer une image "
                  "pour une auto-évaluation guidée et de répondre à un court questionnaire "
                  "afin d’estimer le niveau de risque et la nécessité d’une consultation urgente.\n\n"
                  "Son objectif est de renforcer l’autonomie du patient, améliorer la détection "
                  "précoce des complications et soutenir l’éducation thérapeutique.\n\n"
                  "L’application propose également un espace personnel avec profil, paramètres "
                  "et choix de la langue pour une utilisation simple et personnalisée.",
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.5,
                  ),
                ),
              ),
            ),

            const Spacer(),

            // Upload button
            ElevatedButton.icon(
              icon: const Icon(Icons.upload_file),
              label: const Text("Téléverser une image"),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 14,
                ),
              ),
              onPressed: () => _pickImage(context),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.black,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey.shade400,
          type: BottomNavigationBarType.fixed,
          currentIndex: 0,
          onTap: (index) {
            if (index==1) {
              Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  SettingsPage()),
        );
            }},
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Paramètres'),
          ],
        ),
      )
    );
  }
}


// ---------------- Page 2: Questionnaire ----------------
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
