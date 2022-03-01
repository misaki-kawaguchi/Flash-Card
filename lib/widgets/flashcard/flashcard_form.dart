import 'package:flutter/material.dart';

class FlashcardForm extends StatelessWidget {
  const FlashcardForm({Key? key, required this.nameController})
      : super(key: key);

  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: nameController,
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
    );
  }
}
