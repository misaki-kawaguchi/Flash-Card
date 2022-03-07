import 'package:flashcard/models/flashcard.dart';
import 'package:flashcard/routes.dart';
import 'package:flutter/material.dart';

class FlashcardPlayPage extends StatefulWidget {
  const FlashcardPlayPage({Key? key}) : super(key: key);

  static Future push(BuildContext context, Flashcard flashcard) async {
    return Navigator.of(context).pushNamed(
      flashcardPlayPage,
      arguments: flashcard,
    );
  }

  @override
  _FlashcardPlayPageState createState() => _FlashcardPlayPageState();
}

class _FlashcardPlayPageState extends State<FlashcardPlayPage> {
  Flashcard _getFlashcard() {
    return ModalRoute.of(context)!.settings.arguments as Flashcard;
  }

  @override
  Widget build(BuildContext context) {
    final flashcard = _getFlashcard();

    return Scaffold(
      appBar: AppBar(
        title: Text(flashcard.name),
      ),
      body: Container(
        child: Center(
          child: Image.asset('assets/images/card.png'),
        ),
      ),
    );
  }
}