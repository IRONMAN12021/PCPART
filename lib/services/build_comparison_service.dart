import 'package:myapp/models/build_config.dart';
import 'package:myapp/services/benchmark_service.dart';

class BuildComparisonService {
  final BenchmarkService _benchmarkService;

  BuildComparisonService(this._benchmarkService);

  Future<Map<String, dynamic>> compareBuildPerformance(
    BuildConfig build1,
    BuildConfig build2,
  ) async {
    final scores1 = await _getAggregateScores(build1);
    final scores2 = await _getAggregateScores(build2);

    return {
      'gaming': _compareMetric(scores1['gaming'] ?? 0, scores2['gaming'] ?? 0),
      'productivity': _compareMetric(scores1['productivity'] ?? 0, scores2['productivity'] ?? 0),
      'value': await _compareValue(build1, scores1, build2, scores2),
      'powerEfficiency': await _comparePowerEfficiency(build1, scores1, build2, scores2),
    };
  }

  Future<Map<String, double>> _getAggregateScores(BuildConfig build) async {
    final scores = <String, double>{};
    
    for (final part in build.parts) {
      final benchmarks = await _benchmarkService.getComponentBenchmarks(
        part.id,
        part.type,
      );

      // Aggregate gaming scores
      if (part.type == 'GPU') {
        scores['gaming'] = (scores['gaming'] ?? 0) + 
            (benchmarks['gaming_score'] as double? ?? 0);
      }
      
      // Aggregate productivity scores
      if (part.type == 'CPU') {
        scores['productivity'] = (scores['productivity'] ?? 0) + 
            (benchmarks['productivity_score'] as double? ?? 0);
      }
    }

    return scores;
  }

  Map<String, dynamic> _compareMetric(double score1, double score2) {
    if (score1 == 0 || score2 == 0) {
      return {
        'difference': 0.0,
        'betterBuild': 'Unable to compare',
        'reason': 'Missing benchmark data',
      };
    }

    final difference = ((score2 - score1) / score1 * 100).roundToDouble();
    return {
      'difference': difference,
      'betterBuild': difference > 0 ? 'Build 2' : 'Build 1',
      'percentageDifference': '${difference.abs()}%',
    };
  }

  Future<Map<String, dynamic>> _compareValue(
    BuildConfig build1,
    Map<String, double> scores1,
    BuildConfig build2,
    Map<String, double> scores2,
  ) async {
    final performance1 = (scores1['gaming'] ?? 0) + (scores1['productivity'] ?? 0);
    final performance2 = (scores2['gaming'] ?? 0) + (scores2['productivity'] ?? 0);

    final valueRatio1 = performance1 / build1.totalPrice;
    final valueRatio2 = performance2 / build2.totalPrice;

    final difference = ((valueRatio2 - valueRatio1) / valueRatio1 * 100).roundToDouble();

    return {
      'difference': difference,
      'betterValue': difference > 0 ? 'Build 2' : 'Build 1',
      'valueRatio1': valueRatio1.toStringAsFixed(2),
      'valueRatio2': valueRatio2.toStringAsFixed(2),
    };
  }

  Future<Map<String, dynamic>> _comparePowerEfficiency(
    BuildConfig build1,
    Map<String, double> scores1,
    BuildConfig build2,
    Map<String, double> scores2,
  ) async {
    final performance1 = (scores1['gaming'] ?? 0) + (scores1['productivity'] ?? 0);
    final performance2 = (scores2['gaming'] ?? 0) + (scores2['productivity'] ?? 0);

    final totalPower1 = build1.parts.fold<double>(
      0,
      (sum, part) => sum + (part.specifications['tdp'] as double? ?? 0),
    );

    final totalPower2 = build2.parts.fold<double>(
      0,
      (sum, part) => sum + (part.specifications['tdp'] as double? ?? 0),
    );

    final efficiency1 = performance1 / totalPower1;
    final efficiency2 = performance2 / totalPower2;

    final difference = ((efficiency2 - efficiency1) / efficiency1 * 100).roundToDouble();

    return {
      'difference': difference,
      'moreEfficient': difference > 0 ? 'Build 2' : 'Build 1',
      'efficiency1': efficiency1.toStringAsFixed(2),
      'efficiency2': efficiency2.toStringAsFixed(2),
      'totalPower1': totalPower1,
      'totalPower2': totalPower2,
    };
  }
} 