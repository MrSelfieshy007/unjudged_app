import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  // Make sure to update these with your Supabase project credentials!
  static const String _supabaseUrl = 'https://znfmlmtleocnnaukgjhp.supabase.co';
  static const String _supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InpuZm1sbXRsZW9jbm5hdWtnamhwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTIyNDc3ODMsImV4cCI6MjA2NzgyMzc4M30.ZFwixiU3O4t6VrTiaJ2DYtftFQETL4iaQAjOkU0UAv8';

  static Future<void> initialize() async {
    await Supabase.initialize(
      url: _supabaseUrl,
      anonKey: _supabaseAnonKey,
    );
  }

  static SupabaseClient get client => Supabase.instance.client;

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      await client.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: 'io.supabase.unjudgednow://login-callback/',
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error signing in with Google: $e')),
      );
    }
  }
}
