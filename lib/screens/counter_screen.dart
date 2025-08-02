import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CounterScreen extends StatefulWidget {
  @override
  _CounterScreenState createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  Future<void> _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = prefs.getInt('counter') ?? 0;
    });
  }

  Future<void> _saveCounter() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('counter', _counter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter', style: TextStyle(color: Color(0xFFF3EDE3))),
        backgroundColor: Color(0xFF18442A),
      ),
      backgroundColor: Color(0xFF45644A),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Counter Value: $_counter',
              style: TextStyle(fontSize: 24, color: Color(0xFFF3EDE3)),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF18442A),
                    foregroundColor: Color(0xFFF3EDE3),
                  ),
                  onPressed: () {
                    setState(() {
                      _counter++;
                    });
                    _saveCounter();
                  },
                  child: Text('Increase'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF18442A),
                    foregroundColor: Color(0xFFF3EDE3),
                  ),
                  onPressed: () {
                    setState(() {
                      _counter--;
                    });
                    _saveCounter();
                  },
                  child: Text('Decrease'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
