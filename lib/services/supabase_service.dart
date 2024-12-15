import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final SupabaseClient client;

  SupabaseService()
      : client = Supabase.instance.client;

  Future<void> insertData(Map<String, dynamic> data) async {
    final response = await client
        .from('users') // Ensure this matches your Supabase table name
        .insert(data)
        .select();

    if (response.status != 201) {
      throw Exception('Failed to insert data');
    }
  }
}