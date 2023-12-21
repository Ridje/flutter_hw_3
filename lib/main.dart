import 'package:flutter/material.dart';
import 'package:flutter_hw_3/tasks/state/task_event.dart';
import 'package:flutter_hw_3/tasks/widget/task_add_save_button.dart';
import 'package:flutter_hw_3/tasks/widget/task_name_text_field.dart';
import 'package:flutter_hw_3/tasks/widget/task_list.dart';
import 'package:flutter_hw_3/tasks/state/task_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hw_3/tasks/widget/task_title.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tasks tracker application',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  void _handleButtonPress(BuildContext context) {
    final taskBloc = context.read<TasksBloc>();

    if (taskBloc.state.edit == null) {
      taskBloc.add(AddTask());
    } else {
      taskBloc.add(SaveTask());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TasksBloc(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Мои задачи"),
        ),
        body: BlocBuilder<TasksBloc, TasksState>(
          builder: (context, state) => PopScope(
            canPop: state.edit == null,
            onPopInvoked: (didPop) {
              if (!didPop && state.edit != null) {
                context.read<TasksBloc>().add(CancelledEditTask());
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const TasksTitle(),
                  const SizedBox(height: 18),
                  TaskNameTextField(onEditingCompleted: _handleButtonPress),
                  const SizedBox(height: 18),
                  AddSaveTaskButton(onButtonPressed: _handleButtonPress, title: state.addSaveButtonTitle),
                  const SizedBox(height: 18),
                  const Expanded(child: TaskList()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
