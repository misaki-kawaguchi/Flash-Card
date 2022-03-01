import 'package:flashcard/models/flashcard.dart';
import 'package:flashcard/repositories/flashcard_repository.dart';
import 'package:flashcard/routes.dart';
import 'package:flashcard/widgets/flashcard/flashcard_form.dart';
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
        title: const Text('単語帳を編集'),
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
                      child: const Text('更新'),
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
