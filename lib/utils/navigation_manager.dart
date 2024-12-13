import 'package:flutter/material.dart';

// Importing all the screens
import '../screens/start_screen.dart';
import '../screens/login_screen.dart';
import '../screens/register_screen.dart';
import '../screens/splash_screen.dart';
import '../screens/home_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/search_screen.dart';
import '../screens/build_pc.dart';
import '../screens/auto_build_screen.dart';
import '../screens/manual_build_screen.dart';
import '../screens/build_summary_screen.dart';
import '../screens/build_comparison_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/about_screen.dart';
import '../screens/feedback_screen.dart';
import '../screens/error_screen.dart';

class NavigationManager {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/start':
        return MaterialPageRoute(builder: (_) => const StartScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/register':
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case '/splash':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/profile':
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case '/search':
        return MaterialPageRoute(builder: (_) => const SearchScreen());
      case '/build_pc':
        return MaterialPageRoute(builder: (_) => const BuildPcScreen());
      case '/auto_build':
        return MaterialPageRoute(builder: (_) => const AutoBuildScreen());
      case '/manual_build':
        return MaterialPageRoute(builder: (_) => const ManualBuildScreen());
      case '/summary':
        return MaterialPageRoute(builder: (_) => const SummaryScreen());
      case '/comparison':
        return MaterialPageRoute(
          builder: (_) => BuildComparisonScreen(
            autoBuildData: {}, // Pass data dynamically
            manualBuildData: {}, // Pass data dynamically
            preBuiltPCs: [], // Pass data dynamically
          ),
        );
      case '/settings':
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case '/about':
        return MaterialPageRoute(builder: (_) => const AboutScreen());
      case '/feedback':
        return MaterialPageRoute(builder: (_) => const FeedbackScreen());
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
