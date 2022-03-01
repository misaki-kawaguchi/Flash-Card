import 'package:sembast/sembast.dart';

// 単語カードのデータを扱うためのクラス
class FlashcardCard {
  FlashcardCard({
    this.id,
    required this.flashcardId,
    this.question = '',
    this.answer = '',
  });

  // 新規登録の場合はidはない場合もあるのでnullありにする
  int? id;
  final int flashcardId;
  String question;
  String answer;

  // データをMap型に変換する
  Map<String, Object?> toMap() {
    return <String, Object?>{
      'flashcardId': flashcardId,
      'question': question,
      'answer': answer,
    };
  }

  // スナップショットをモデルの型に変更する
  static FlashcardCard fromSnapshot(
      RecordSnapshot<int, Map<String, Object?>> snapshot,
      ) {
    return FlashcardCard(
      id: snapshot.key,
      flashcardId: snapshot['flashcardId'] as int,
      question: snapshot['question'] as String,
      answer: snapshot['answer'] as String,
    );
  }
}
