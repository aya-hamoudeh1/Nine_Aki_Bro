import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:nine_aki_bro/views/auth/logic/models/user_model.dart';
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
      await getUserData();
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
    required String name,
    required String email,
    required String password,
    required String phoneNumber,
    required String address,
    required String ageGroup,
    required Color? skinTone,
  }) async {
    emit(SignUpLoading());
    try {
      await client.auth.signUp(password: password, email: email);
      await addUserData(
        name: name,
        email: email,
        phoneNumber: phoneNumber,
        address: address,
        ageGroup: ageGroup,
        skinTone: skinTone!.value.toRadixString(16).padLeft(8, '0'),
      );
      await getUserData();
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
    await addUserData(
      name: googleUser!.displayName!,
      email: googleUser!.email,
      phoneNumber: '',
      address: '',
      ageGroup: '',
      skinTone: '',
    );
    await getUserData();
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

  ///  Add User data
  Future<void> addUserData({
    required String name,
    required String email,
    required String phoneNumber,
    required String address,
    required String ageGroup,
    required String skinTone,
  }) async {
    emit(UserDataAddedLoading());
    try {
      if (client.auth.currentUser != null) {
        log('User data to add: $name, $email, $phoneNumber, $address, $ageGroup, $skinTone');
        await client.from('users').upsert({
          'user_id': client.auth.currentUser!.id,
          'name': name,
          'email': email,
          'phone': phoneNumber,
          'address': address,
          'age_group': ageGroup,
          'skin_tone': skinTone,
        });
        emit(UserDataAddedSuccess());
      } else {
        emit(UserDataAddedError());
        log('User not authenticated');
      }
    } catch (e) {
      log('Error adding user data: $e');
      emit(UserDataAddedError());
    }
  }

  /// Get User Data
  UserDataModel? userDataModel;
  Future<void> getUserData() async {
    emit(GetUserDataLoading());
    try {
      final List<Map<String, dynamic>> data = await client
          .from('users')
          .select()
          .eq('user_id', client.auth.currentUser!.id);
      if (data.isEmpty) {
        emit(GetUserDataError());
        return;
      }
      userDataModel = UserDataModel(
        userId: data[0]['user_id'],
        name: data[0]['name'],
        email: data[0]['email'],
        phoneNumber: data[0]['phone'],
        address: data[0]['address'],
        ageGroup: data[0]['age_group'],
        skinTone: data[0]['skin_tone'],
      );
      emit(GetUserDataSuccess());
    } catch (e) {
      log(e.toString());
      emit(GetUserDataError());
    }
  }
}
