import 'package:flutter/material.dart';
import 'package:myapp/services/gemini_service.dart';
import 'package:myapp/models/build_config.dart';

class BuildSummaryScreen extends StatefulWidget {
  final String buildConfigId;

  BuildSummaryScreen({required this.buildConfigId});

  @override
  _BuildSummaryScreenState createState() => _BuildSummaryScreenState();
}

class _BuildSummaryScreenState extends State<BuildSummaryScreen> {
  late GeminiService geminiService;
  BuildConfig? buildConfig;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    geminiService = GeminiService(
      baseUrl: 'https://api.gemini.com/v1',
      apiKey: 'your_api_key_here',
    );
    _fetchBuildConfig();
  }

  Future<void> _fetchBuildConfig() async {
    try {
      final fetchedBuildConfig = await geminiService.fetchBuildConfig(widget.buildConfigId);
      setState(() {
        buildConfig = fetchedBuildConfig;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching build config: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Build Summary')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : buildConfig == null
              ? Center(child: Text('Failed to load build config'))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
                    children: [
                      Text('Build ID: ${buildConfig!.id}'),
                      Text('User ID: ${buildConfig!.userId}'),
                      Text('Total Price: \$${buildConfig!.totalPrice}'),
                      SizedBox(height: 20),
                      Text('Parts:'),
                      ...buildConfig!.parts.map((part) => ListTile(
                            title: Text(part.name),
                            subtitle: Text('Type: ${part.type}, Price: \$${part.price}'),
                          )),
                    ],
                  ),
                ),
    );
  }
}