import 'package:supabase/supabase.dart';
import 'package:myapp/api_constants.dart';

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