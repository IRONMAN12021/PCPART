import 'package:flutter/material.dart';
//import 'package:myapp/models/build_config.dart';

class AutoBuildSummaryScreen extends StatelessWidget {
  final Map<String, dynamic> answers;

  const AutoBuildSummaryScreen({
    super.key,
    required this.answers,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Build Configuration'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ...answers.entries.map((entry) => Card(
            child: ListTile(
              title: Text(entry.key),
              subtitle: Text(entry.value.toString()),
            ),
          )),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/parts_list');
            },
            child: const Text('Generate Build'),
          ),
        ],
      ),
    );
  }
}