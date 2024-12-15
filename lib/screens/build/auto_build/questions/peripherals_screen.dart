import 'package:flutter/material.dart';

class PeripheralsScreen extends StatefulWidget {
  final Function(Map<String, dynamic>) onNext;

  const PeripheralsScreen({super.key, required this.onNext});

  @override
  State<PeripheralsScreen> createState() => _PeripheralsScreenState();
}

class _PeripheralsScreenState extends State<PeripheralsScreen> {
  final Set<String> selectedPeripherals = {};
  final Map<String, bool> needsWireless = {};
  
  final peripherals = [
    'Monitor',
    'Keyboard',
    'Mouse',
    'Headset',
    'Speakers',
    'Webcam',
    'Microphone',
    'Controller',
    'Drawing Tablet',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Required Peripherals')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ...peripherals.map((peripheral) {
            final isSelected = selectedPeripherals.contains(peripheral);
            return Column(
              children: [
                CheckboxListTile(
                  title: Text(peripheral),
                  value: isSelected,
                  onChanged: (value) {
                    setState(() {
                      if (value!) {
                        selectedPeripherals.add(peripheral);
                      } else {
                        selectedPeripherals.remove(peripheral);
                        needsWireless.remove(peripheral);
                      }
                    });
                  },
                ),
                if (isSelected)
                  Padding(
                    padding: const EdgeInsets.only(left: 32),
                    child: SwitchListTile(
                      title: const Text('Wireless Required'),
                      value: needsWireless[peripheral] ?? false,
                      onChanged: (value) {
                        setState(() {
                          needsWireless[peripheral] = value;
                        });
                      },
                    ),
                  ),
              ],
            );
          }),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => widget.onNext({
              'selectedPeripherals': selectedPeripherals.toList(),
              'wirelessPreferences': needsWireless,
            }),
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }
} 