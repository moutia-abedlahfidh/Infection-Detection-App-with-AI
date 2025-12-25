import 'dart:async';
import 'package:flutter/material.dart';

class AiResultPage extends StatefulWidget {
  final String aiAnswer;

  const AiResultPage({
    Key? key,
    required this.aiAnswer,
  }) : super(key: key);

  @override
  State<AiResultPage> createState() => _AiResultPageState();
}

class _AiResultPageState extends State<AiResultPage> {
  String displayedText = "";
  int charIndex = 0;

  @override
  void initState() {
    super.initState();
    _startTyping();
  }

  void _startTyping() {
    Timer.periodic(const Duration(milliseconds: 40), (timer) {
      if (charIndex < widget.aiAnswer.length) {
        setState(() {
          displayedText += widget.aiAnswer[charIndex];
          charIndex++;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  displayedText,
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
  }
}
