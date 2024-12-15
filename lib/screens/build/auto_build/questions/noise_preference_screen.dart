import 'package:flutter/material.dart';

class NoisePreferenceScreen extends StatefulWidget {
  final Function(Map<String, dynamic>) onNext;

  const NoisePreferenceScreen({super.key, required this.onNext});

  @override
  State<NoisePreferenceScreen> createState() => _NoisePreferenceScreenState();
}

class _NoisePreferenceScreenState extends State<NoisePreferenceScreen> {
  double maxNoiseLevel = 30; // dB
  bool prioritizeNoise = false;
  String coolingPreference = 'balanced';
  bool requiresNightMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Noise Preferences')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Maximum Noise Level: ${maxNoiseLevel.toInt()} dB'),
          Slider(
            value: maxNoiseLevel,
            min: 20,
            max: 50,
            divisions: 30,
            onChanged: (value) => setState(() => maxNoiseLevel = value),
          ),
          const SizedBox(height: 16),
          SwitchListTile(
            title: const Text('Prioritize Low Noise over Performance'),
            value: prioritizeNoise,
            onChanged: (value) => setState(() => prioritizeNoise = value),
          ),
          const SizedBox(height: 16),
          const Text('Cooling Preference:'),
          RadioListTile(
            title: const Text('Maximum Performance'),
            subtitle: const Text('Louder but better cooling'),
            value: 'performance',
            groupValue: coolingPreference,
            onChanged: (value) => setState(() => coolingPreference = value!),
          ),
          RadioListTile(
            title: const Text('Balanced'),
            subtitle: const Text('Moderate noise and cooling'),
            value: 'balanced',
            groupValue: coolingPreference,
            onChanged: (value) => setState(() => coolingPreference = value!),
          ),
          RadioListTile(
            title: const Text('Silent'),
            subtitle: const Text('Minimal noise, reduced performance'),
            value: 'silent',
            groupValue: coolingPreference,
            onChanged: (value) => setState(() => coolingPreference = value!),
          ),
          const SizedBox(height: 16),
          SwitchListTile(
            title: const Text('Night Mode Required'),
            subtitle: const Text('Extra quiet operation during specified hours'),
            value: requiresNightMode,
            onChanged: (value) => setState(() => requiresNightMode = value),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => widget.onNext({
              'maxNoiseLevel': maxNoiseLevel,
              'prioritizeNoise': prioritizeNoise,
              'coolingPreference': coolingPreference,
              'requiresNightMode': requiresNightMode,
            }),
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }
} 