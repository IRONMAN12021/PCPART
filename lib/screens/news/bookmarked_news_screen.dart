import 'package:flutter/material.dart';
import 'package:myapp/services/news_bookmark_service.dart';
import 'package:myapp/widgets/news_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarkedNewsScreen extends StatefulWidget {
  const BookmarkedNewsScreen({super.key});

  @override
  State<BookmarkedNewsScreen> createState() => _BookmarkedNewsScreenState();
}

class _BookmarkedNewsScreenState extends State<BookmarkedNewsScreen> {
  late NewsBookmarkService _bookmarkService;
  List<Map<String, dynamic>> _bookmarkedArticles = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeBookmarkService();
  }

  Future<void> _initializeBookmarkService() async {
    final prefs = await SharedPreferences.getInstance();
    _bookmarkService = NewsBookmarkService(prefs);
    await _loadBookmarks();
  }

  Future<void> _loadBookmarks() async {
    setState(() => _isLoading = true);
    final articles = await _bookmarkService.getBookmarkedArticles();
    setState(() {
      _bookmarkedArticles = articles;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarked News'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _bookmarkedArticles.isEmpty
              ? const Center(child: Text('No bookmarked articles'))
              : ListView.builder(
                  itemCount: _bookmarkedArticles.length,
                  itemBuilder: (context, index) {
                    return NewsCard(article: _bookmarkedArticles[index]);
                  },
                ),
    );
  }
} 