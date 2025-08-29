import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'task.dart';

class TodoProvider with ChangeNotifier {
  List<Task> _tasks = [];
  final TextEditingController _taskController = TextEditingController();

  List<Task> get tasks => _tasks;
  TextEditingController get taskController => _taskController;

  TodoProvider() {
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final taskList = prefs.getStringList('tasks') ?? [];
    _tasks = taskList.map((taskJson) => Task.fromJson(jsonDecode(taskJson))).toList();
    notifyListeners();
  }

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final taskList = _tasks.map((task) => jsonEncode(task.toJson())).toList();
    await prefs.setStringList('tasks', taskList);
    notifyListeners();
  }

  void addTask(String title) {
    if (title.isNotEmpty) {
      _tasks.add(Task(title: title));
      _taskController.clear();
      _saveTasks();
    }
  }

  void toggleTask(int index) {
    _tasks[index].isCompleted = !_tasks[index].isCompleted;
    _saveTasks();
  }

  void deleteTask(int index) {
    _tasks.removeAt(index);
    _saveTasks();
  }

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }
}