import 'package:flutter/material.dart';

class UseCaseScreen extends StatelessWidget {
  final Function(String) onNext;

  UseCaseScreen({required this.onNext});

  @override
  Widget build(BuildContext context) {
    final useCases = ['Gaming', 'Productivity', 'General Use', 'Special Use'];

    return Scaffold(
      appBar: AppBar(title: Text('Select Use Case')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'What will you use the PC for?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: useCases.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(useCases[index]),
                    onTap: () {
                      onNext(useCases[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
