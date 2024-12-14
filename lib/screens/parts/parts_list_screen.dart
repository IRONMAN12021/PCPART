import 'package:flutter/material.dart';
import 'package:myapp/screens/parts/part_details_screen.dart';
import 'package:myapp/services/scraper_service.dart';
import 'package:myapp/services/amazon_service.dart';
import 'package:myapp/screens/build/auto_build/auto_build_screen.dart';
//import 'package:myapp/screens/build/auto_build/questions/budget.dart';
//import 'package:myapp/screens/build/auto_build/questions/use_case_screen.dart';
//import 'package:myapp/screens/build/auto_build/questions/sub_question_screen.dart';
//import 'package:myapp/screens/build/auto_build/auto_bild_summary_screen.dart';//
//import 'package:myapp/screens/build/build_comparison_screen.dart';
import 'package:myapp/screens/build/manual_build/manual_build_screen.dart';
//import 'package:myapp/screens/build/manual_build/manual_build_summary_screen.dart';
import 'package:myapp/widgets/part_card.dart';
import 'package:myapp/widgets/loading_indicator.dart';
//import 'package:myapp/widgets/error_display.dart';

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

  @override
  void initState() {
    super.initState();
    amazonService = AmazonService(scraperService: ScraperService(scraperFolderPath: 'path/to/scraper'));
    _fetchParts();
  }

  Future<void> _fetchParts() async {
    try {
      final fetchedParts = await amazonService.fetchParts();
      setState(() {
        parts = fetchedParts;
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
          ? const LoadingIndicator()
          : ListView.builder(
              itemCount: parts.length,
              itemBuilder: (context, index) {
                final part = parts[index];
                return PartCard(
                  name: part['name'],
                  price: part['price'],
                  type: part['type'],
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
