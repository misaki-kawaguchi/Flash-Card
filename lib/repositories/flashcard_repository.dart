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
}