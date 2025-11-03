import 'package:flutter/material.dart';

import 'src/config/supabase_config.dart';
import 'src/services/supabase_service.dart';
import 'src/widgets/game_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inicializar Supabase
  try {
    await SupabaseService.initialize(
      url: SupabaseConfig.supabaseUrl,
      anonKey: SupabaseConfig.supabaseAnonKey,
    );
  } catch (e) {
    print('Error initializing Supabase: $e');
  }
  
  runApp(const GameApp());
}