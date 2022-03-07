import 'package:flashcard/models/flashcard.dart';
import 'package:flashcard/models/flashcard_card.dart';
import 'package:flashcard/repositories/flashcard_card_repository.dart';
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

  List<FlashcardCard> _flashcardCards = [];
  // 現在何枚目のカードであるか
  int _index = 0;
  // 現在質問表示中であるか
  bool _isQuestion = true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _initialize();
    });
  }

  Future _initialize() async {
    final flashcard = _getFlashcard();
    final flashcardCards =
    await FlashcardCardRepository.findByFlashcardId(flashcard.id!);
    // 並び順をランダムにしてからステートに入れておく
    flashcardCards.shuffle();
    setState(() {
      _flashcardCards = flashcardCards;
    });
  }
  String _getCardText() {
    final flashcardCard = _flashcardCards[_index];
    return _isQuestion ? flashcardCard.question : flashcardCard.answer;
  }

  Widget _buildCardContainer() {
    if (_flashcardCards.isEmpty) {
      return Container();
    }

    return Text(
      _getCardText(),
      style: const TextStyle(
        fontSize: 20,
      ),
      textAlign: TextAlign.center,
    );
  }


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
          child: Container(
            margin: const EdgeInsets.all(20),
            child: AspectRatio(
              aspectRatio: 512 / 200,
              child: Stack(
                children: [
                  Image.asset('assets/images/card.png'),
                  Positioned.fill(
                    child: Center(child: _buildCardContainer()),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}