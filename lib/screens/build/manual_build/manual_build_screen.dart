import 'package:flutter/material.dart';
import 'package:myapp/models/build_config.dart';

class ManualBuildScreen extends StatelessWidget {
  const ManualBuildScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manual Build'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ElevatedButton(
            onPressed: () {
              // TODO: Implement part selection
              final buildConfig = BuildConfig(
                id: 'temp_id',
                userId: 'temp_user',
                parts: [],
                totalPrice: 0.0,
              );
              Navigator.pushNamed(
                context,
                '/summary',
                arguments: buildConfig,
              );
            },
            child: const Text('Select Parts'),
          ),
        ],
      ),
    );
  }
}
