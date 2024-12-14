import 'package:flutter/material.dart';
import 'package:myapp/screens/build/auto_build/auto_bild_summary_screen.dart';
import 'package:myapp/screens/build/manual_build/manual_build_summary_screen.dart';
import 'package:myapp/screens/parts/parts_list_screen.dart';
import 'package:myapp/screens/build/build_comparison_screen.dart';
import 'package:myapp/models/build_config.dart';

class Routes {
  static const String autoBuildSummary = '/build/auto/summary';
  static const String manualBuildSummary = '/build/manual/summary';
  static const String partsList = '/parts/list';
  static const String buildComparison = '/build/comparison';
  
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      autoBuildSummary: (context) => BuildSummaryScreen(
        buildConfigId: ModalRoute.of(context)!.settings.arguments as String
      ),
      manualBuildSummary: (context) => ManualBuildSummaryScreen(
        buildConfig: ModalRoute.of(context)!.settings.arguments as BuildConfig,
      ),
      partsList: (context) => PartsListScreen(),
      buildComparison: (context) => BuildComparisonScreen(
        autoBuildData: {},
        manualBuildData: {},
        preBuiltPCs: [],
      ),
    };
  }
} 