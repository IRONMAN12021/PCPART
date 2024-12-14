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
          Text('Total Price: \$${buildConfig.totalPrice}'),
          const SizedBox(height: 20),
          const Text('Selected Parts:'),
          ...buildConfig.parts.map(
            (part) => ListTile(
              title: Text(part.name),
              subtitle: Text('\$${part.price}'),
            ),
          ),
        ],
      ),
    );
  }
}
