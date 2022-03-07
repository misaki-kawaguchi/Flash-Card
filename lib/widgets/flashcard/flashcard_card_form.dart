import 'package:flashcard/models/flashcard_card.dart';
import 'package:flutter/material.dart';

class FlashcardCardForm extends StatelessWidget {
  FlashcardCardForm(
      {Key? key,
      required this.onSave,
      this.buttonText = 'カードを追加',
      FlashcardCard? flashcardCard})
      : _questionController =
            TextEditingController(text: flashcardCard?.question ?? ''),
        _answerController = TextEditingController(text: flashcardCard?.answer ?? ''),
        super(key: key);

  // 質問と回答を保存する
  final void Function(String question, String answer) onSave;

  // フォームと連携させるためのGlobalKey
  final _formKey = GlobalKey<FormState>();

  // 質問用のコントローラー（フォームの値を管理）
  final TextEditingController _questionController;

  // 回答用のコントローラー（フォームの値を管理）
  final TextEditingController _answerController;

  // テキストを初期化
  final String buttonText;

  // 保存する
  Future _save() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    onSave(
      _questionController.text,
      _answerController.text,
    );

    _questionController.text = '';
    _answerController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _questionController,
            decoration: const InputDecoration(
              labelText: '質問',
              hintText: '質問',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return '入力してください';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _answerController,
            decoration: const InputDecoration(
              labelText: '回答',
              hintText: '回答',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return '入力してください';
              }
              return null;
            },
          ),
          Container(
            margin: const EdgeInsets.only(top: 20.0),
            child: ElevatedButton(
              onPressed: _save,
              child: Text(buttonText),
            ),
          ),
        ],
      ),
    );
  }
}
