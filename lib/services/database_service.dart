import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

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

  // late：デフォルト値を入れておかなくても null 許容でない値として扱うことができる
  late Database _db;

  // 初期化
  Future initialize() async {
    // アプリケーション実行時に読み書きできるフォルダの位置を取得する
    final dir = await getApplicationDocumentsDirectory();
    final path = join(dir.path, 'databse.db');

    // データベースファクトリを使用してデータベースを開く
    _db = await databaseFactoryIo.openDatabase(path);
  }

  // DatabaseService().dbのような形でDatabaseを参照して利用できるようになる
  Database get db => _db;
}