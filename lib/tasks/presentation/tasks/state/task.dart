import 'package:flutter_hw_3/tasks/data/dto/todos_response.dart';

class Task {
  String name;
  int id;

  Task({required this.name, required this.id}); 

  factory Task.fromTodoDto(TodoDto todo) {
    return Task(name: todo.title, id: todo.id);
  }
}