class Todo {
  final int id;
  final int userId;
  final String title;
  final bool isCompleted;

  Todo({
    required this.id,
    required this.userId,
    required this.title,
    required this.isCompleted,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      isCompleted: json['completed'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'title': title,
    'completed': isCompleted,
  };
}