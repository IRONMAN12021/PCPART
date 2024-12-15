import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class NewsDetailScreen extends StatelessWidget {
  final Map<String, dynamic> article;

  const NewsDetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final publishedAt = DateTime.parse(article['publishedAt']);
    final formattedDate = DateFormat('MMMM d, yyyy').format(publishedAt);

    return Scaffold(
      appBar: AppBar(
        title: Text(article['source']['name']),
        actions: [
          IconButton(
            icon: const Icon(Icons.open_in_browser),
            onPressed: () => _launchUrl(article['url']),
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () => _shareArticle(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article['urlToImage'] != null)
              Image.network(
                article['urlToImage'],
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const SizedBox(
                  height: 250,
                  child: Center(child: Icon(Icons.error)),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article['title'],
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Published on $formattedDate',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  if (article['author'] != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      'By ${article['author']}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                  const SizedBox(height: 16),
                  Text(
                    article['description'] ?? '',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  if (article['content'] != null) ...[
                    const SizedBox(height: 16),
                    Text(
                      article['content'],
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () => _launchUrl(article['url']),
                    icon: const Icon(Icons.read_more),
                    label: const Text('Read Full Article'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  void _shareArticle() {
    // Implement sharing functionality
  }
} 