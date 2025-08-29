import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/models/provider_models/todo_model.dart';


class TodoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TodoProvider(),
      child: const _TodoScreenContent(),
    );
  }
}

class _TodoScreenContent extends StatefulWidget {
  const _TodoScreenContent({super.key});

  @override
  _TodoScreenContentState createState() => _TodoScreenContentState();
}

class _TodoScreenContentState extends State<_TodoScreenContent> {
  void _showAddTaskDialog(BuildContext context) {
    final provider = Provider.of<TodoProvider>(context, listen: false);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Task'),
          content: TextField(
            controller: provider.taskController,
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
                provider.addTask(provider.taskController.text);
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
  Widget build(BuildContext context) {
    final provider = Provider.of<TodoProvider>(context);
    const appBarColor = Color(0xFF18442A);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager', style: TextStyle(color: Color(0xFFF3EDE3))),
        backgroundColor: appBarColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Color(0xFFF3EDE3)),
            onPressed: () => _showAddTaskDialog(context),
          ),
        ],
      ),
      backgroundColor: const Color(0xFF45644A),
      body: provider.tasks.isEmpty
          ? const Center(
        child: Text(
          'No tasks yet!',
          style: TextStyle(color: Color(0xFFF3EDE3), fontSize: 18),
        ),
      )
          : ListView.builder(
        itemCount: provider.tasks.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Checkbox(
              value: provider.tasks[index].isCompleted,
              onChanged: (_) => provider.toggleTask(index),
              activeColor: appBarColor,
            ),
            title: Text(
              provider.tasks[index].title,
              style: TextStyle(
                color: const Color(0xFFF3EDE3),
                decoration: provider.tasks[index].isCompleted
                    ? TextDecoration.lineThrough
                    : null,
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Color(0xFFF3EDE3)),
              onPressed: () => provider.deleteTask(index),
            ),
          );
        },
      ),
    );
  }
}