import 'package:flashcard/models/flashcard.dart';
import 'package:flashcard/models/flashcard_card.dart';
import 'package:flashcard/repositories/flashcard_card_repository.dart';
import 'package:flashcard/routes.dart';
import 'package:flutter/material.dart';

enum AnimationType {
  none,
  flipIn,
  flipOut,
  appear,
  disappear,
}

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

  AnimationType _animationType = AnimationType.none;

  double _getAnimationWidth() {
    if (_animationType == AnimationType.flipOut) {
      return 1;
    }
    return MediaQuery.of(context).size.width - margin * 2;
  }

  Widget _buildCard() {
    return AspectRatio(
      aspectRatio: 512 / 200,
      child: Stack(
        children: [
          Image.asset('assets/images/card.png'),
          Positioned.fill(
            child: Center(child: _buildCardContainer()),
          ),
        ],
      ),
    );
  }

  Widget _buildCardWithAnimation() {
    if (_flashcardCards.isEmpty) {
      return Container();
    }

    return AnimatedOpacity(
      duration: const Duration(milliseconds: animationDuration),
      opacity: _animationType == AnimationType.disappear ? 0 : 1,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: animationDuration),
        width: _getAnimationWidth(),
        curve: Curves.fastOutSlowIn,
        child: _buildCard(),
      ),
    );
  }

  static const int animationDuration = 200;
  static const double margin = 20;

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

  // タップされた時の処理
  Future _next() async {
    if (_isQuestion) {
      setState(() {
        _animationType = AnimationType.flipOut;
      });
      await Future.delayed(const Duration(milliseconds: animationDuration));
      setState(() {
        _isQuestion = false;
        _animationType = AnimationType.flipIn;
      });
      await Future.delayed(const Duration(milliseconds: animationDuration));
      setState(() {
        _animationType = AnimationType.none;
      });
      return;
    }

    if (_index == _flashcardCards.length - 1) {
      return;
    }

    setState(() {
      _animationType = AnimationType.disappear;
    });
    await Future.delayed(const Duration(milliseconds: 600));
    setState(() {
      _isQuestion = true;
      _index++;
    });
    setState(() {
      _animationType = AnimationType.appear;
    });
    await Future.delayed(const Duration(milliseconds: animationDuration));
    setState(() {
      _animationType = AnimationType.none;
    });
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
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _next,
        child: Container(
          child: Center(
            child: Container(
              margin: EdgeInsets.all(margin),
              child: _buildCardWithAnimation(),
            ),
          ),
        ),
      ),
    );
  }
}