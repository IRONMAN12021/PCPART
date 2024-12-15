import 'package:flutter/material.dart';

class SpaceConstraintScreen extends StatefulWidget {
  final Function(Map<String, dynamic>) onNext;

  const SpaceConstraintScreen({super.key, required this.onNext});

  @override
  State<SpaceConstraintScreen> createState() => _SpaceConstraintScreenState();
}

class _SpaceConstraintScreenState extends State<SpaceConstraintScreen> {
  double maxHeight = 500; // mm
  double maxWidth = 500;  // mm
  String selectedFormFactor = 'ATX';
  bool isDesktop = true;

  final formFactors = ['ATX', 'Micro-ATX', 'Mini-ITX', 'E-ATX'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Space Constraints')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Where will you place your PC?'),
          Row(
            children: [
              Expanded(
                child: RadioListTile(
                  title: const Text('Desktop'),
                  value: true,
                  groupValue: isDesktop,
                  onChanged: (value) => setState(() => isDesktop = value!),
                ),
              ),
              Expanded(
                child: RadioListTile(
                  title: const Text('Floor'),
                  value: false,
                  groupValue: isDesktop,
                  onChanged: (value) => setState(() => isDesktop = value!),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text('Maximum Height: ${maxHeight.toInt()}mm'),
          Slider(
            value: maxHeight,
            min: 200,
            max: 800,
            divisions: 60,
            onChanged: (value) => setState(() => maxHeight = value),
          ),
          Text('Maximum Width: ${maxWidth.toInt()}mm'),
          Slider(
            value: maxWidth,
            min: 200,
            max: 800,
            divisions: 60,
            onChanged: (value) => setState(() => maxWidth = value),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: selectedFormFactor,
            decoration: const InputDecoration(
              labelText: 'Preferred Form Factor',
            ),
            items: formFactors.map((factor) {
              return DropdownMenuItem(
                value: factor,
                child: Text(factor),
              );
            }).toList(),
            onChanged: (value) => setState(() => selectedFormFactor = value!),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => widget.onNext({
              'isDesktop': isDesktop,
              'maxHeight': maxHeight,
              'maxWidth': maxWidth,
              'formFactor': selectedFormFactor,
            }),
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }
} 