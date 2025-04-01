import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  /// Sign in with email and password
  Future<AuthResponse> signInWithEmailPassword(
      String email, String password) async {
    try {
      return await _supabase.auth
          .signInWithPassword(email: email, password: password);
    } on AuthException catch (e) {
      throw Exception(e.message);
    }
  }

  /// Sign up with email and password
  Future<AuthResponse> signUpWithEmailPassword(String email, String password,
      {String? firstName, String? lastName}) async {
    try {
      return await _supabase.auth.signUp(email: email, password: password);
    } on AuthException catch (e) {
      throw Exception(e.message);
    }
  }

  /// Sign out
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  /// Get user email
  String? getCurrentUserEmail() {
    final session = _supabase.auth.currentSession;
    final user = session?.user;
    return user?.email;
  }
}
