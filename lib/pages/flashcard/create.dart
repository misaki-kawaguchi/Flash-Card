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

  // TextEditingControllerはウィジェット上での利用が終わったあとはリソースを解放してあげる必要がある
  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  // 新規登録ボタンが押された時にバリデーションを働かせる
  void _save() {
    // フォーム内のバリデーションを実行する
    // currentState!：nullではないことを表す
    if (!_formKey.currentState!.validate()) {
      return;
    }
    print('ok');
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
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: '名前',
                      hintText: '名前',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return '入力してください';
                      }
                      // 入力値が正常な場合はnullを返す
                      return null;
                    },
                  ),
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
}
