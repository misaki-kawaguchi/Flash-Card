import 'package:flashcard/models/flashcard.dart';
import 'package:flashcard/services/database_service.dart';
import 'package:sembast/sembast.dart';

class FlashcardRepository {

  // キー値を文字列として保存するためのメインストアを設定
  static StoreRef<int, Map<String, Object?>> store() {
    // キーをint、値をMapとして格納する（flashcardsというデータストアを定義して利用 ）
    return intMapStoreFactory.store('flashcards');
  }

  // データをstoreに保存する
  static Future<int> add(Flashcard flashcard) async {
    final db = DatabaseService().db;
    return store().add(db, flashcard.toMap());
  }

  // 保存したデータを取得する
  static Future<List<Flashcard>> all() async {
    final db = DatabaseService().db;
    // store からデータの一覧を取得する
    final records = await store().find(db);
    //  IterableからList型に戻す
    return records.map((record) => Flashcard.fromSnapshot(record)).toList();
  }
}