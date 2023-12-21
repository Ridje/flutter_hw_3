import 'package:flutter/material.dart';

class TasksTitle extends StatelessWidget {
  const TasksTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text("Задачи", style: Theme.of(context).textTheme.headlineSmall);
  }
}
