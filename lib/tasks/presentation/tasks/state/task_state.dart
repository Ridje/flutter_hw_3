import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hw_3/tasks/presentation/tasks/state/task.dart';
import 'package:flutter_hw_3/tasks/presentation/tasks/state/task_event.dart';

class TasksState {
  final List<Task> tasks;
  final Task? edit;
  final String input;
  String get addSaveButtonTitle => edit == null ? "Добавить" : "Сохранить";

  TasksState._({required this.tasks, required this.edit, required this.input});

  factory TasksState.initial() {
    return TasksState._(tasks: [], edit: null, input: "");
  }

  factory TasksState.fromTasks(List<Task> tasks, Task? editTask, String input) {
    return TasksState._(tasks: tasks, edit: editTask, input: input);
  }
}

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TasksBloc() : super(TasksState.initial()) {
    on<AddTask>((event, emit) {
      emit(TasksState.fromTasks(
          state.tasks..add(Task(name: state.input)), null, ""));
    });
    on<RemoveTask>((event, emit) {
      if (state.tasks.remove(event.task)) {
        emit(TasksState.fromTasks(state.tasks, null, state.input));
      }
    });
    on<EditTask>((event, emit) {
      emit(TasksState.fromTasks(state.tasks, event.task, event.task.name));
    });
    on<CancelledEditTask>((event, emit) {
      emit(TasksState.fromTasks(state.tasks, null, ""));
    });
    on<SaveTask>((event, emit) {
      state.tasks.firstWhere((element) => element == state.edit).name =
          state.input;
      emit(TasksState.fromTasks(state.tasks, null, ""));
    });
    on<InputChangedTask>((event, emit) {
      emit(TasksState.fromTasks(state.tasks, state.edit, event.newInput));
    });
  }
}
