// ignore_for_file: unused_import

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:myapp/models/pc_part.dart'; // Import your model for PC Part data
import 'package:shared_preferences/shared_preferences.dart'; // For caching purposes
import 'package:myapp/services/gemini_service.dart';
import 'package:myapp/services/power_tracker.dart';
import 'package:myapp/services/compatability_checker.dart';
import 'package:myapp/utils/api_constants.dart';

class ApiService {
  static const String baseUrl =
      "http://your-backend-url.com/api"; // Backend URL
  static const String geminiApiUrl =
      "https://gemini-api.example.com"; // Example Gemini API
  static const String pcPartPickerUrl =
      "https://pcpartpicker.com/api"; // Example PCPartPicker API

  final GeminiService _geminiService;
  final PowerTracker _powerTracker;
  final CompatibilityChecker _compatibilityChecker;

  ApiService({
    GeminiService? geminiService,
    PowerTracker? powerTracker,
    CompatibilityChecker? compatibilityChecker,
  }) : 
    _geminiService = geminiService ?? GeminiService(
      baseUrl: ApiConstants.geminiBaseUrl,
      apiKey: ApiConstants.geminiApiKey,
    ),
    _powerTracker = powerTracker ?? PowerTracker(),
    _compatibilityChecker = compatibilityChecker ?? CompatibilityChecker();

  // Cache mechanism to avoid redundant requests
  Future<String?> _getCache(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<void> _setCache(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  // Get the list of available PC parts from the backend (to be integrated with your database)
  Future<List<PCPart>> fetchPcParts() async {
    String? cachedData = await _getCache('pcPartsList');
    if (cachedData != null) {
      // If data is cached, return the cached data
      List<dynamic> data = json.decode(cachedData);
      return data.map((item) => PCPart.fromJson(item)).toList();
    }

    try {
      final response = await http.get(Uri.parse('$baseUrl/pcparts'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<PCPart>? parts = data.map((item) => PCPart.fromJson(item)).cast<PCPart>().toList();
        // Cache the response for future use
        _setCache('pcPartsList', json.encode(data));
        return parts;
      } else {
        throw Exception('Failed to load PC parts');
      }
    } catch (error) {
      throw Exception('Error fetching PC parts: $error');
    }
  }

  // Fetch parts from Gemini AI based on user's preferences
  Future<List<PCPart>> getSuggestedParts(Map<String, dynamic> preferences) async {
    return _geminiService.getSuggestedParts(preferences);
  }

  // Fetch part details from PCPartPicker API
  Future<Map<String, dynamic>> getPartDetailsFromPCPartPicker(
      String partId) async {
    try {
      final response =
          await http.get(Uri.parse('$pcPartPickerUrl/parts/$partId'));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to fetch part details from PCPartPicker');
      }
    } catch (error) {
      throw Exception('Error fetching part details from PCPartPicker: $error');
    }
  }

  // Save the selected parts list to the backend for building a PC
  Future<void> saveBuild(List<PCPart> selectedParts) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/saveBuild'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(
            {'parts': selectedParts.map((part) => part.toJson()).toList()}),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to save build');
      }
    } catch (error) {
      throw Exception('Error saving build: $error');
    }
  }

  // Get user profile data (including saved builds, preferences)
  Future<Map<String, dynamic>> getUserProfile(String userId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/user/$userId'));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to fetch user profile');
      }
    } catch (error) {
      throw Exception('Error fetching user profile: $error');
    }
  }

  // Update user profile (e.g., change username, email, preferences)
  Future<void> updateUserProfile(
      String userId, Map<String, dynamic> updatedData) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/user/$userId'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(updatedData),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update user profile');
      }
    } catch (error) {
      throw Exception('Error updating user profile: $error');
    }
  }

  // Compatibility Check API for PC parts (e.g., CPU, Motherboard, RAM compatibility)
  Future<Map<String, dynamic>> checkCompatibility(Map<String, String> selectedParts) async {
    return _compatibilityChecker.checkCompatibility(selectedParts);
  }

  // Power Usage Tracker (sum of TDP values from selected parts)
  Future<double> calculatePowerUsage(List<PCPart> selectedParts) async {
    return _powerTracker.calculateTotalPower(selectedParts);
  }

  // Fetch all recommended build methods (e.g., automatic or manual builds) from backend
  Future<List<Map<String, dynamic>>> getRecommendedBuildMethods() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/buildMethods'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data);
      } else {
        throw Exception('Failed to load recommended build methods');
      }
    } catch (error) {
      throw Exception('Error fetching recommended build methods: $error');
    }
  }

  // Update and cache user preferences (such as theme, notifications, etc.)
  Future<void> updateUserPreferences(
      String userId, Map<String, dynamic> preferences) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/user/$userId/preferences'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(preferences),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update user preferences');
      }
      // Cache the preferences locally after updating
      _setCache('userPreferences', json.encode(preferences));
    } catch (error) {
      throw Exception('Error updating user preferences: $error');
    }
  }

  // Get user preferences from cache if available
  Future<Map<String, dynamic>?> getUserPreferencesFromCache() async {
    String? cachedPreferences = await _getCache('userPreferences');
    if (cachedPreferences != null) {
      return json.decode(cachedPreferences);
    }
    return null;
  }
}
