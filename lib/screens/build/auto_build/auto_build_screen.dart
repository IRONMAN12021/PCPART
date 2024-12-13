import 'package:flutter/material.dart';

class AutoBuildScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Auto Build')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Start questionnaire logic
          },
          child: Text('Start Auto Build'),
        ),
      ),
    );
  }
}

