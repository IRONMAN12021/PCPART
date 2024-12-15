import 'package:flutter/material.dart';
import 'package:myapp/screens/parts/part_details_screen.dart';
//import 'package:myapp/services/scraper_service.dart';
import 'package:myapp/services/amazon_service.dart';
import 'package:myapp/screens/build/auto_build/auto_build_screen.dart';
//import 'package:myapp/screens/build/auto_build/questions/budget.dart';
//import 'package:myapp/screens/build/auto_build/questions/use_case_screen.dart';
//import 'package:myapp/screens/build/auto_build/questions/sub_question_screen.dart';
//import 'package:myapp/screens/build/auto_build/auto_bild_summary_screen.dart';//
//import 'package:myapp/screens/build/build_comparison_screen.dart';
import 'package:myapp/screens/build/manual_build/manual_build_screen.dart';
//import 'package:myapp/screens/build/manual_build/manual_build_summary_screen.dart';
//import 'package:myapp/widgets/part_card.dart';
//import 'package:myapp/widgets/loading_indicator.dart';
//import 'package:myapp/widgets/error_display.dart';
import 'package:myapp/services/price_tracker_service.dart';
import 'package:myapp/services/benchmark_service.dart';
import 'package:myapp/services/ai_recommendation_service.dart';

class PartsListScreen extends StatefulWidget {
  const PartsListScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PartsListScreenState createState() => _PartsListScreenState();
}

class _PartsListScreenState extends State<PartsListScreen> {
  late AmazonService amazonService;
  List<Map<String, dynamic>> parts = [];
  bool isLoading = true;
  late AIRecommendationService aiService;
  late PriceTrackerService priceTracker;
  late BenchmarkService benchmarkService;

  @override
  void initState() {
    super.initState();
    priceTracker = PriceTrackerService();
    benchmarkService = BenchmarkService();
    aiService = AIRecommendationService(
      priceTracker: priceTracker,
      benchmarkService: benchmarkService,
    );
    _fetchParts();
  }

  Future<void> _fetchParts() async {
    try {
      final requirements = {
        'budget': 1000,
        'use_case': 'gaming',
        // Add other requirements
      };

      final recommendedParts = await aiService.getRecommendedParts(requirements);
      setState(() {
        parts = recommendedParts.map((p) => p.toJson()).toList();
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching parts: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parts List'),
        actions: [
          IconButton(
            icon: Icon(Icons.build),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ManualBuildScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.auto_awesome),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AutoBuildScreen()),
              );
            },
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: parts.length,
              itemBuilder: (context, index) {
                final part = parts[index];
                return ListTile(
                  title: Text(part['name']),
                  subtitle: Text('${part['price']} - ${part['type']}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PartDetailsScreen(part: part),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
