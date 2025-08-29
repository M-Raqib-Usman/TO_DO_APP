import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/todo.dart';
import '../services/api_service.dart';
import 'user_profile_screen.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final _taskController = TextEditingController();
  late Future<List<Todo>> futureTodos;

  @override
  void initState() {
    super.initState();
    futureTodos = ApiService().fetchTodos();
    _taskController.addListener(() {
      setState(() {});
    });
  }

  // Add a new task (using API or local storage)
  Future<void> _addTask(String title) async {
    if (title.isNotEmpty) {
      try {
        // Use API to add task (userId: 1 for testing)
        final newTodo = await ApiService().addTodo(title, 1);
        setState(() {
          futureTodos = ApiService().fetchTodos(); // Refresh tasks
          _taskController.clear();
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add task: $e')),
        );
      }
    }
  }

  // Show dialog to add a task
  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Task'),
          content: TextField(
            controller: _taskController,
            decoration: const InputDecoration(
              labelText: 'Task',
              border: OutlineInputBorder(),
              labelStyle: TextStyle(color: Color(0xFF18442A)),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(color: Color(0xFF18442A))),
            ),
            TextButton(
              onPressed: () {
                _addTask(_taskController.text);
                Navigator.pop(context);
              },
              child: const Text('Add', style: TextStyle(color: Color(0xFF18442A))),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const appBarColor = Color(0xFF18442A);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager', style: TextStyle(color: Color(0xFFF3EDE3))),
        backgroundColor: appBarColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Color(0xFFF3EDE3)),
            onPressed: _showAddTaskDialog,
          ),
        ],
      ),
      backgroundColor: const Color(0xFF45644A),
      body: FutureBuilder<List<Todo>>(
        future: futureTodos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFFF3EDE3)));
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error: ${snapshot.error}',
                    style: const TextStyle(color: Color(0xFFF3EDE3), fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: appBarColor,
                      foregroundColor: const Color(0xFFF3EDE3),
                    ),
                    onPressed: () {
                      setState(() {
                        futureTodos = ApiService().fetchTodos(); // Retry
                      });
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'No tasks yet!',
                style: TextStyle(color: Color(0xFFF3EDE3), fontSize: 18),
              ),
            );
          }

          final todos = snapshot.data!;
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              return ListTile(
                leading: Checkbox(
                  value: todo.isCompleted,
                  onChanged: null, // Read-only for demo (JSONPlaceholder doesn't support PATCH here)
                  activeColor: appBarColor,
                ),
                title: Text(
                  todo.title,
                  style: TextStyle(
                    color: const Color(0xFFF3EDE3),
                    decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserProfileScreen(userId: todo.userId),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}