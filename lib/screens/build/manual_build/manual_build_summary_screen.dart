import 'package:flutter/material.dart';
import 'package:myapp/models/build_config.dart';

class ManualBuildSummaryScreen extends StatelessWidget {
  final BuildConfig buildConfig;

  const ManualBuildSummaryScreen({
    super.key,
    required this.buildConfig,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Build Summary'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Text('Build Configuration', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 16),
          ...buildConfig.parts.map((part) => Card(
            child: ListTile(
              title: Text(part.name),
              subtitle: Text(part.type),
              trailing: Text('\$${part.price.toStringAsFixed(2)}'),
            ),
          )),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total Price:'),
                  Text(
                    '\$${buildConfig.totalPrice.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
