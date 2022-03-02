import 'package:flutter/material.dart';

class FlashcardEditDialog extends StatefulWidget {
  const FlashcardEditDialog({Key? key}) : super(key: key);

  @override
  _FlashcardEditDialogState createState() => _FlashcardEditDialogState();
}

class _FlashcardEditDialogState extends State<FlashcardEditDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('単語帳を編集'),
      content: Container(),
      actions: [],
    );
  }
}
