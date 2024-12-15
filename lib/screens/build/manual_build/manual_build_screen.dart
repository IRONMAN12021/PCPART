import 'package:flutter/material.dart';
import 'package:myapp/models/build_config.dart';
import 'package:myapp/models/pc_part.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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
            onPressed: () async {
              final navigator = Navigator.of(context);
              final scaffoldMessenger = ScaffoldMessenger.of(context);
              
              // Get current user ID from Supabase
              final userId = Supabase.instance.client.auth.currentUser?.id;
              if (userId == null) {
                scaffoldMessenger.showSnackBar(
                  const SnackBar(content: Text('Please login first')),
                );
                return;
              }

              // Navigate to parts selection screen and wait for result
              final selectedParts = await navigator.pushNamed(
                '/parts',
              ) as List<Map<String, dynamic>>?;
              
              if (selectedParts == null || selectedParts.isEmpty) {
                return;
              }

              // Calculate total price
              final totalPrice = selectedParts.fold<double>(
                0,
                (sum, part) => sum + (part['price'] as double),
              );

              // Convert Map to PCPart objects
              final parts = selectedParts.map((part) => PCPart(
                id: part['id'] as String,
                name: part['name'] as String,
                price: part['price'] as double,
                type: part['type'] as String,
                specifications: part['specifications'] as Map<String, dynamic>,
              )).toList();

              // Create build config with converted parts
              final buildConfig = BuildConfig(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                userId: userId,
                parts: parts,  // Use converted parts list
                totalPrice: totalPrice,
              );

              // Navigate to summary screen
              navigator.pushNamed(
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
