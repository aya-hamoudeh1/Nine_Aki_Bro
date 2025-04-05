part of 'authentication_cubit.dart';

@immutable
sealed class AuthenticationState {}

final class AuthenticationInitial extends AuthenticationState {}

/// Login
final class LoginSuccess extends AuthenticationState {}

final class LoginLoading extends AuthenticationState {}

final class LoginError extends AuthenticationState {
  final String message;
  LoginError(this.message);
}

/// Sign Up
final class SignUpSuccess extends AuthenticationState {}

final class SignUpLoading extends AuthenticationState {}

final class SignUpError extends AuthenticationState {
  final String message;
  SignUpError(this.message);
}

/// Google sign in / up
final class GoogleSignInSuccess extends AuthenticationState {}

final class GoogleSignInLoading extends AuthenticationState {}

final class GoogleSignInError extends AuthenticationState {}

/// Logout
final class LogoutSuccess extends AuthenticationState {}

final class LogoutLoading extends AuthenticationState {}

final class LogoutError extends AuthenticationState {}

/// PasswordReset
final class PasswordResetSuccess extends AuthenticationState {}

final class PasswordResetLoading extends AuthenticationState {}

final class PasswordResetError extends AuthenticationState {}