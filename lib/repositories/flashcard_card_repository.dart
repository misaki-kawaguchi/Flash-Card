import 'package:flashcard/models/flashcard_card.dart';
import 'package:flashcard/services/database_service.dart';
import 'package:sembast/sembast.dart';

class FlashcardCardRepository {

  // キー値を文字列として保存するためのメインストアを設定
  static StoreRef<int, Map<String, Object?>> store() {
    // キーをint、値をMapとして格納する（flashcardsというデータストアを定義して利用 ）
    return intMapStoreFactory.store('flashcard_cards');
  }

  // データをstoreに保存する
  static Future<int> add(FlashcardCard flashcardCard) async {
    final db = DatabaseService().db;
    return store().add(db, flashcardCard.toMap());
  }

  // 保存したデータを取得する
  static Future<List<FlashcardCard>> findByFlashcardId(int flashcardId) async {
    final db = DatabaseService().db;
    // store からデータの一覧を取得する
    final records = await store().find(
      db,
      finder: Finder(
        filter: Filter.equals('flashcardId', flashcardId),
      ),
    );
    //  IterableからList型に戻す
    return records.map((record) => FlashcardCard.fromSnapshot(record)).toList();
  }

  // データを更新する
  static Future update(FlashcardCard flashcardCard) async {
    final db = DatabaseService().db;
    // recordにIDを指定してupdateを実行する
    // 編集画面からしか呼ばれないので必ずidが入っている前提としてビックリマークをつける
    return store().record(flashcardCard.id!).update(db, flashcardCard.toMap());
  }

  // データを削除する
  static Future delete(int id) async {
    final db = DatabaseService().db;
    await store().record(id).delete(db);
  }

  // FlashcardCardRepositoryに指定した単語帳IDのカードだけを削除する
  static Future deleteByFlashcardId(int flashcardId) async {
    final db = DatabaseService().db;
    await store().delete(
      db,
      finder: Finder(
        filter: Filter.equals('flashcardId', flashcardId),
      ),
    );
  }
}