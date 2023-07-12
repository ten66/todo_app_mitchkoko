import 'package:flutter/material.dart';

class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;

  // requiredとは? ->
  ToDoTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
      child: Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.yellow,
          // 角を取る
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // checkbox -> flutterでWidgetとして用意されている
            Checkbox(
              value: taskCompleted,
              onChanged: onChanged,
              // [original]チェックボックスの色がわかりづらいため、オレンジに変更
              activeColor: Colors.orange,
            ),

            // タスクの名前
            Text(
              taskName,
              style: TextStyle(
                // 三項演算子
                // チェックボックスにチェックがついているかどうかでテキストに線を入れる
                decoration: taskCompleted
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
