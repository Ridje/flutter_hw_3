import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hw_3/tasks/presentation/state/task_event.dart';
import 'package:flutter_hw_3/tasks/presentation/state/task_state.dart';

class TaskNameTextField extends StatefulWidget {
  final Function(BuildContext) onEditingCompleted;
  const TaskNameTextField({super.key, required this.onEditingCompleted});

  @override
  State<StatefulWidget> createState() {
    return _TaskNameTextFieldState();
  }
}

class _TaskNameTextFieldState extends State<TaskNameTextField> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<TasksBloc, TasksState>(
      listener: (context, state) {
        if (state.input != _controller.text) {
          _controller.text = state.input;
        }
      },
      child: TextField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Название задачи',
        ),
        onChanged: (value) => {context.read<TasksBloc>().add(InputChangedTask(newInput: value))},
        controller: _controller,
        onEditingComplete: () => {widget.onEditingCompleted(context)},
      ),
    );
  }
}
