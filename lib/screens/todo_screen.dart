
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Task {
String title;
bool isCompleted;

Task({required this.title, this.isCompleted = false});

// Convert Task to JSON
Map<String, dynamic> toJson() => {
'title': title,
'isCompleted': isCompleted,
};

// Create Task from JSON
factory Task.fromJson(Map<String, dynamic> json) => Task(
title: json['title'],
isCompleted: json['isCompleted'],
);
}

class TodoScreen extends StatefulWidget {
@override
_TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
final _taskController = TextEditingController();
List<Task> _tasks = [];

@override
void initState() {
super.initState();
_loadTasks();
// Listen for text changes to update border color
_taskController.addListener(() {
setState(() {}); // Rebuild UI when text changes
});
}

// Load tasks from SharedPreferences
Future<void> _loadTasks() async {
final prefs = await SharedPreferences.getInstance();
final taskList = prefs.getStringList('tasks') ?? [];
setState(() {
_tasks = taskList
    .map((taskJson) => Task.fromJson(jsonDecode(taskJson)))
    .toList();
});
}

// Save tasks to SharedPreferences
Future<void> _saveTasks() async {
final prefs = await SharedPreferences.getInstance();
final taskList = _tasks.map((task) => jsonEncode(task.toJson())).toList();
await prefs.setStringList('tasks', taskList);
}

// Add a new task
void _addTask(String title) {
if (title.isNotEmpty) {
setState(() {
_tasks.add(Task(title: title));
_taskController.clear();
});
_saveTasks();
}
}

// Toggle task completion
void _toggleTask(int index) {
setState(() {
_tasks[index].isCompleted = !_tasks[index].isCompleted;
});
_saveTasks();
}

// Delete a task
void _deleteTask(int index) {
setState(() {
_tasks.removeAt(index);
});
_saveTasks();
}

@override
void dispose() {
_taskController.dispose();
super.dispose();
}

// Show dialog to add a task
void _showAddTaskDialog() {
showDialog(
context: context,
builder: (context) {
return AlertDialog(
title: Text('Add Task'),
content: TextField(
controller: _taskController,
decoration: InputDecoration(
labelText: 'Task',
border: OutlineInputBorder(),
labelStyle: TextStyle(color: Color(0xFF18442A)),
),
),
actions: [
TextButton(
onPressed: () => Navigator.pop(context),
child: Text('Cancel', style: TextStyle(color: Color(0xFF18442A))),
),
TextButton(
onPressed: () {
_addTask(_taskController.text);
Navigator.pop(context);
},
child: Text('Add', style: TextStyle(color: Color(0xFF18442A))),
),
],
);
},
);
}

@override
Widget build(BuildContext context) {
const appBarColor = Color(0xFF18442A);

return Scaffold(
appBar: AppBar(
title: Text('Task Manager', style: TextStyle(color: Color(0xFFF3EDE3))),
backgroundColor: appBarColor,
actions: [
IconButton(
icon: Icon(Icons.add, color: Color(0xFFF3EDE3)),
onPressed: _showAddTaskDialog,
),
],
),
backgroundColor: Color(0xFF45644A),
body: _tasks.isEmpty
? Center(
child: Text(
'No tasks yet!',
style: TextStyle(color: Color(0xFFF3EDE3), fontSize: 18),
),
)
    : ListView.builder(
itemCount: _tasks.length,
itemBuilder: (context, index) {
return ListTile(
leading: Checkbox(
value: _tasks[index].isCompleted,
onChanged: (value) => _toggleTask(index),
activeColor: appBarColor,
),
title: Text(
_tasks[index].title,
style: TextStyle(
color: Color(0xFFF3EDE3),
decoration: _tasks[index].isCompleted
? TextDecoration.lineThrough
    : null,
),
),
trailing: IconButton(
icon: Icon(Icons.delete, color: Color(0xFFF3EDE3)),
onPressed: () => _deleteTask(index),
),
);
},
),
);
}
}
