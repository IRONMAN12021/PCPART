import 'package:flutter/material.dart';

class BudgetScreen extends StatelessWidget {
  final Function(String) onNext;

  const BudgetScreen({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    final budgetController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text('PC Part Configurator')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'What is your budget?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: budgetController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter your budget (e.g., \$1000)',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                onNext(budgetController.text);
              },
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
