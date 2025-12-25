import 'dart:io';
import 'package:fistulacheck/quiz/quizscreen.dart';
import 'package:fistulacheck/settings/settingscreen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
              child: const Padding(
                padding: EdgeInsets.all(16),
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
                  style: TextStyle(
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
          MaterialPageRoute(builder: (context) =>  const SettingsPage()),
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