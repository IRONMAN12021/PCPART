import 'package:myapp/models/build_config.dart';

class BuildValidator {
  static Map<String, dynamic> validateBuild(BuildConfig config) {
    final issues = <String, List<String>>{};
    
    _validatePowerRequirements(config, issues);
    _validateCooling(config, issues);
    _validateCompatibility(config, issues);
    _validateBudget(config, issues);
    
    return {
      'isValid': issues.isEmpty,
      'issues': issues,
    };
  }

  static void _validatePowerRequirements(
    BuildConfig config,
    Map<String, List<String>> issues
  ) {
    final totalPower = _calculateTotalPower(config);
    final psu = config.parts.firstWhere((p) => p.type == 'PSU');
    final psuWattage = psu.specifications['wattage'] as int;

    if (psuWattage < totalPower * 1.2) {
      issues['power'] = ['PSU wattage may be insufficient with only ${psuWattage}W'];
    }
  }

  static double _calculateTotalPower(BuildConfig config) {
    return config.parts.fold(0.0, (sum, part) {
      return sum + (part.specifications['tdp'] as double? ?? 0);
    });
  }

  static void _validateCooling(BuildConfig config, Map<String, List<String>> issues) {
    final cpu = config.parts.firstWhere((p) => p.type == 'CPU');
    final cooler = config.parts.firstWhere((p) => p.type == 'CPU Cooler');
    final cpuTdp = cpu.specifications['tdp'] as double? ?? 0;
    final coolerCapacity = cooler.specifications['cooling_capacity'] as double? ?? 0;

    if (coolerCapacity < cpuTdp) {
      issues['cooling'] = ['CPU cooler capacity insufficient for CPU TDP'];
    }
  }

  static void _validateCompatibility(BuildConfig config, Map<String, List<String>> issues) {
    // Validate CPU and motherboard socket compatibility
    final cpu = config.parts.firstWhere((p) => p.type == 'CPU');
    final motherboard = config.parts.firstWhere((p) => p.type == 'Motherboard');
    if (cpu.specifications['socket'] != motherboard.specifications['socket']) {
      issues['compatibility'] = [...(issues['compatibility'] ?? []), 
        'CPU socket ${cpu.specifications['socket']} not compatible with motherboard socket ${motherboard.specifications['socket']}'
      ];
    }

    // Validate case and motherboard form factor compatibility 
    final case_ = config.parts.firstWhere((p) => p.type == 'Case');
    final caseFormFactors = case_.specifications['supported_form_factors'] as List<String>;
    final moboFormFactor = motherboard.specifications['form_factor'] as String;
    if (!caseFormFactors.contains(moboFormFactor)) {
      issues['compatibility'] = [...(issues['compatibility'] ?? []),
        'Case does not support motherboard form factor $moboFormFactor'
      ];
    }

    // Validate RAM compatibility
    final ram = config.parts.where((p) => p.type == 'RAM').toList();
    final supportedRamType = motherboard.specifications['ram_type'] as String;
    for (final module in ram) {
      if (module.specifications['type'] != supportedRamType) {
        issues['compatibility'] = [...(issues['compatibility'] ?? []),
          'RAM module type ${module.specifications['type']} not compatible with motherboard RAM type $supportedRamType'
        ];
      }
    }
  }

  static void _validateBudget(BuildConfig config, Map<String, List<String>> issues) {
    // Implement budget validation logic
  }

  // Add other validation methods...
} 