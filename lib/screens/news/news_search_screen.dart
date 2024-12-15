import 'package:flutter/material.dart';
import 'package:myapp/services/news_service.dart';
import 'package:myapp/widgets/news_card.dart';

class NewsSearchScreen extends StatefulWidget {
  const NewsSearchScreen({super.key});

  @override
  State<NewsSearchScreen> createState() => _NewsSearchScreenState();
}

class _NewsSearchScreenState extends State<NewsSearchScreen> {
  final _searchController = TextEditingController();
  final _newsService = NewsService();
  List<Map<String, dynamic>> _searchResults = [];
  bool _isLoading = false;
  String _error = '';

  Future<void> _performSearch(String query) async {
    if (query.isEmpty) {
      setState(() => _searchResults = []);
      return;
    }

    setState(() {
      _isLoading = true;
      _error = '';
    });

    try {
      final results = await _newsService.searchNews(query);
      setState(() {
        _searchResults = results;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to search news';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Search tech news...',
            border: InputBorder.none,
          ),
          onSubmitted: _performSearch,
        ),
      ),
      body: Column(
        children: [
          if (_isLoading)
            const LinearProgressIndicator(),
          if (_error.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                _error,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                return NewsCard(article: _searchResults[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
} 