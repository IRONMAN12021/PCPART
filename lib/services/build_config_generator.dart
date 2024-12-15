import 'package:myapp/models/build_config.dart';
import 'package:myapp/models/pc_part.dart';

class BuildConfigGenerator {
  static Future<BuildConfig> generateFromAnswers(Map<String, dynamic> answers) async {
    // Calculate budget allocation based on use case and preferences
    final budgetAllocation = _calculateBudgetAllocation(
      double.parse(answers['budget']),
      answers['useCase'],
      answers['futureProofing'],
    );

    // Generate component requirements
    final requirements = _generateRequirements(answers);

    // TODO: Implement actual part selection logic
    final selectedParts = await _selectOptimalParts(
      budgetAllocation,
      requirements,
      answers['environment'],
      answers['noisePreferences'],
    );

    return BuildConfig(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: 'temp_user', // TODO: Implement user authentication
      parts: selectedParts,
      totalPrice: selectedParts.fold(0.0, (sum, part) => sum + part.price),
    );
  }

  static Map<String, double> _calculateBudgetAllocation(
    double totalBudget,
    String useCase,
    Map<String, dynamic> futureProofing,
  ) {
    // Default allocation percentages
    Map<String, double> allocation = {
      'CPU': 0.25,
      'GPU': 0.35,
      'RAM': 0.10,
      'Motherboard': 0.12,
      'Storage': 0.08,
      'PSU': 0.05,
      'Case': 0.03,
      'Cooling': 0.02,
    };

    // Adjust based on use case
    switch (useCase) {
      case 'Gaming':
        allocation['GPU'] = 0.40;
        allocation['CPU'] = 0.20;
        break;
      case 'Productivity':
        allocation['CPU'] = 0.35;
        allocation['RAM'] = 0.15;
        allocation['Storage'] = 0.12;
        break;
      // Add other use cases
    }

    // Adjust for future proofing
    if (futureProofing['planToUpgrade']) {
      allocation['Motherboard'] = (allocation['Motherboard'] ?? 0.0) + 0.05;
      allocation['PSU'] = (allocation['PSU'] ?? 0.0) + 0.03;
    }

    return allocation.map((key, value) => 
      MapEntry(key, value * totalBudget));
  }

  static Map<String, Map<String, dynamic>> _generateRequirements(
    Map<String, dynamic> answers
  ) {
    return {
      'CPU': {
        'minCores': _calculateMinCores(answers),
        'preferredBrand': _determinePreferredCpuBrand(answers),
        'needsIntegratedGraphics': _needsIntegratedGraphics(answers),
      },
      'GPU': {
        'minVRAM': _calculateMinVRAM(answers),
        'rayTracingRequired': answers['specialRequirements']?['wantsRGB'] ?? false,
      },
      'RAM': {
        'minCapacity': _calculateMinRAM(answers),
        'preferredSpeed': answers['futureProofing']?['technology']?['RAM'],
      },
      // Add other components
    };
  }

  static int _calculateMinCores(Map<String, dynamic> answers) {
    final useCase = answers['useCase'];
    final workload = answers['usagePattern']?['workload'];
    
    if (workload?['heavyMultitasking'] == true) return 8;
    if (useCase == 'Gaming') return 6;
    if (useCase == 'Productivity') return 6;
    return 4;
  }

  static int _calculateMinVRAM(Map<String, dynamic> answers) {
    final resolution = answers['subQuestions']?['resolution'];
    
    if (resolution == '4K') return 8;
    if (resolution == '1440p') return 6;
    return 4;
  }

  static int _calculateMinRAM(Map<String, dynamic> answers) {
    final useCase = answers['useCase'];
    final simultaneousApps = answers['usagePattern']?['workload']?['simultaneousApps'] ?? 2;
    
    if (simultaneousApps > 5) return 32;
    if (useCase == 'Productivity') return 16;
    return 8;
  }

  static String? _determinePreferredCpuBrand(Map<String, dynamic> answers) {
    if (answers['specialRequirements']?['needsHackintosh'] == true) {
      return 'Intel'; // Hackintosh typically works better with Intel
    }
    return null; // No preference
  }

  static bool _needsIntegratedGraphics(Map<String, dynamic> answers) {
    return answers['specialRequirements']?['needsBackupDisplay'] == true;
  }

  static Future<List<PCPart>> _selectOptimalParts(
    Map<String, double> budgetAllocation,
    Map<String, Map<String, dynamic>> requirements,
    Map<String, dynamic> environment,
    Map<String, dynamic> noisePreferences,
  ) async {
    // TODO: Implement actual part selection logic
    // This should query a database or API to find compatible parts
    // that meet the requirements within the budget allocation
    return [];
  }
} 