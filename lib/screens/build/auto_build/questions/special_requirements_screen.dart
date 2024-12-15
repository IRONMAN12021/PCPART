import 'package:flutter/material.dart';

class SpecialRequirementsScreen extends StatefulWidget {
  final Function(Map<String, dynamic>) onNext;

  const SpecialRequirementsScreen({super.key, required this.onNext});

  @override
  State<SpecialRequirementsScreen> createState() => _SpecialRequirementsScreenState();
}

class _SpecialRequirementsScreenState extends State<SpecialRequirementsScreen> {
  // Aesthetics
  bool wantsRGB = false;
  String caseColor = 'black';
  bool needsWindowPanel = false;
  String rgbStyle = 'none';
  Map<String, bool> rgbComponents = {
    'Fans': false,
    'RAM': false,
    'Motherboard': false,
    'GPU': false,
    'CPU Cooler': false,
    'Case': false,
  };

  // Port requirements
  Map<String, int> requiredPorts = {
    'USB 3.0': 2,
    'USB 2.0': 2,
    'USB-C': 1,
    'HDMI': 1,
    'DisplayPort': 1,
    'Audio Jack': 1,
  };

  // Software compatibility
  List<String> selectedSoftware = [];
  bool needsVirtualization = false;
  bool needsHackintosh = false;
  String preferredOS = 'Windows';

  // Special features
  bool needsWiFi = true;
  bool needsBluetooth = true;
  bool needsCardReader = false;
  bool needsFrontIO = true;

  final List<String> availableSoftware = [
    'Adobe Creative Suite',
    'AutoCAD',
    'Visual Studio',
    'Unity',
    'Unreal Engine',
    'Blender',
    'Maya',
    'Docker',
    'VMware',
    'Android Studio',
  ];

  final List<String> caseColors = [
    'black',
    'white',
    'gray',
    'red',
    'blue',
    'green',
    'custom',
  ];

  final List<String> rgbStyles = [
    'none',
    'static',
    'rainbow',
    'breathing',
    'reactive',
    'audio sync',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Special Requirements'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => _showSpecialRequirementsInfo(context),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildAestheticsSection(),
          const Divider(),
          _buildPortsSection(),
          const Divider(),
          _buildSoftwareSection(),
          const Divider(),
          _buildSpecialFeaturesSection(),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => widget.onNext(_gatherSpecialRequirementsData()),
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }

  Widget _buildAestheticsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Aesthetics',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        SwitchListTile(
          title: const Text('RGB Lighting'),
          value: wantsRGB,
          onChanged: (value) => setState(() => wantsRGB = value),
        ),
        if (wantsRGB) ...[
          DropdownButtonFormField<String>(
            value: rgbStyle,
            decoration: const InputDecoration(
              labelText: 'RGB Style',
            ),
            items: rgbStyles.map((style) {
              return DropdownMenuItem(
                value: style,
                child: Text(style.toUpperCase()),
              );
            }).toList(),
            onChanged: (value) => setState(() => rgbStyle = value!),
          ),
          const Text('RGB Components:'),
          ...rgbComponents.entries.map((entry) => CheckboxListTile(
            title: Text(entry.key),
            value: entry.value,
            onChanged: (value) {
              setState(() => rgbComponents[entry.key] = value!);
            },
          )),
        ],
        DropdownButtonFormField<String>(
          value: caseColor,
          decoration: const InputDecoration(
            labelText: 'Case Color',
          ),
          items: caseColors.map((color) {
            return DropdownMenuItem(
              value: color,
              child: Text(color.toUpperCase()),
            );
          }).toList(),
          onChanged: (value) => setState(() => caseColor = value!),
        ),
        SwitchListTile(
          title: const Text('Transparent Side Panel'),
          value: needsWindowPanel,
          onChanged: (value) => setState(() => needsWindowPanel = value),
        ),
      ],
    );
  }

  Widget _buildPortsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Required Ports',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ...requiredPorts.entries.map((entry) => Row(
          children: [
            Expanded(child: Text(entry.key)),
            DropdownButton<int>(
              value: entry.value,
              items: List.generate(7, (i) => i).map((count) {
                return DropdownMenuItem(
                  value: count,
                  child: Text('$count'),
                );
              }).toList(),
              onChanged: (value) {
                setState(() => requiredPorts[entry.key] = value!);
              },
            ),
          ],
        )),
      ],
    );
  }

  Widget _buildSoftwareSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Software Requirements',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: preferredOS,
          decoration: const InputDecoration(
            labelText: 'Preferred Operating System',
          ),
          items: ['Windows', 'Linux', 'Dual Boot'].map((os) {
            return DropdownMenuItem(value: os, child: Text(os));
          }).toList(),
          onChanged: (value) => setState(() => preferredOS = value!),
        ),
        const Text('Required Software Support:'),
        ...availableSoftware.map((software) => CheckboxListTile(
          title: Text(software),
          value: selectedSoftware.contains(software),
          onChanged: (value) {
            setState(() {
              if (value!) {
                selectedSoftware.add(software);
              } else {
                selectedSoftware.remove(software);
              }
            });
          },
        )),
        SwitchListTile(
          title: const Text('Virtualization Support'),
          subtitle: const Text('For running virtual machines'),
          value: needsVirtualization,
          onChanged: (value) => setState(() => needsVirtualization = value),
        ),
        SwitchListTile(
          title: const Text('Hackintosh Compatibility'),
          subtitle: const Text('For running macOS'),
          value: needsHackintosh,
          onChanged: (value) => setState(() => needsHackintosh = value),
        ),
      ],
    );
  }

  Widget _buildSpecialFeaturesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Special Features',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        SwitchListTile(
          title: const Text('Built-in WiFi'),
          value: needsWiFi,
          onChanged: (value) => setState(() => needsWiFi = value),
        ),
        SwitchListTile(
          title: const Text('Built-in Bluetooth'),
          value: needsBluetooth,
          onChanged: (value) => setState(() => needsBluetooth = value),
        ),
        SwitchListTile(
          title: const Text('Card Reader'),
          value: needsCardReader,
          onChanged: (value) => setState(() => needsCardReader = value),
        ),
        SwitchListTile(
          title: const Text('Front Panel I/O'),
          subtitle: const Text('USB and audio ports on the front'),
          value: needsFrontIO,
          onChanged: (value) => setState(() => needsFrontIO = value),
        ),
      ],
    );
  }

  void _showSpecialRequirementsInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Special Requirements Info'),
        content: const SingleChildScrollView(
          child: Text(
            'Special requirements affect component selection:\n\n'
            '• RGB components may cost more\n'
            '• Port requirements affect motherboard choice\n'
            '• Software compatibility impacts CPU/GPU selection\n'
            '• Special features may require specific motherboards\n'
            '• Aesthetics might limit case options',
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

  Map<String, dynamic> _gatherSpecialRequirementsData() {
    return {
      'aesthetics': {
        'wantsRGB': wantsRGB,
        'rgbStyle': rgbStyle,
        'rgbComponents': rgbComponents,
        'caseColor': caseColor,
        'needsWindowPanel': needsWindowPanel,
      },
      'ports': requiredPorts,
      'software': {
        'preferredOS': preferredOS,
        'requiredSoftware': selectedSoftware,
        'needsVirtualization': needsVirtualization,
        'needsHackintosh': needsHackintosh,
      },
      'specialFeatures': {
        'needsWiFi': needsWiFi,
        'needsBluetooth': needsBluetooth,
        'needsCardReader': needsCardReader,
        'needsFrontIO': needsFrontIO,
      },
    };
  }
}