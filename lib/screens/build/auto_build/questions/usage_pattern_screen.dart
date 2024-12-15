import 'package:flutter/material.dart';

class UsagePatternScreen extends StatefulWidget {
  final Function(Map<String, dynamic>) onNext;

  const UsagePatternScreen({super.key, required this.onNext});

  @override
  State<UsagePatternScreen> createState() => _UsagePatternScreenState();
}

class _UsagePatternScreenState extends State<UsagePatternScreen> {
  // Daily usage patterns
  int hoursPerDay = 8;
  List<String> peakUsageTimes = [];
  bool weekendUse = true;
  String primaryUseTime = 'day';

  // Workload patterns
  int simultaneousApps = 2;
  List<String> selectedBackgroundTasks = [];
  bool heavyMultitasking = false;
  String workloadIntensity = 'moderate';

  // System requirements
  bool quickStartup = false;
  bool requiresUPS = false;
  int maxStartupTime = 30; // seconds
  bool needsSleepMode = false;

  final List<String> timeSlots = [
    'Early Morning (4AM-8AM)',
    'Morning (8AM-12PM)',
    'Afternoon (12PM-4PM)',
    'Evening (4PM-8PM)',
    'Night (8PM-12AM)',
    'Late Night (12AM-4AM)',
  ];

  final List<String> backgroundTasks = [
    'Video Encoding/Rendering',
    'File Compression',
    'Antivirus Scanning',
    'Cloud Backup',
    'Large Downloads',
    'Virtual Machines',
    'Game Servers',
    'Media Streaming',
    'Data Analysis',
    'Code Compilation',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usage Pattern'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => _showUsageInfo(context),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildDailyUsageSection(),
          const Divider(),
          _buildWorkloadSection(),
          const Divider(),
          _buildSystemRequirementsSection(),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => widget.onNext(_gatherUsageData()),
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }

  Widget _buildDailyUsageSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Daily Usage Pattern',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text('Hours of Use per Day: $hoursPerDay'),
        Slider(
          value: hoursPerDay.toDouble(),
          min: 1,
          max: 24,
          divisions: 23,
          label: '$hoursPerDay hours',
          onChanged: (value) => setState(() => hoursPerDay = value.toInt()),
        ),
        const Text('Peak Usage Times:'),
        ...timeSlots.map((time) => CheckboxListTile(
          title: Text(time),
          value: peakUsageTimes.contains(time),
          onChanged: (value) {
            setState(() {
              if (value!) {
                peakUsageTimes.add(time);
              } else {
                peakUsageTimes.remove(time);
              }
            });
          },
        )),
        SwitchListTile(
          title: const Text('Weekend Use'),
          subtitle: const Text('PC will be used on weekends'),
          value: weekendUse,
          onChanged: (value) => setState(() => weekendUse = value),
        ),
        RadioListTile<String>(
          title: const Text('Primarily Day Use'),
          value: 'day',
          groupValue: primaryUseTime,
          onChanged: (value) => setState(() => primaryUseTime = value!),
        ),
        RadioListTile<String>(
          title: const Text('Primarily Night Use'),
          value: 'night',
          groupValue: primaryUseTime,
          onChanged: (value) => setState(() => primaryUseTime = value!),
        ),
      ],
    );
  }

  Widget _buildWorkloadSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Workload Pattern',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text('Simultaneous Applications: $simultaneousApps'),
        Slider(
          value: simultaneousApps.toDouble(),
          min: 1,
          max: 10,
          divisions: 9,
          label: '$simultaneousApps apps',
          onChanged: (value) => setState(() => simultaneousApps = value.toInt()),
        ),
        const Text('Background Tasks:'),
        ...backgroundTasks.map((task) => CheckboxListTile(
          title: Text(task),
          value: selectedBackgroundTasks.contains(task),
          onChanged: (value) {
            setState(() {
              if (value!) {
                selectedBackgroundTasks.add(task);
              } else {
                selectedBackgroundTasks.remove(task);
              }
            });
          },
        )),
        SwitchListTile(
          title: const Text('Heavy Multitasking'),
          subtitle: const Text('Frequent switching between applications'),
          value: heavyMultitasking,
          onChanged: (value) => setState(() => heavyMultitasking = value),
        ),
        DropdownButtonFormField<String>(
          value: workloadIntensity,
          decoration: const InputDecoration(
            labelText: 'Workload Intensity',
          ),
          items: ['light', 'moderate', 'heavy', 'extreme'].map((intensity) {
            return DropdownMenuItem(
              value: intensity,
              child: Text(intensity.toUpperCase()),
            );
          }).toList(),
          onChanged: (value) => setState(() => workloadIntensity = value!),
        ),
      ],
    );
  }

  Widget _buildSystemRequirementsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'System Requirements',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        SwitchListTile(
          title: const Text('Quick Startup Required'),
          value: quickStartup,
          onChanged: (value) => setState(() => quickStartup = value),
        ),
        if (quickStartup) ...[
          Text('Maximum Startup Time: $maxStartupTime seconds'),
          Slider(
            value: maxStartupTime.toDouble(),
            min: 10,
            max: 120,
            divisions: 22,
            label: '$maxStartupTime seconds',
            onChanged: (value) => setState(() => maxStartupTime = value.toInt()),
          ),
        ],
        SwitchListTile(
          title: const Text('UPS Required'),
          subtitle: const Text('Uninterrupted Power Supply needed'),
          value: requiresUPS,
          onChanged: (value) => setState(() => requiresUPS = value),
        ),
        SwitchListTile(
          title: const Text('Sleep Mode Required'),
          subtitle: const Text('PC needs to support sleep/hibernate'),
          value: needsSleepMode,
          onChanged: (value) => setState(() => needsSleepMode = value),
        ),
      ],
    );
  }

  void _showUsageInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Usage Pattern Considerations'),
        content: const SingleChildScrollView(
          child: Text(
            'Your usage pattern affects component selection:\n\n'
            '• Long hours may require better cooling\n'
            '• Heavy multitasking needs more RAM\n'
            '• Background tasks impact CPU choice\n'
            '• Quick startup requires SSD\n'
            '• UPS protects against power issues',
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

  Map<String, dynamic> _gatherUsageData() {
    return {
      'dailyUsage': {
        'hoursPerDay': hoursPerDay,
        'peakTimes': peakUsageTimes,
        'weekendUse': weekendUse,
        'primaryUseTime': primaryUseTime,
      },
      'workload': {
        'simultaneousApps': simultaneousApps,
        'backgroundTasks': selectedBackgroundTasks,
        'heavyMultitasking': heavyMultitasking,
        'intensity': workloadIntensity,
      },
      'systemRequirements': {
        'quickStartup': quickStartup,
        'maxStartupTime': maxStartupTime,
        'requiresUPS': requiresUPS,
        'needsSleepMode': needsSleepMode,
      },
    };
  }
}