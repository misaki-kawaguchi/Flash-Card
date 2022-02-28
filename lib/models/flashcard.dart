// 単語帳のデータを扱うためのクラス
import 'package:sembast/sembast.dart';

class Flashcard {
  Flashcard({this.id, this.name = ''});

  // 新規登録の場合はidはない場合もあるのでnullありにする
  int? id;
  String name;

  // データをMap型に変換する
  Map<String, Object?> toMap() {
    return <String, Object?>{
      'name': name,
    };
  }

  // スナップショットをモデルの型に変更する
  static Flashcard fromSnapshot(
    RecordSnapshot<int, Map<String, Object?>> snapshot,
  ) {
    return Flashcard(
      id: snapshot.key,
      name: snapshot['name'] as String,
    );
  }
}
