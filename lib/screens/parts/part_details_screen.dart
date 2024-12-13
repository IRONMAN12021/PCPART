import 'package:flutter/material.dart';

class PartDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> part;

  PartDetailsScreen({required this.part});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Part Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text('Name: ${part['name']}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Type: ${part['type']}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Release Year: ${part['releaseYear']}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Generation: ${part['generation']}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Specifications:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            ...part['specifications'].entries.map((entry) => Text('${entry.key}: ${entry.value}', style: TextStyle(fontSize: 16))),
          ],
        ),
      ),
    );
  }
}
