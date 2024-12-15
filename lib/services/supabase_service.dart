import 'package:myapp/utils/api_constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final SupabaseClient client;

  SupabaseService()
      : client = Supabase.instance.client;

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