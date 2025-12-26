import 'package:FistulaCheck/resultai/resultaicontroller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AiResultPage extends StatelessWidget {
  final String aiAnswer;
  const AiResultPage({super.key, required this.aiAnswer});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (_) => Resultcontroller(aiAnswer),
    child: Consumer<Resultcontroller>(builder: (context, controller, child) {
      return Scaffold(
      appBar: AppBar(
        title: const Text("AI Discussion"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Column(
          children: [
            const Spacer(),

            // Chat bubble
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.all(16),
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.8,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: Text(
                  controller.displayedText,
                  style: TextStyle(
                    color: Colors.green.shade900,
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Spacer(),
          ],
        )
          ],
        ),
      ),
    );
    },),);
  }
}
