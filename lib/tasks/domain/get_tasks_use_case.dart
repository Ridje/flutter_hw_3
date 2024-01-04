import 'package:flutter_hw_3/tasks/data/repository/tasks_repository.dart';
import 'package:flutter_hw_3/tasks/presentation/tasks/state/task.dart';
import 'package:injectable/injectable.dart';

@Singleton()
class GetTasksUseCase {

  final TasksRepository _repository;

  GetTasksUseCase({required TasksRepository repository}) : _repository = repository;

  Future<List<Task>> call() async {
    return _repository.getTasks();
  }
}