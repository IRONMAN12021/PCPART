import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//import 'package:url_launcher/url_launcher.dart';
import 'package:myapp/screens/news/news_detail_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:myapp/services/news_bookmark_service.dart';

class NewsCard extends StatefulWidget {
  final Map<String, dynamic> article;
  final Function(bool)? onBookmarkChanged;

  const NewsCard({
    super.key,
    required this.article,
    this.onBookmarkChanged,
  });

  @override
  State<NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  late NewsBookmarkService _bookmarkService;
  bool _isBookmarked = false;

  @override
  void initState() {
    super.initState();
    _initializeBookmarkService();
  }

  Future<void> _initializeBookmarkService() async {
    final prefs = await SharedPreferences.getInstance();
    _bookmarkService = NewsBookmarkService(prefs);
    _checkBookmarkStatus();
  }

  Future<void> _checkBookmarkStatus() async {
    final isBookmarked = await _bookmarkService.isArticleBookmarked(widget.article['url']);
    setState(() => _isBookmarked = isBookmarked);
  }

  Future<void> _toggleBookmark() async {
    await _bookmarkService.toggleBookmark(widget.article);
    await _checkBookmarkStatus();
  }

  @override
  Widget build(BuildContext context) {
    final publishedAt = DateTime.parse(widget.article['publishedAt']);
    final formattedDate = DateFormat('MMM d, yyyy').format(publishedAt);

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewsDetailScreen(article: widget.article),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.article['urlToImage'] != null)
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                child: Image.network(
                  widget.article['urlToImage'],
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const SizedBox(
                    height: 200,
                    child: Center(child: Icon(Icons.error)),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.article['title'],
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.article['description'] ?? '',
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.article['source']['name'],
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        formattedDate,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(_isBookmarked ? Icons.bookmark : Icons.bookmark_border),
                    onPressed: _toggleBookmark,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 