// 単語帳のデータを扱うためのクラス
class Flashcard {
  Flashcard({this.id, this.name = ''});

  // 新規登録の場合はidはない場合もあるのでnullありにする
  int? id;
  String name;
}