import 'package:flutter_hw_3/tasks/data/dto/todos_response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:injectable/injectable.dart';

@Singleton()
class TodosRemoteSource {
  final Uri _uriGet;
  final Uri _uriAdd;
  static const _userId = 1;

  TodosRemoteSource()
      : _uriGet = Uri.parse("https://jsonplaceholder.typicode.com/todos?userId=$_userId"),
        _uriAdd = Uri.parse("https://jsonplaceholder.typicode.com/todos");

  Future<List<TodoDto>> fetchTaskList() async {
    final response = await http.get(_uriGet);

    if (response.statusCode == 200) {
      return List<TodoDto>.from(jsonDecode(response.body).map((e) => TodoDto.fromJson(e)));
    } else {
      throw Exception('Failed to load tasks with the reason ${response.reasonPhrase}');
    }
  }

  Future<int> addTask(String title) async {
    final Map<String, dynamic> data = {
      'title': title,
      'completed': false,
      'userId': 1,
    };

    final response = await http.post(_uriAdd, body: jsonEncode(data));

    if (response.statusCode >= 200 && response.statusCode <= 202) {
      return jsonDecode(response.body)['id'];
    } else {
      throw Exception('Failed to add task with the reason ${response.reasonPhrase}');
    }
  }

  Future<bool> deleteTask(int taskId) async {
    final response = await http.delete(Uri.parse("https://jsonplaceholder.typicode.com/todos/$taskId"));
    return response.statusCode == 200;
  }

  Future<bool> updateTask(int id, String title) async {
    final Map<String, dynamic> data = {
      'title': title,
    };

    final response = await http.patch(Uri.parse("https://jsonplaceholder.typicode.com/todos/$id"), body: data);

    return response.statusCode >= 200 && response.statusCode <= 202;
  }
}
