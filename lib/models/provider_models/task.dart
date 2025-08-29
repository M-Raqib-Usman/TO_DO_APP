
class Task {
  String title;
  bool isCompleted;

  Task({required this.title, this.isCompleted = false});

  // Convert Task to JSON
  Map<String, dynamic> toJson() => {'title': title, 'isCompleted': isCompleted};

  // Create Task from JSON
  factory Task.fromJson(Map<String, dynamic> json) =>
      Task(title: json['title'], isCompleted: json['isCompleted']);
}