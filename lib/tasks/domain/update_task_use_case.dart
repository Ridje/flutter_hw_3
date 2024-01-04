import 'package:flutter_hw_3/tasks/data/repository/tasks_repository.dart';
import 'package:injectable/injectable.dart';

@Singleton()
class UpdateTaskUseCase {

  final TasksRepository _repository;

  UpdateTaskUseCase({required TasksRepository repository}) : _repository = repository;

  Future<bool> call(int id, String title) async {
    return _repository.updateTask(id, title);
  }
}