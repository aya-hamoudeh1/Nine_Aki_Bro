import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());

  SupabaseClient client = Supabase.instance.client;

  /// Login
  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());
    try {
      await client.auth.signInWithPassword(password: password, email: email);
      emit(LoginSuccess());
    } on AuthException catch (e) {
      log(e.toString());
      emit(LoginError(e.message));
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }

  /// Sign Up
  Future<void> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    emit(SignUpLoading());
    try {
      await client.auth.signUp(password: password, email: email);
      emit(SignUpSuccess());
    } on AuthException catch (e) {
      log(e.toString());
      emit(SignUpError(e.message));
    } catch (e) {
      emit(SignUpError(e.toString()));
    }
  }

  /// Google Sign in/up
  GoogleSignInAccount? googleUser;
  Future<AuthResponse> googleSignIn() async {
    emit(GoogleSignInLoading());
    const webClientId =
        '659973953427-ecfuibhosf579o8vl2s9vb9r6i8aqor3.apps.googleusercontent.com';
    //const iosClientId = 'my-ios.apps.googleusercontent.com';

    final GoogleSignIn googleSignIn = GoogleSignIn(
      //clientId: iosClientId,
      serverClientId: webClientId,
    );
    googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      return AuthResponse();
    }
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null || idToken == null) {
      emit(GoogleSignInError());
      return AuthResponse();
      //throw 'No Access Token found.';
    }

    AuthResponse response = await client.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
    emit(GoogleSignInSuccess());
    return response;
  }

  /// Sign out
  Future<void> signOut() async {
    emit(LogoutLoading());
    try {
      await client.auth.signOut();
      emit(LogoutSuccess());
    } catch (e) {
      log(e.toString());
      emit(LogoutError());
    }
  }

  /// Reset Password
  Future<void> resetPassword({required String email}) async {
    emit(PasswordResetLoading());
    try {
      await client.auth.resetPasswordForEmail(email);
      emit(PasswordResetSuccess());
    } catch (e) {
      log(e.toString());
      emit(PasswordResetError());
    }
  }
}
