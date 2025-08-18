import 'package:flutter/material.dart';
import 'package:to_do/screens/counter_screen.dart';
import 'package:to_do/screens/todo_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home', style: TextStyle(color: Color(0xFFF3EDE3))),
        backgroundColor: Color(0xFF18442A),
      ),
      backgroundColor: Color(0xFF45644A),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF18442A),
                foregroundColor: Color(0xFFF3EDE3),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CounterScreen()),
                );
              },
              child: Text('Go to Counter'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF18442A),
                foregroundColor: Color(0xFFF3EDE3),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TodoScreen()),
                );
              },
              child: Text('To-Do List'),
            ),
          ],
        ),
      ),
    );
  }
}
