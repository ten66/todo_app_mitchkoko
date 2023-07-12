import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      body: ListView(
        children: [
          ToDoList(),
        ],
      ),
    );
  }
}
