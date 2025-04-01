part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final String? email;

  const AuthAuthenticated({this.email});

  @override
  List<Object> get props => [email ?? ''];
}

class AuthUnauthenticated extends AuthState {}

class AuthFailure extends AuthState {
  final String errorMessage;

  const AuthFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
