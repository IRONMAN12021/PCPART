import 'package:flutter/material.dart';
import 'package:myapp/services/news_service.dart';
import 'package:myapp/widgets/news_card.dart';
import 'package:myapp/services/news_bookmark_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:myapp/screens/news/news_search_screen.dart';
import 'package:myapp/screens/news/bookmarked_news_screen.dart';
import 'package:myapp/widgets/news_category_filter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final NewsService _newsService = NewsService();
  late NewsBookmarkService _bookmarkService;
  List<Map<String, dynamic>> _news = [];
  bool _isLoading = true;
  String _error = '';
  String _selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    _initializeServices();
  }

  Future<void> _initializeServices() async {
    final prefs = await SharedPreferences.getInstance();
    _bookmarkService = NewsBookmarkService(prefs);
    _loadNews();
  }

  Future<void> _loadNews() async {
    try {
      setState(() {
        _isLoading = true;
        _error = '';
      });

      final news = await _newsService.getNewsByCategory(_selectedCategory);
      setState(() {
        _news = news;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to load news';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PC Builder'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NewsSearchScreen()),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.bookmark),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const BookmarkedNewsScreen()),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadNews,
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading && _news.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error.isNotEmpty && _news.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_error),
            ElevatedButton(
              onPressed: _loadNews,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadNews,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          _buildQuickActions(),
          NewsCategoryFilter(
            selectedCategory: _selectedCategory,
            onCategorySelected: (category) {
              setState(() => _selectedCategory = category);
              _loadNews();
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Latest Tech News',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (_isLoading)
                  const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
              ],
            ),
          ),
          if (_error.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                _error,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ..._news.map((article) => NewsCard(
            article: article,
            onBookmarkChanged: (isBookmarked) async {
              if (isBookmarked) {
                await _bookmarkService.toggleBookmark(article);
              }
            },
          )),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildActionButton(
                  icon: Icons.build,
                  label: 'Build PC',
                  onPressed: () => Navigator.pushNamed(context, '/build_pc'),
                ),
                _buildActionButton(
                  icon: Icons.compare_arrows,
                  label: 'Compare',
                  onPressed: () => Navigator.pushNamed(context, '/comparison'),
                ),
                _buildActionButton(
                  icon: Icons.list,
                  label: 'Parts',
                  onPressed: () => Navigator.pushNamed(context, '/parts_list'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Column(
      children: [
        IconButton(
          icon: Icon(icon),
          onPressed: onPressed,
          iconSize: 32,
        ),
        Text(label),
      ],
    );
  }
}
