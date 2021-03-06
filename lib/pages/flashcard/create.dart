import 'package:flashcard/models/flashcard.dart';
import 'package:flashcard/repositories/flashcard_repository.dart';
import 'package:flashcard/widgets/flashcard/flashcard_form.dart';
import 'package:flutter/material.dart';

class CreateFlashcardPage extends StatefulWidget {
  const CreateFlashcardPage({Key? key}) : super(key: key);

  @override
  _CreateFlashcardPageState createState() => _CreateFlashcardPageState();
}

class _CreateFlashcardPageState extends State<CreateFlashcardPage> {

  // フォームと連携させるためのGlobalKey
  final _formKey = GlobalKey<FormState>();

  // 名前編集欄用のコントローラー（フォームの値を管理）
  final _nameController = TextEditingController();

  // 新規登録ボタンが押された時にバリデーションを働かせる
  Future _save() async {
    // フォーム内のバリデーションを実行する
    // currentState!：nullではないことを表す
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Flashcardモデルのインスタンスを作成
    final flashcard = Flashcard(name: _nameController.text);
    // データを保存
    await FlashcardRepository.add(flashcard);

    // 前の画面に戻る
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('単語帳を作成'),
      ),
      body: Container(
        margin: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: [
                  FlashcardForm(nameController: _nameController),
                  Container(
                    margin: const EdgeInsets.all(20.0),
                    child: ElevatedButton(
                      onPressed: _save,
                      child: const Text('登録'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // TextEditingControllerはウィジェット上での利用が終わったあとはリソースを解放してあげる必要がある
  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
