import 'package:supabase/supabase.dart';
import 'package:myapp/api/api_constants.dart';

class SupabaseService {
  final SupabaseClient client;

  SupabaseService()
      : client = SupabaseClient(ApiConstants.supabaseUrl, ApiConstants.supabaseKey);

  Future<void> insertData(Map<String, dynamic> data) async {
    try {
      await client
          .from('users')
          .insert(data)
          // ignore: deprecated_member_use
          .execute();
    } catch (e) {
      throw Exception('Failed to insert data: $e');
    }
  }
}