import 'package:flutter/material.dart';
import 'package:myapp/screens/build/auto_build/auto_build_summary_screen.dart';
import 'package:myapp/screens/parts/parts_list_screen.dart';
import 'package:myapp/screens/build/build_comparison_screen.dart';
import 'package:myapp/models/build_config.dart';
import 'package:myapp/screens/build/manual_build/manual_build_summary_screen.dart';
import 'screens/build/auto_build/auto_build_screen.dart';

class Routes {
  static const String autoBuild = '/auto_build';
  static const String autoBuildSummary = '/auto_build_summary';
  static const String manualBuild = '/manual_build';
  static const String manualBuildSummary = '/manual_build_summary';
  static const String partsList = '/parts/list';
  static const String buildComparison = '/build/comparison';
  
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      autoBuild: (context) => const AutoBuildScreen(),
      autoBuildSummary: (context) => AutoBuildSummaryScreen(
        answers: ModalRoute.of(context)!.settings.arguments 
            as Map<String, dynamic>,
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