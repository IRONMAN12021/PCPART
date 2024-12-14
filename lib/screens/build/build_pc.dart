import 'package:flutter/material.dart';

class BuildPcScreen extends StatelessWidget {
  const BuildPcScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Build Your PC'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/auto_build'),
              child: const Text('Auto Build'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/manual_build'),
              child: const Text('Manual Build'),
            ),
          ],
        ),
      ),
    );
  }
}
