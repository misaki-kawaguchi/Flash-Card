import 'package:flashcard/models/flashcard.dart';
import 'package:flashcard/models/flashcard_card.dart';
import 'package:flashcard/repositories/flashcard_card_repository.dart';
import 'package:flashcard/routes.dart';
import 'package:flashcard/widgets/flashcard/flashcard_card_form.dart';
import 'package:flutter/material.dart';

class EditFlashcardPage extends StatefulWidget {
  const EditFlashcardPage({Key? key}) : super(key: key);

  // 編集用の単語帳データをargumentパラメータを指定してプロパティで受け取る
  static Future push(BuildContext context, Flashcard flashcard) async {
    return Navigator.of(context).pushNamed(flashcardEditPage, arguments: flashcard);
  }

  @override
  _EditFlashcardPageState createState() => _EditFlashcardPageState();
}

class _EditFlashcardPageState extends State<EditFlashcardPage> {

  late Flashcard _flashcard;

  @override
  void initState() {
    super.initState();

    // 諸々の準備が終わった後に初期化する
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      // パラメータを読み込む
      final flashcard = ModalRoute.of(context)!.settings.arguments as Flashcard;

      // _flashcardに反映
      setState(() {
        _flashcard = flashcard;
      });
    });
  }

  // カードを追加
  Future _addCard(String question, String answer) async {
    final flashcardCard = FlashcardCard(
      flashcardId: _flashcard.id!,
      question: question,
      answer: answer,
    );

    await FlashcardCardRepository.add(flashcardCard);

    print((await FlashcardCardRepository.all()).length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('単語帳を編集'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              FlashcardCardForm(onSave: _addCard),
            ],
          ),
        ),
      ),
    );
  }

  // TextEditingControllerはウィジェット上での利用が終わったあとはリソースを解放してあげる必要がある
  @override
  void dispose() {
    super.dispose();
  }
}
