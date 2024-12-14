import 'package:flutter/material.dart';

class PartDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> part;

  const PartDetailsScreen({super.key, required this.part});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Part Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${part['name']}'),
            Text('Price: \$${part['price']}'),
            // Add more part details here
          ],
        ),
      ),
    );
  }
}
