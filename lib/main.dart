// ignore_for_file: avoid_print, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:myapp/utils/api_constants.dart';

void main() {
  final supabaseService = SupabaseService();

  runApp(MyApp(supabaseService: supabaseService));
}

class MyApp extends StatelessWidget {
  final SupabaseService supabaseService;

  const MyApp({super.key, required this.supabaseService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: HomeScreen(supabaseService: supabaseService),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final SupabaseService supabaseService;

  const HomeScreen({super.key, required this.supabaseService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            try {
              final data = await supabaseService.fetchData();
              print('Data: $data');
            } catch (e) {
              print('Error: $e');
            }
          },
          child: Text('Fetch Data'),
        ),
      ),
    );
  }
}

class SupabaseService {
  final SupabaseClient client;

  SupabaseService()
      : client = SupabaseClient(ApiConstants.supabaseUrl, ApiConstants.supabaseKey);

  Future<List<Map<String, dynamic>>> fetchData() async {
    try {
      final response = await client
          .from('users')
          .select()
          .execute();
      
      return (response.data as List).cast<Map<String, dynamic>>();
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }

  Future<void> insertData(Map<String, dynamic> data) async {
    try {
      await client
          .from('users')
          .insert(data)
          .execute();
    } catch (e) {
      throw Exception('Failed to insert data: $e');
    }
  }
}