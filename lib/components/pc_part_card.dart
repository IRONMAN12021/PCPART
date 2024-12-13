import 'package:flutter/material.dart';

class PCPartCard extends StatelessWidget {
  final String name;
  final String category;
  final double price;
  final String benchmarks;
  final VoidCallback onTap;

  const PCPartCard({
    super.key,
    required this.name,
    required this.category,
    required this.price,
    required this.benchmarks,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: ListTile(
        onTap: onTap,
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(
            '$category - \$${price.toStringAsFixed(2)}\nBenchmarks: $benchmarks'),
        isThreeLine: true,
        trailing: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
