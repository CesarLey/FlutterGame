import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static SupabaseClient? _client;

  static Future<void> initialize({
    required String url,
    required String anonKey,
  }) async {
    await Supabase.initialize(
      url: url,
      anonKey: anonKey,
    );
    _client = Supabase.instance.client;
  }

  static SupabaseClient get client {
    if (_client == null) {
      throw Exception('Supabase not initialized. Call initialize() first.');
    }
    return _client!;
  }

  // Guardar puntuación
  static Future<void> saveScore({
    required String playerName,
    required int score,
  }) async {
    try {
      await client.from('scores').insert({
        'player_name': playerName,
        'score': score,
        'created_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      print('Error saving score: $e');
      rethrow;
    }
  }

  // Obtener top 5 puntuaciones
  static Future<List<Map<String, dynamic>>> getTopScores({int limit = 5}) async {
    try {
      final response = await client
          .from('scores')
          .select()
          .order('score', ascending: false)
          .limit(limit);
      
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      print('Error getting top scores: $e');
      return [];
    }
  }
}
