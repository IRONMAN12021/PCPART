import 'package:flutter/material.dart';
import 'package:myapp/services/supabase_service.dart';
import 'package:supabase/supabase.dart';
import 'package:myapp/utils/api_constants.dart';
import 'package:myapp/utils/logger.dart';

void main() {
  final supabaseService = SupabaseService();

  runApp(MyApp(supabaseService: supabaseService));
}

class MyApp extends StatelessWidget {
  final SupabaseService supabaseService;

  MyApp({required this.supabaseService});

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

  HomeScreen({required this.supabaseService});

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

  Future<void> insertData(Map<String, dynamic> data) async {
    final response = await client
        .from('users') // Ensure this matches your Supabase table name
        .insert(data)
        .execute();

    if (response.error != null) {
      throw Exception('Failed to insert data: ${response.error!.message}');
    }
  }
}