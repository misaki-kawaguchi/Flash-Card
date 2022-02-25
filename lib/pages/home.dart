import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Widget _buildListRow(BuildContext context, int index) {
    return ListTile(
      title: const Text('タイトル'),
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
              itemCount: 20,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => print('pressed'),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
