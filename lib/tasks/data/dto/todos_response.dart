class TodoDto {
  final int userId;
  final int id;
  final String title;
  final bool completed;

  TodoDto({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,
  });

  factory TodoDto.fromJson(Map<String, dynamic> json) {
    return TodoDto(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      completed: json['completed'],
    );
  }
}