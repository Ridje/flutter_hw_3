import 'package:flutter_hw_3/tasks/data/repository/tasks_repository.dart';
import 'package:injectable/injectable.dart';

@Singleton()
class DeleteTaskUseCase {
 final TasksRepository _repository;

  DeleteTaskUseCase({required TasksRepository repository}) : _repository = repository;

  Future<bool> call(int taskId) async {
    return _repository.deleteTask(taskId);
  }
}