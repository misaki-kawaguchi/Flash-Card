import 'package:flashcard/pages/flashcard/edit_card.dart';
import 'package:flutter/material.dart';
import 'package:flashcard/models/flashcard_card.dart';

class FlashcardCardList extends StatelessWidget {
  const FlashcardCardList({
    Key? key,
    required this.flashcardCards,
    required this.onUpdate,
  }) : super(key: key);

  final List<FlashcardCard> flashcardCards;

  final Function() onUpdate;

  @override
  Widget build(BuildContext context) {

    // 編集ページに遷移する
    Future goToEdit(FlashcardCard flashcardCard) async {
      await EditFlashcardCardPage.push(context, flashcardCard);
      onUpdate();
    }

    // カード一覧
    Widget buildRow(int index) {
      final flashcardCard = flashcardCards[index];

      return ListTile(
        title: Text(flashcardCard.question),
        subtitle: Text(flashcardCard.answer),
        onTap: () => goToEdit(flashcardCard),
      );
    }

    // 区切り線をつけたListView
    return ListView.separated(
      // メッセージを表示するウィジェット
      itemBuilder: (context, index) => buildRow(index),
      // 区切り線
      separatorBuilder: (context, index) => const Divider(),
      // リストの数
      itemCount: flashcardCards.length,
    );
  }
}
