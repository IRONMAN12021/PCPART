import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class NewsBookmarkService {
  static const String _bookmarksKey = 'news_bookmarks';
  final SharedPreferences _prefs;

  NewsBookmarkService(this._prefs);

  Future<List<Map<String, dynamic>>> getBookmarkedArticles() async {
    final bookmarksJson = _prefs.getString(_bookmarksKey);
    if (bookmarksJson != null) {
      final List<dynamic> bookmarks = json.decode(bookmarksJson);
      return bookmarks.cast<Map<String, dynamic>>();
    }
    return [];
  }

  Future<void> toggleBookmark(Map<String, dynamic> article) async {
    final bookmarks = await getBookmarkedArticles();
    final isBookmarked = bookmarks.any((a) => a['url'] == article['url']);

    if (isBookmarked) {
      bookmarks.removeWhere((a) => a['url'] == article['url']);
    } else {
      bookmarks.add({
        ...article,
        'bookmarkedAt': DateTime.now().toIso8601String(),
      });
    }

    await _prefs.setString(_bookmarksKey, json.encode(bookmarks));
  }

  Future<bool> isArticleBookmarked(String articleUrl) async {
    final bookmarks = await getBookmarkedArticles();
    return bookmarks.any((a) => a['url'] == articleUrl);
  }
} 