import 'package:flashcard/models/flashcard_card.dart';
import 'package:flashcard/repositories/flashcard_card_repository.dart';
import 'package:flashcard/widgets/flashcard/flashcard_card_form.dart';
import 'package:flutter/material.dart';
import 'package:flashcard/routes.dart';

class EditFlashcardCardPage extends StatelessWidget {
  const EditFlashcardCardPage({Key? key}) : super(key: key);

  // 編集用のカードデータをargumentパラメータを指定してプロパティで受け取る
  static Future push(BuildContext context, FlashcardCard flashcardCard) async {
    return Navigator.of(context).pushNamed(flashcardCardEditPage, arguments: flashcardCard);
  }

  @override
  Widget build(BuildContext context) {

    FlashcardCard getFlashcardCard() {
      // パラメータを読み込む
      return ModalRoute.of(context)!.settings.arguments as FlashcardCard;
    }

    // 更新する
    Future update(String question, String answer) async {
      final flashcardCard = getFlashcardCard()
        ..question = question
        ..answer = answer;
      await FlashcardCardRepository.update(flashcardCard);

      Navigator.of(context).pop();
    }

    // 削除する
    Future delete() async {}

    final flashcardCard = getFlashcardCard();

    return Scaffold(
      appBar: AppBar(
        title: const Text('カードを編集'),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Form(
          child: Column(
            children: <Widget>[
              FlashcardCardForm(
                onSave: update,
                flashcardCard: flashcardCard,
                buttonText: '更新する',
              ),
              Container(
                margin: const EdgeInsets.only(top: 80),
                child: TextButton(
                  onPressed: delete,
                  style: TextButton.styleFrom(
                    primary: Theme.of(context).errorColor,
                  ),
                  child: const Text('削除'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
