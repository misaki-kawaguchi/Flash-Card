import 'package:flutter/material.dart';
import 'package:flashcard/routes.dart';
import 'package:flashcard/services/database_service.dart';

Future main() async {
  // まだデータベースファイルを保存するためのフォルダの位置を取得するための初期化などがFlutterエンジン側でできていないので完了した状態にする
  WidgetsFlutterBinding.ensureInitialized();
  // データベースの初期化を実行する
  await DatabaseService().initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: routes,
    );
  }
}
