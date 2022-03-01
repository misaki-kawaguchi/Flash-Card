import 'package:flashcard/models/flashcard.dart';
import 'package:flashcard/pages/flashcard/edit.dart';
import 'package:flashcard/repositories/flashcard_repository.dart';
import 'package:flutter/material.dart';
import 'package:flashcard/routes.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  // リスト一覧
  List<Flashcard> _flashcards = [];

  Future _loadFlashcards() async {
    // 全てのデータを取得
    final flashcards = await FlashcardRepository.all();
    setState(() {
      _flashcards = flashcards;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadFlashcards();
  }

  //新規登録ページに遷移
  Future _goToCreatePage() async {
    await Navigator.of(context).pushNamed(flashcardCreatePage);
    await _loadFlashcards();
  }

  // 編集ページに遷移
  Future _goToEditPage(Flashcard flashcard) async {
    await EditFlashcardPage.push(context, flashcard);
    await _loadFlashcards();
  }

  Widget _buildListRow(BuildContext context, int index) {
    final flashcard = _flashcards[index];
    return ListTile(
      title: Text(flashcard.name),
      onTap: () => _goToEditPage(flashcard),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('単語帳'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            // 区切り線をつけたListView
            child: ListView.separated(
              //  Columnの中でもListViewのサイズが決まるようにする
              shrinkWrap: true,
              // メッセージを表示するウィジェット
              itemBuilder: _buildListRow,
              // 区切り線
              // BuildContext：これからつくる(buildする) Widgetが実際にどんな場所でどんな風に使われるのかを知るためのもの
              // index：何行目かを表す
              separatorBuilder: (BuildContext context, int index) => const Divider(),
              // リストの数
              itemCount: _flashcards.length,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _goToCreatePage,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
