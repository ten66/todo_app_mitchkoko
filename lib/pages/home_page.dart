import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app_mitchkoko/data/datapase.dart';
import 'package:todo_app_mitchkoko/util/dialog_box.dart';

import '../util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // reference the hive box
  final _myBox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    // if this is the 1st time ever opening the app, then create default data
    if (_myBox.get('TODOLIST') == null) {
      db.createInitialdata();
    } else {
      // there already exists data
      db.loadData();
    }

    super.initState();
  }

  // text contoller
  final _controller = TextEditingController();

  // checkboxがタップされた時
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      // なぜこれだけでタップするとチェックマークが付くのか(!に意味があるのかも)
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  // save new task
  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      // 保存後、textfieldに残った履歴を削除
      _controller.clear();
    });
    // 保存した後にdialogを消す処理
    Navigator.of(context).pop();
    db.updateDataBase();
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
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
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
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
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
