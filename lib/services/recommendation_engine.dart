class RecommendationEngine {
  static Future<List<Map<String, dynamic>>> getAlternatives(Map<String, dynamic> config) async {
    final alternatives = <Map<String, dynamic>>[];
    
    // Generate alternative configurations
    alternatives.addAll([
      await _generateBudgetAlternative(config),
      await _generatePerformanceAlternative(config),
      await _generateBalancedAlternative(config),
    ]);
    
    return alternatives;
  }

  static Future<Map<String, dynamic>> _generateBudgetAlternative(Map<String, dynamic> config) async {
    final budgetConfig = Map<String, dynamic>.from(config);
    
    // Adjust component selections to meet target budget
    for (var component in budgetConfig['parts']) {
      // Look for cheaper alternatives that maintain minimum requirements
      component['price'] = await _findCheaperAlternative(
        component['type'],
        component['price'],
        component['specifications']
      );
    }
    
    budgetConfig['totalPrice'] = _calculateTotal(budgetConfig);
    budgetConfig['name'] = 'Budget Alternative';
    return budgetConfig;
  }

  static double _calculateTotal(Map<String, dynamic> config) {
    return (config['parts'] as List).fold<double>(
      0, (sum, part) => sum + (part['price'] as double)
    );
  }

  static Future<double> _findCheaperAlternative(
    String type,
    double currentPrice,
    Map<String, dynamic> specs
  ) async {
    // For now, simply reduce by 15% - replace with actual part lookup logic
    return currentPrice * 0.85;
  }

  static Future<Map<String, dynamic>> _generatePerformanceAlternative(Map<String, dynamic> config) async {
    final performanceConfig = Map<String, dynamic>.from(config);
    
    // Upgrade component selections for better performance
    for (var component in performanceConfig['parts']) {
      component['price'] = await _findUpgradedAlternative(
        component['type'],
        component['price'],
        component['specifications']
      );
    }
    
    performanceConfig['totalPrice'] = _calculateTotal(performanceConfig);
    performanceConfig['name'] = 'Performance Alternative';
    return performanceConfig;
  }

  static Future<double> _findUpgradedAlternative(
    String type,
    double currentPrice,
    Map<String, dynamic> specs
  ) async {
    // For now, increase price by 30% to simulate better components
    return currentPrice * 1.3;
  }

  static Future<Map<String, dynamic>> _generateBalancedAlternative(Map<String, dynamic> config) async {
    final balancedConfig = Map<String, dynamic>.from(config);
    
    // Adjust components for balanced price/performance
    for (var component in balancedConfig['parts']) {
      component['price'] = await _findBalancedAlternative(
        component['type'],
        component['price'],
        component['specifications']
      );
    }
    
    balancedConfig['totalPrice'] = _calculateTotal(balancedConfig);
    balancedConfig['name'] = 'Balanced Alternative';
    return balancedConfig;
  }

  static Future<double> _findBalancedAlternative(
    String type,
    double currentPrice,
    Map<String, dynamic> specs
  ) async {
    // For now, adjust price by ±10% based on component type
    final adjustment = type == 'CPU' || type == 'GPU' ? 1.1 : 0.9;
    return currentPrice * adjustment;
  }

  // Add other recommendation methods...
} 