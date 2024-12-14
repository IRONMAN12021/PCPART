import 'package:flutter/material.dart';

class AutoBuildScreen extends StatelessWidget {
  const AutoBuildScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Auto Build'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/budget'),
            child: const Text('Start Auto Build'),
          ),
        ],
      ),
    );
  }
}

