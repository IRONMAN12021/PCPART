import 'package:flutter/material.dart';
import '../services/supabase_service.dart';
import '../models/build_config.dart';
// Importing all the screens
import '../screens/auth/startscreen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/auth/splash_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/home/profile_screen.dart';
import '../screens/home/search_screen.dart';
import '../screens/build/build_pc.dart';
import '../screens/build/auto_build/auto_build_screen.dart';
import '../screens/build/manual_build/manual_build_screen.dart';
import '../screens/build/build_comparison_screen.dart';
import '../screens/settings/settings_screen.dart';
import '../screens/settings/about_screen.dart';
import '../screens/settings/feedback_screen.dart';
import '../screens/error/error_screen.dart';
import '../screens/build/manual_build/manual_build_summary_screen.dart';

class NavigationManager {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/start':
        return MaterialPageRoute(builder: (_) => const StartScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '/register':
        return MaterialPageRoute(
          builder: (_) => RegisterScreen(
            supabaseService: SupabaseService(),
          ),
        );
      case '/splash':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/profile':
        return MaterialPageRoute(builder: (_) => ProfileScreen());
      case '/search':
        return MaterialPageRoute(builder: (_) => SearchScreen());
      case '/build_pc':
        return MaterialPageRoute(builder: (_) => const BuildPcScreen());
      case '/auto_build':
        return MaterialPageRoute(builder: (_) => const AutoBuildScreen());
      case '/manual_build':
        return MaterialPageRoute(builder: (_) => const ManualBuildScreen());
      case '/summary':
        return MaterialPageRoute(
          builder: (_) => ManualBuildSummaryScreen(
            buildConfig: settings.arguments as BuildConfig,
          ),
        );
      case '/comparison':
        return MaterialPageRoute(
          builder: (_) => BuildComparisonScreen(
            autoBuildData: {}, // Pass data dynamically
            manualBuildData: {}, // Pass data dynamically
            preBuiltPCs: [], // Pass data dynamically
          ),
        );
      case '/settings':
        return MaterialPageRoute(builder: (_) => SettingsScreen());
      case '/about':
        return MaterialPageRoute(builder: (_) => AboutScreen());
      case '/feedback':
        return MaterialPageRoute(builder: (_) => FeedbackScreen());
      default:
        // Redirect to error screen if route is unknown
        return MaterialPageRoute(builder: (_) => const ErrorScreen());
    }
  }

  static void navigateTo(BuildContext context, String routeName,
      {Object? arguments}) {
    Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  static void navigateReplacementTo(BuildContext context, String routeName,
      {Object? arguments}) {
    Navigator.pushReplacementNamed(context, routeName, arguments: arguments);
  }

  static void navigateAndRemoveUntil(BuildContext context, String routeName,
      {Object? arguments}) {
    Navigator.pushNamedAndRemoveUntil(context, routeName, (route) => false,
        arguments: arguments);
  }
}
