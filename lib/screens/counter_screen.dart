import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/models/provider_models/counter_model.dart';


class CounterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CounterProvider(),
      child: const _CounterScreenContent(),
    );
  }
}

class _CounterScreenContent extends StatelessWidget {
  const _CounterScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CounterProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter', style: TextStyle(color: Color(0xFFF3EDE3))),
        backgroundColor: const Color(0xFF18442A),
      ),
      backgroundColor: const Color(0xFF45644A),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Counter Value: ${provider.counter}',
              style: const TextStyle(fontSize: 24, color: Color(0xFFF3EDE3)),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF18442A),
                    foregroundColor: const Color(0xFFF3EDE3),
                  ),
                  onPressed: provider.increaseCounter,
                  child: const Text('Increase'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF18442A),
                    foregroundColor: const Color(0xFFF3EDE3),
                  ),
                  onPressed: provider.decreaseCounter,
                  child: const Text('Decrease'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}