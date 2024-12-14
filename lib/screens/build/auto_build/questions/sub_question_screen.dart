import 'package:flutter/material.dart';

class GamingSubQuestionsScreen extends StatefulWidget {
  final Function(String, String, String, String, String) onNext;

  const GamingSubQuestionsScreen({super.key, required this.onNext});

  @override
  State<GamingSubQuestionsScreen> createState() => _GamingSubQuestionsScreenState();
}

class _GamingSubQuestionsScreenState extends State<GamingSubQuestionsScreen> {
  final resolutions = ['1080p', '1440p', '4K'];
  final refreshRates = ['60Hz', '120Hz', '144Hz', '240Hz'];
  final rayTracing = ['Ray Tracing On', 'Ray Tracing Off'];
  final aiUpscaling = ['AI Upscaling On', 'AI Upscaling Off'];
  final dlss = ['DLSS On', 'DLSS Off'];

  late String selectedResolution;
  late String selectedRefreshRate;
  late String selectedRayTracing;
  late String selectedAiUpscaling;
  late String selectedDlss;

  @override
  void initState() {
    super.initState();
    selectedResolution = resolutions[0];
    selectedRefreshRate = refreshRates[0];
    selectedRayTracing = rayTracing[0];
    selectedAiUpscaling = aiUpscaling[0];
    selectedDlss = dlss[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gaming Preferences')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: selectedResolution,
              onChanged: (value) => setState(() => selectedResolution = value!),
              items: resolutions.map((res) => DropdownMenuItem(value: res, child: Text(res))).toList(),
            ),
            DropdownButton<String>(
              value: selectedRefreshRate,
              onChanged: (value) => setState(() => selectedRefreshRate = value!),
              items: refreshRates.map((rate) => DropdownMenuItem(value: rate, child: Text(rate))).toList(),
            ),
            DropdownButton<String>(
              value: selectedRayTracing,
              onChanged: (value) => setState(() => selectedRayTracing = value!),
              items: rayTracing.map((rt) => DropdownMenuItem(value: rt, child: Text(rt))).toList(),
            ),
            DropdownButton<String>(
              value: selectedAiUpscaling,
              onChanged: (value) => setState(() => selectedAiUpscaling = value!),
              items: aiUpscaling.map((ai) => DropdownMenuItem(value: ai, child: Text(ai))).toList(),
            ),
            DropdownButton<String>(
              value: selectedDlss,
              onChanged: (value) => setState(() => selectedDlss = value!),
              items: dlss.map((d) => DropdownMenuItem(value: d, child: Text(d))).toList(),
            ),
            ElevatedButton(
              onPressed: () => widget.onNext(
                selectedResolution,
                selectedRefreshRate,
                selectedRayTracing,
                selectedAiUpscaling,
                selectedDlss,
              ),
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
