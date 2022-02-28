// データベース管理用クラス（シングルトンとして作成して利用することによってどこでも共通の値を利用することができる）
class DatabaseService {

  // クラスのスタティックメンバとしてインスタンスのキャッシュを保持する（static変数へ自身の参照を保存）
  static DatabaseService? _instance;

  // インスタンスのキャッシュを返すメソッド（ファクトリーメソッド）を実装
  factory DatabaseService() {
    // _instanceがnullならDatabaseService._internal()を返す
    _instance ??= DatabaseService._internal();
    return _instance!;
  }

  // デフォルトのコンストラクタをプライベートアクセス
  DatabaseService._internal();
}