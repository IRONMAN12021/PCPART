import 'package:flutter/material.dart';

class EnvironmentScreen extends StatefulWidget {
  final Function(Map<String, dynamic>) onNext;

  const EnvironmentScreen({super.key, required this.onNext});

  @override
  State<EnvironmentScreen> createState() => _EnvironmentScreenState();
}

class _EnvironmentScreenState extends State<EnvironmentScreen> {
  // Temperature settings
  double roomTemp = 25.0;
  bool hasAC = false;
  bool hasHeating = false;

  // Dust settings
  String dustLevel = 'moderate';
  bool hasPets = false;
  bool carpetedRoom = false;

  // Humidity and ventilation
  double humidity = 50.0;
  String ventilation = 'moderate';
  bool hasAirPurifier = false;

  // Sunlight exposure
  bool directSunlight = false;
  int sunlightHours = 0;
  String pcLocation = 'corner';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Environment Conditions'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => _showEnvironmentInfo(context),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildTemperatureSection(),
          const Divider(),
          _buildDustSection(),
          const Divider(),
          _buildVentilationSection(),
          const Divider(),
          _buildSunlightSection(),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => widget.onNext(_gatherEnvironmentData()),
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }

  Widget _buildTemperatureSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Temperature Control',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text('Room Temperature: ${roomTemp.toStringAsFixed(1)}°C'),
        Slider(
          value: roomTemp,
          min: 15,
          max: 35,
          divisions: 40,
          label: '${roomTemp.toStringAsFixed(1)}°C',
          onChanged: (value) => setState(() => roomTemp = value),
        ),
        SwitchListTile(
          title: const Text('Air Conditioning Available'),
          value: hasAC,
          onChanged: (value) => setState(() => hasAC = value),
        ),
        SwitchListTile(
          title: const Text('Heating Available'),
          value: hasHeating,
          onChanged: (value) => setState(() => hasHeating = value),
        ),
      ],
    );
  }

  Widget _buildDustSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Dust Conditions',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        RadioListTile<String>(
          title: const Text('Low'),
          subtitle: const Text('Clean environment, regular cleaning'),
          value: 'low',
          groupValue: dustLevel,
          onChanged: (value) => setState(() => dustLevel = value!),
        ),
        RadioListTile<String>(
          title: const Text('Moderate'),
          subtitle: const Text('Normal household dust'),
          value: 'moderate',
          groupValue: dustLevel,
          onChanged: (value) => setState(() => dustLevel = value!),
        ),
        RadioListTile<String>(
          title: const Text('High'),
          subtitle: const Text('Dusty environment or construction nearby'),
          value: 'high',
          groupValue: dustLevel,
          onChanged: (value) => setState(() => dustLevel = value!),
        ),
        SwitchListTile(
          title: const Text('Pets in the Room'),
          value: hasPets,
          onChanged: (value) => setState(() => hasPets = value),
        ),
        SwitchListTile(
          title: const Text('Carpeted Room'),
          value: carpetedRoom,
          onChanged: (value) => setState(() => carpetedRoom = value),
        ),
      ],
    );
  }

  Widget _buildVentilationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ventilation & Humidity',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text('Humidity Level: ${humidity.toInt()}%'),
        Slider(
          value: humidity,
          min: 20,
          max: 80,
          divisions: 60,
          label: '${humidity.toInt()}%',
          onChanged: (value) => setState(() => humidity = value),
        ),
        DropdownButtonFormField<String>(
          value: ventilation,
          decoration: const InputDecoration(
            labelText: 'Room Ventilation',
            helperText: 'How well is the room ventilated?',
          ),
          items: ['poor', 'moderate', 'good', 'excellent'].map((v) {
            return DropdownMenuItem(value: v, child: Text(v.toUpperCase()));
          }).toList(),
          onChanged: (value) => setState(() => ventilation = value!),
        ),
        SwitchListTile(
          title: const Text('Air Purifier Available'),
          value: hasAirPurifier,
          onChanged: (value) => setState(() => hasAirPurifier = value),
        ),
      ],
    );
  }

  Widget _buildSunlightSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Sunlight Exposure',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        SwitchListTile(
          title: const Text('Direct Sunlight Exposure'),
          value: directSunlight,
          onChanged: (value) => setState(() => directSunlight = value),
        ),
        if (directSunlight) ...[
          Text('Hours of Direct Sunlight: $sunlightHours'),
          Slider(
            value: sunlightHours.toDouble(),
            min: 0,
            max: 12,
            divisions: 12,
            label: '$sunlightHours hours',
            onChanged: (value) => setState(() => sunlightHours = value.toInt()),
          ),
        ],
        DropdownButtonFormField<String>(
          value: pcLocation,
          decoration: const InputDecoration(
            labelText: 'PC Location in Room',
          ),
          items: [
            'corner',
            'near window',
            'under desk',
            'open space',
          ].map((loc) {
            return DropdownMenuItem(
              value: loc,
              child: Text(loc.toUpperCase()),
            );
          }).toList(),
          onChanged: (value) => setState(() => pcLocation = value!),
        ),
      ],
    );
  }

  void _showEnvironmentInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Environment Considerations'),
        content: const SingleChildScrollView(
          child: Text(
            'Your PC\'s environment affects its performance and longevity:\n\n'
            '• Temperature impacts component lifespan\n'
            '• Dust can cause overheating\n'
            '• High humidity may cause condensation\n'
            '• Direct sunlight can increase heat and damage components\n'
            '• Poor ventilation reduces cooling efficiency',
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

  Map<String, dynamic> _gatherEnvironmentData() {
    return {
      'temperature': {
        'roomTemp': roomTemp,
        'hasAC': hasAC,
        'hasHeating': hasHeating,
      },
      'dust': {
        'level': dustLevel,
        'hasPets': hasPets,
        'carpetedRoom': carpetedRoom,
      },
      'ventilation': {
        'humidity': humidity,
        'ventilationQuality': ventilation,
        'hasAirPurifier': hasAirPurifier,
      },
      'sunlight': {
        'directExposure': directSunlight,
        'exposureHours': sunlightHours,
        'pcLocation': pcLocation,
      },
    };
  }
}