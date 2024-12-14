import 'package:flutter/material.dart';

class BuildComparisonScreen extends StatelessWidget {
  final Map<String, dynamic> autoBuildData;
  final Map<String, dynamic> manualBuildData;
  final List<Map<String, dynamic>> preBuiltPCs;

  const BuildComparisonScreen({super.key, 
    required this.autoBuildData,
    required this.manualBuildData,
    required this.preBuiltPCs,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Build Comparison'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Comparison Results',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              _buildComparisonSection('Auto Build', autoBuildData),
              _buildComparisonSection('Manual Build', manualBuildData),
              Text(
                'Pre-Built PCs',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              // ignore: unnecessary_to_list_in_spreads
              ...preBuiltPCs.map((pc) => _buildPreBuiltSection(pc)).toList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildComparisonSection(String title, Map<String, dynamic> data) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Divider(),
            ...data.entries.map((entry) => ListTile(
                  title: Text(entry.key),
                  subtitle: Text(entry.value.toString()),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildPreBuiltSection(Map<String, dynamic> preBuiltPC) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              preBuiltPC['name'],
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Divider(),
            ...preBuiltPC.entries
                .where((entry) => entry.key != 'name')
                .map((entry) => ListTile(
                      title: Text(entry.key),
                      subtitle: Text(entry.value.toString()),
                    )),
          ],
        ),
      ),
    );
  }
}
