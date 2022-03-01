import 'package:flashcard/models/flashcard.dart';
import 'package:flashcard/repositories/flashcard_repository.dart';
import 'package:flashcard/routes.dart';
import 'package:flashcard/widgets/flashcard/flashcard_card_form.dart';
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

  late Flashcard _flashcard;

  @override
  void initState() {
    super.initState();

    // 諸々の準備が終わった後に初期化する
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      // パラメータを読み込む
      final flashcard = ModalRoute.of(context)!.settings.arguments as Flashcard;

      // 作成した名前を代入
      _nameController.text = flashcard.name;

      // _flashcardに反映
      setState(() {
        _flashcard = flashcard;
      });
    });
  }

  // 更新ボタンが押された時にバリデーションを働かせる
  Future _save() async {
    // フォーム内のバリデーションを実行する
    // currentState!：nullではないことを表す
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // 名前を更新する
    _flashcard.name = _nameController.text;
    await FlashcardRepository.update(_flashcard);

    // 完了メッセージを表示
    const snackBar = SnackBar(content: Text('名前を更新しました。'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    FlashcardForm(nameController: _nameController),
                    Container(
                      margin: const EdgeInsets.only(top: 20.0),
                      child: ElevatedButton(
                        onPressed: _save,
                        child: const Text('更新'),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20.0),
                      child: Text(
                        'カードを追加',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    FlashcardCardForm(),
                  ],
                ),
              ),
            ],
          ),
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
