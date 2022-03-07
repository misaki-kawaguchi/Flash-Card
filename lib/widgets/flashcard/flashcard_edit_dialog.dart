import 'package:flashcard/models/flashcard.dart';
import 'package:flashcard/repositories/flashcard_card_repository.dart';
import 'package:flashcard/repositories/flashcard_repository.dart';
import 'package:flashcard/utils/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flashcard/widgets/flashcard/flashcard_form.dart';

class FlashcardEditDialog extends StatefulWidget {
  const FlashcardEditDialog({Key? key, required this.flashcard}) : super(key: key);

  final Flashcard flashcard;

  @override
  _FlashcardEditDialogState createState() => _FlashcardEditDialogState();
}

class _FlashcardEditDialogState extends State<FlashcardEditDialog> {

  // フォームと連携させるためのGlobalKey
  final _formKey = GlobalKey<FormState>();

  // 名前編集欄用のコントローラー（フォームの値を管理）
  final _nameController = TextEditingController();

  // 諸々の準備が終わった後に初期化する
  @override
  void initState() {
    super.initState();

    // 諸々の準備が終わった後に初期化する
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _nameController.text = widget.flashcard.name;
    });
  }

  // 更新ボタンが押された時にバリデーションを働かせる
  Future _save() async {
    // フォーム内のバリデーションを実行する
    // currentState!：nullではないことを表す
    if (!_formKey.currentState!.validate()) {
      return;
    }

    Navigator.of(context).pop(_nameController.text);
  }

  // 削除する
  Future _delete() async {
    if (!await Dialogs.confirm(context, '削除', '削除してよろしいですか？')) {
      return;
    }

    await FlashcardCardRepository.deleteByFlashcardId(widget.flashcard.id!);
    await FlashcardRepository.delete(widget.flashcard.id!);

    const snackBar = SnackBar(content: Text('削除しました'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('単語帳を編集'),
      content: Form(
        key: _formKey,
        child: Column(
          // Columnの長さを小さくする
          mainAxisSize: MainAxisSize.min,
          children: [
            FlashcardForm(nameController: _nameController),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: TextButton(
                onPressed: _delete,
                style: TextButton.styleFrom(
                  primary: Theme.of(context).errorColor,
                ),
                child: const Text('削除'),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('キャンセル'),
        ),
        ElevatedButton(
          onPressed: _save,
          child: const Text('更新'),
        ),
      ],
    );
  }

  // TextEditingControllerはウィジェット上での利用が終わったあとはリソースを解放してあげる必要がある
  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
