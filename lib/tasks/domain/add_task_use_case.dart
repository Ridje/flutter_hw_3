import 'package:flutter_hw_3/tasks/data/repository/tasks_repository.dart';
import 'package:flutter_hw_3/tasks/presentation/tasks/state/task.dart';
import 'package:injectable/injectable.dart';

@Singleton()
class AddTaskUseCase {

  final TasksRepository _repository;

  AddTaskUseCase({required TasksRepository repository}) : _repository = repository;

  Future<Task?> call(String title) async {
    return _repository.addTask(title);
  }
}