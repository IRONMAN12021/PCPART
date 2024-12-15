import 'package:flutter/material.dart';
import 'package:myapp/services/amazon_service.dart';
import 'package:myapp/services/scraper_service.dart';
import 'package:myapp/screens/build/auto_build/auto_build_screen.dart';
import 'package:myapp/screens/build/manual_build/manual_build_screen.dart';
import 'package:myapp/screens/parts/part_details_screen.dart';

class PartsListScreen extends StatefulWidget {
  const PartsListScreen({super.key});
  
  @override
  _PartsListScreenState createState() => _PartsListScreenState();
}

class _PartsListScreenState extends State<PartsListScreen> {
  late AmazonService amazonService;
  List<Map<String, dynamic>> parts = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    amazonService = AmazonService(scraperService: ScraperService());
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
            onPressed: onTapManualBuild,
          ),
          IconButton(
            icon: Icon(Icons.auto_awesome),
            onPressed: onTapAutoBuild,
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: parts.length,
              itemBuilder: (context, index) {
                final part = parts[index];
                return ListTile(
                  title: Text(part['name']),
                  subtitle: Text('Price: \$${part['price']}'),
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

  onTapManualBuild() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ManualBuildScreen()),
    );
  }

  onTapAutoBuild() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AutoBuildScreen()),
    );
  }
}
