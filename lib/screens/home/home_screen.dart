import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to Auto Build
              },
              child: Text('Auto Build'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to Manual Build
              },
              child: Text('Manual Build'),
            ),
          ],
        ),
      ),
    );
  }
}
