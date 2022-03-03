import 'package:flutter/material.dart';
import 'package:flashcard/models/flashcard_card.dart';

class FlashcardCardList extends StatelessWidget {
  const FlashcardCardList({
    Key? key,
    required this.flashcardCards,
  }) : super(key: key);

  final List<FlashcardCard> flashcardCards;

  // カード一覧
  Widget _buildRow(int index) {
    final flashcardCard = flashcardCards[index];

    return ListTile(
      title: Text(flashcardCard.question),
      subtitle: Text(flashcardCard.answer),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 区切り線をつけたListView
    return ListView.separated(
      // メッセージを表示するウィジェット
      itemBuilder: (context, index) => _buildRow(index),
      // 区切り線
      separatorBuilder: (context, index) => const Divider(),
      // リストの数
      itemCount: flashcardCards.length
    );
  }
}
