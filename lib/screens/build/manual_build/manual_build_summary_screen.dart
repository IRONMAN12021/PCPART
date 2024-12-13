import 'package:flutter/material.dart';
import 'package:myapp/models/build_config.dart';
import 'package:myapp/services/bottleneckpercentage.dart';
import 'package:myapp/services/comparesystems.dart';
import 'package:myapp/services/compatibility_checker.dart';
import 'package:myapp/constants.dart';
import 'package:myapp/formatters.dart';

class BuildSummaryScreen extends StatefulWidget {
  final BuildConfig buildConfig;

  BuildSummaryScreen({required this.buildConfig});

  @override
  _BuildSummaryScreenState createState() => _BuildSummaryScreenState();
}

class _BuildSummaryScreenState extends State<BuildSummaryScreen> {
  double bottleneckPercentage = 0.0;
  bool isLoading = true;
  Map<String, dynamic>? comparison;
  List<Map<String, dynamic>> hottestConfigs = [];
  List<Map<String, dynamic>> mostSelectedConfigs = [];
  List<Map<String, dynamic>> mostSuggestedConfigs = [];
  List<Map<String, dynamic>> compatibilityResults = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final cpu = widget.buildConfig.parts.firstWhere((part) => part.type == 'CPU').name;
    final gpu = widget.buildConfig.parts.firstWhere((part) => part.type == 'GPU').name;

    final comparisonResult = await compareSystems(cpu, gpu);
    final hottest = await getHottestConfigs();
    final mostSelected = await getMostSelectedConfigs();
    final mostSuggested = await getMostSuggestedConfigs();

    final compatibilityChecker = CompatibilityChecker();
    final cpuSocket = widget.buildConfig.parts.firstWhere((part) => part.type == 'CPU').socket;
    final motherboardSocket = widget.buildConfig.parts.firstWhere((part) => part.type == 'Motherboard').socket;
    final ramType = widget.buildConfig.parts.firstWhere((part) => part.type == 'RAM').type;
    final motherboardRamType = widget.buildConfig.parts.firstWhere((part) => part.type == 'Motherboard').ramType;
    final storageType = widget.buildConfig.parts.firstWhere((part) => part.type == 'Storage').type;
    final motherboardSupportedStorageTypes = widget.buildConfig.parts.firstWhere((part) => part.type == 'Motherboard').supportedStorageTypes;
    final cpuCoolerHeight = widget.buildConfig.parts.firstWhere((part) => part.type == 'CPU Cooler').height;
    final caseMaxCoolerHeight = widget.buildConfig.parts.firstWhere((part) => part.type == 'Case').maxCoolerHeight;
    final motherboardFormFactor = widget.buildConfig.parts.firstWhere((part) => part.type == 'Motherboard').formFactor;
    final caseSupportedFormFactor = widget.buildConfig.parts.firstWhere((part) => part.type == 'Case').supportedFormFactor;
    final powerSupplyFormFactor = widget.buildConfig.parts.firstWhere((part) => part.type == 'Power Supply').formFactor;

    final compatibilityResults = [
      compatibilityChecker.checkCpuMotherboardCompatibility(cpuSocket, motherboardSocket),
      compatibilityChecker.checkRamCompatibility(ramType, motherboardRamType),
      compatibilityChecker.checkStorageCompatibility(storageType, motherboardSupportedStorageTypes),
      compatibilityChecker.checkCpuCaseCompatibility(cpuCoolerHeight, caseMaxCoolerHeight),
      compatibilityChecker.checkMotherboardCaseCompatibility(motherboardFormFactor, caseSupportedFormFactor),
      compatibilityChecker.checkPowerSupplyCompatibility(powerSupplyFormFactor, caseSupportedFormFactor),
    ];

    setState(() {
      comparison = comparisonResult;
      bottleneckPercentage = comparisonResult['bottleneckPercentage'];
      hottestConfigs = hottest;
      mostSelectedConfigs = mostSelected;
      mostSuggestedConfigs = mostSuggested;
      this.compatibilityResults = compatibilityResults;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userLocale = Localizations.localeOf(context).toString();
    final userCurrencySymbol = '\$'; // Replace with user's chosen currency symbol
    final conversionRate = 1.0; // Replace with actual conversion rate

    return Scaffold(
      appBar: AppBar(
        title: Text('Build Summary'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  Text('Build ID: ${widget.buildConfig.id}'),
                  Text('User ID: ${widget.buildConfig.userId}'),
                  Text('Total Price: ${Formatters.convertCurrency(widget.buildConfig.totalPrice, conversionRate, targetCurrencySymbol: userCurrencySymbol)}'),
                  SizedBox(height: 20),
                  Text('Bottleneck Percentage: ${bottleneckPercentage.toStringAsFixed(2)}%'),
                  SizedBox(height: 20),
                  Text('Comparison:'),
                  Text('CPU Performance: ${comparison?['cpuPerformance']}'),
                  Text('GPU Performance: ${comparison?['gpuPerformance']}'),
                  Text('Performance Difference: ${comparison?['performanceDifference']}'),
                  SizedBox(height: 20),
                  Text('Compatibility Results:'),
                  ...compatibilityResults.map((result) => Text(result['message'])),
                  SizedBox(height: 20),
                  Text('Hottest Configurations:'),
                  ...hottestConfigs.map((config) => Text('${config['name']} - ${config['performance']}')),
                  SizedBox(height: 20),
                  Text('Most Selected Configurations:'),
                  ...mostSelectedConfigs.map((config) => Text('${config['name']} - ${config['performance']}')),
                  SizedBox(height: 20),
                  Text('Most Suggested Configurations:'),
                  ...mostSuggestedConfigs.map((config) => Text('${config['name']} - ${config['performance']}')),
                  SizedBox(height: 20),
                  Text('Current Date and Time: ${Formatters.formatDateTime(DateTime.now(), locale: userLocale)}'),
                ],
              ),
            ),
    );
  }
}
