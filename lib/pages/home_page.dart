import 'package:flutter/material.dart';

import '../util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // todoタスクのリスト
  List toDoList = [
    ['Make Tutorial', false],
    ['Do Exercise', false],
  ];

  // checkboxがタップされた時
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      // なぜこれだけでタップするとチェックマークが付くのか(!に意味があるのかも)
      toDoList[index][1] = !toDoList[index][1];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 背景色
      backgroundColor: Colors.yellow[200],
      // 上部のステータスバー
      appBar: AppBar(
        // タイトル
        title: Text('TO DO'),
        // appbarの境界をなくす
        elevation: 0,
      ),
      // ListViewとは？
      // ListViewとListView.builderの違い
      body: ListView.builder(
        // ListViewのitemCountとは
        itemCount: toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: toDoList[index][0],
            taskCompleted: toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
          );
        },
        // children: [
        //   ToDoTile(
        //     taskName: 'Make Tutorial',
        //     taskCompleted: true,
        //     onChanged: (p0) {},
        //   ),
        //   ToDoTile(
        //     taskName: 'Do Exercise',
        //     taskCompleted: false,
        //     onChanged: (p0) {},
        //   ),
        // ],
      ),
    );
  }
}
