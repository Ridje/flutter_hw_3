import 'package:flutter_hw_3/tasks/data/todos_remote_source.dart';
import 'package:flutter_hw_3/tasks/presentation/tasks/state/task.dart';
import 'package:injectable/injectable.dart';

@Singleton()
class TasksRepository {
  final TodosRemoteSource _remoteSource;

  TasksRepository(this._remoteSource);

  Future<List<Task>> getTasks() async {
    try {
      final remoteTasks = await _remoteSource.fetchTaskList();
      return remoteTasks.map((item) => Task.fromTodoDto(item)).toList();
    } catch (e) {
      return List.empty();
    }
  }

  Future<Task?> addTask(String title) async {
    try {
      final addedTaskId = await _remoteSource.addTask(title);
      return Task(id: addedTaskId, name: title);  
    } catch (e) {
      return null;
    }
  }

  Future<bool> deleteTask(int taskId) async {
    try {
      return await _remoteSource.deleteTask(taskId);
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateTask(int id, String title) async {
    try {
      return await _remoteSource.updateTask(id, title);
    } catch (e) {
      return false;
    }
  }
}
