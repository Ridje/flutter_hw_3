
import 'package:flutter_hw_3/tasks/presentation/tasks/state/task.dart';

abstract class TasksEvent {}

class AddTask implements TasksEvent {}

class RemoveTask implements TasksEvent {
  final Task task;

  RemoveTask(this.task);
}

class EditTask implements TasksEvent {
  final Task task;

  EditTask({required this.task});
}

class SaveTask implements TasksEvent {}

class InputChangedTask implements TasksEvent {
  final String newInput;

  InputChangedTask({required this.newInput});
}

class CancelledEditTask implements TasksEvent {}