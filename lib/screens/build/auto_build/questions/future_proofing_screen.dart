import 'package:flutter/material.dart';

class FutureProofingScreen extends StatefulWidget {
  final Function(Map<String, dynamic>) onNext;

  const FutureProofingScreen({super.key, required this.onNext});

  @override
  State<FutureProofingScreen> createState() => _FutureProofingScreenState();
}

class _FutureProofingScreenState extends State<FutureProofingScreen> {
  // Upgrade plans
  int plannedLifespan = 3; // years
  bool planToUpgrade = false;
  List<String> plannedUpgrades = [];
  String upgradeFrequency = 'yearly';

  // Technology preferences
  Map<String, String> techChoices = {
    'RAM': 'DDR4',
    'Storage': 'PCIe 4.0',
    'USB': 'USB 3.2',
    'PCIe': 'PCIe 4.0',
  };

  // Expansion needs
  int extraRamSlots = 2;
  int extraStorageSlots = 2;
  int extraPCIeSlots = 1;
  bool needsThunderbolt = false;

  final List<String> upgradableComponents = [
    'RAM',
    'Storage',
    'GPU',
    'CPU',
    'Cooling',
    'Power Supply',
    'Case',
    'Motherboard',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Future Proofing'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => _showFutureProofingInfo(context),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildLifespanSection(),
          const Divider(),
          _buildTechnologySection(),
          const Divider(),
          _buildExpansionSection(),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => widget.onNext(_gatherFutureProofingData()),
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }

  Widget _buildLifespanSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Lifespan & Upgrades',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text('Planned Lifespan: $plannedLifespan years'),
        Slider(
          value: plannedLifespan.toDouble(),
          min: 1,
          max: 7,
          divisions: 6,
          label: '$plannedLifespan years',
          onChanged: (value) => setState(() => plannedLifespan = value.toInt()),
        ),
        SwitchListTile(
          title: const Text('Plan to Upgrade'),
          subtitle: const Text('Components will be upgraded over time'),
          value: planToUpgrade,
          onChanged: (value) => setState(() => planToUpgrade = value),
        ),
        if (planToUpgrade) ...[
          const Text('Planned Upgrades:'),
          ...upgradableComponents.map((component) => CheckboxListTile(
            title: Text(component),
            value: plannedUpgrades.contains(component),
            onChanged: (value) {
              setState(() {
                if (value!) {
                  plannedUpgrades.add(component);
                } else {
                  plannedUpgrades.remove(component);
                }
              });
            },
          )),
          DropdownButtonFormField<String>(
            value: upgradeFrequency,
            decoration: const InputDecoration(
              labelText: 'Upgrade Frequency',
            ),
            items: [
              'monthly',
              'quarterly',
              'yearly',
              'every 2 years',
            ].map((freq) {
              return DropdownMenuItem(
                value: freq,
                child: Text(freq.toUpperCase()),
              );
            }).toList(),
            onChanged: (value) => setState(() => upgradeFrequency = value!),
          ),
        ],
      ],
    );
  }

  Widget _buildTechnologySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Technology Preferences',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ...techChoices.entries.map((entry) => DropdownButtonFormField<String>(
          value: entry.value,
          decoration: InputDecoration(
            labelText: '${entry.key} Technology',
          ),
          items: _getTechOptions(entry.key).map((tech) {
            return DropdownMenuItem(
              value: tech,
              child: Text(tech),
            );
          }).toList(),
          onChanged: (value) => setState(() => techChoices[entry.key] = value!),
        )),
      ],
    );
  }

  Widget _buildExpansionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Expansion Requirements',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text('Extra RAM Slots: $extraRamSlots'),
        Slider(
          value: extraRamSlots.toDouble(),
          min: 0,
          max: 4,
          divisions: 4,
          label: '$extraRamSlots slots',
          onChanged: (value) => setState(() => extraRamSlots = value.toInt()),
        ),
        Text('Extra Storage Slots: $extraStorageSlots'),
        Slider(
          value: extraStorageSlots.toDouble(),
          min: 0,
          max: 6,
          divisions: 6,
          label: '$extraStorageSlots slots',
          onChanged: (value) => setState(() => extraStorageSlots = value.toInt()),
        ),
        Text('Extra PCIe Slots: $extraPCIeSlots'),
        Slider(
          value: extraPCIeSlots.toDouble(),
          min: 0,
          max: 3,
          divisions: 3,
          label: '$extraPCIeSlots slots',
          onChanged: (value) => setState(() => extraPCIeSlots = value.toInt()),
        ),
        SwitchListTile(
          title: const Text('Thunderbolt Support'),
          subtitle: const Text('For future high-speed peripherals'),
          value: needsThunderbolt,
          onChanged: (value) => setState(() => needsThunderbolt = value),
        ),
      ],
    );
  }

  List<String> _getTechOptions(String tech) {
    switch (tech) {
      case 'RAM':
        return ['DDR4', 'DDR5'];
      case 'Storage':
        return ['PCIe 3.0', 'PCIe 4.0', 'PCIe 5.0'];
      case 'USB':
        return ['USB 3.1', 'USB 3.2', 'USB 4.0'];
      case 'PCIe':
        return ['PCIe 3.0', 'PCIe 4.0', 'PCIe 5.0'];
      default:
        return [];
    }
  }

  void _showFutureProofingInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Future Proofing Considerations'),
        content: const SingleChildScrollView(
          child: Text(
            'Future proofing affects long-term value:\n\n'
            '• Newer technologies may cost more\n'
            '• Extra slots enable future expansion\n'
            '• Upgrade plans affect initial choices\n'
            '• Latest standards ensure compatibility\n'
            '• Higher capacity PSU supports upgrades',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Got it'),
          ),
        ],
      ),
    );
  }

  Map<String, dynamic> _gatherFutureProofingData() {
    return {
      'lifespan': {
        'plannedYears': plannedLifespan,
        'planToUpgrade': planToUpgrade,
        'plannedUpgrades': plannedUpgrades,
        'upgradeFrequency': upgradeFrequency,
      },
      'technology': techChoices,
      'expansion': {
        'extraRamSlots': extraRamSlots,
        'extraStorageSlots': extraStorageSlots,
        'extraPCIeSlots': extraPCIeSlots,
        'needsThunderbolt': needsThunderbolt,
      },
    };
  }
}