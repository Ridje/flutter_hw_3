import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hw_3/tasks/domain/add_task_use_case.dart';
import 'package:flutter_hw_3/tasks/domain/delete_task_use_case.dart';
import 'package:flutter_hw_3/tasks/domain/get_tasks_use_case.dart';
import 'package:flutter_hw_3/tasks/domain/update_task_use_case.dart';
import 'package:flutter_hw_3/tasks/presentation/tasks/state/task.dart';
import 'package:flutter_hw_3/tasks/presentation/tasks/state/task_event.dart';
import 'package:injectable/injectable.dart';

class TasksState {
  final List<Task> tasks;
  final Task? edit;
  final String input;
  final bool showLoader;

  TasksState._({required this.tasks, required this.edit, required this.input, required this.showLoader,});

  factory TasksState._initial() {
    return TasksState._(tasks: [], edit: null, input: "", showLoader: true);
  }

  factory TasksState._showLoader(TasksState state) {
    return TasksState._(tasks: state.tasks, edit: state.edit, input: state.input, showLoader: true);
  }

  factory TasksState._fromTasks(List<Task> tasks, Task? editTask, String input) {
    return TasksState._(tasks: tasks, edit: editTask, input: input, showLoader: false);
  }
}

@Injectable()
class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final GetTasksUseCase _getTasks;
  final AddTaskUseCase _addTask;
  final DeleteTaskUseCase _deleteTask;
  final UpdateTaskUseCase _updateTask;

  TasksBloc(this._getTasks, this._addTask, this._deleteTask, this._updateTask) : super(TasksState._initial()) {
    on<LoadTasks>((event, emit) async {
      emit(await onLoadTasks(state));
    });
    on<AddTask>((event, emit) async {
      emit(TasksState._showLoader(state));
      emit(await onAddTask(state));
    });
    on<RemoveTask>((event, emit) {
      if (state.tasks.remove(event.task)) {
        emit(onDeleteTask(state, event.task));
      }
    });
    on<EditTask>((event, emit) {
      emit(TasksState._fromTasks(state.tasks, event.task, event.task.name));
    });
    on<CancelledEditTask>((event, emit) {
      emit(TasksState._fromTasks(state.tasks, null, ""));
    });
    on<SaveTask>((event, emit) async {
      final edit = state.edit;
      if (edit != null) {
        emit(TasksState._showLoader(state));
        emit(await onSaveTask(state, edit));
      }
    });
    on<InputChangedTask>((event, emit) {
      emit(TasksState._fromTasks(state.tasks, state.edit, event.newInput));
    });
  }

  Future<TasksState> onLoadTasks(TasksState state) async {
    return TasksState._fromTasks(await _getTasks(), state.edit, state.input);
  }

  Future<TasksState> onAddTask(TasksState state) async {
    var result = await _addTask.call(state.input);
    if (result != null) {
      return TasksState._fromTasks(state.tasks..insert(0, Task(name: result.name, id: result.id)), null, "");
    } else {
      return TasksState._fromTasks(state.tasks, null, "");
    }
  }

  TasksState onDeleteTask(TasksState state, Task taskToDelete) {
    _deleteTask(taskToDelete.id);
    return TasksState._fromTasks(state.tasks, null, state.input);
  }

  Future<TasksState> onSaveTask(TasksState state, Task taskToEdit) async {
    var result = await _updateTask(taskToEdit.id, state.input);
    if (result) {
      state.tasks.firstWhere((element) => element == state.edit).name = state.input;
    }
    return TasksState._fromTasks(state.tasks, null, "");
  }
}
