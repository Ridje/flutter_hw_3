import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hw_3/tasks/state/task.dart';
import 'package:flutter_hw_3/tasks/state/task_event.dart';
import 'package:flutter_hw_3/tasks/state/task_state.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
        builder: (context, state) => ListView.separated(
            itemBuilder: (context, index) => TaskRow(task: state.tasks[index]),
            separatorBuilder: (BuildContext context, int index) => const Divider(),
            itemCount: state.tasks.length));
  }
}

class TaskRow extends StatelessWidget {
  final Task task;

  const TaskRow({super.key, required this.task});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () => {BlocProvider.of<TasksBloc>(context).add(EditTask(task: task))},
            color: Colors.blue,
            icon: const Icon(Icons.edit)),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(task.name, style: Theme.of(context).textTheme.bodyLarge),
        )),
        IconButton(
            onPressed: () => {BlocProvider.of<TasksBloc>(context).add(RemoveTask(task))}, color: Colors.red, icon: const Icon(Icons.delete))
      ],
    );
  }
}
