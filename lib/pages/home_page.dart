import 'package:flutter/material.dart';
import 'package:todo_app_mitchkoko/util/dialog_box.dart';

import '../util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // text contoller
  final _controller = TextEditingController();

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

  // save new task
  void saveNewTask() {
    setState(() {
      toDoList.add([_controller.text, false]);
      // 保存後、textfieldに残った履歴を削除
      _controller.clear();
    });
    // 保存した後にdialogを消す処理
    Navigator.of(context).pop();
  }

  // create a new task
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          // セーブボタンが押された時の処理
          onSave: saveNewTask,
          // キャンセルボタンが押された時の処理
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  // delete task
  void deleteTask(int index) {
    setState(() {
      toDoList.removeAt(index);
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
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
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
            deleteFunction: (context) => deleteTask(index),
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
