import 'package:flutter/material.dart';

class PartCard extends StatelessWidget {
  final String name;
  final double price;
  final String type;
  final VoidCallback onTap;

  const PartCard({
    super.key,
    required this.name,
    required this.price,
    required this.type,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(name),
        subtitle: Text('$type - \$${price.toStringAsFixed(2)}'),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
} 