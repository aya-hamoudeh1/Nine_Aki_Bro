part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  List<Object> get props => [];
}

class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  const SignInRequested({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class SignUpRequested extends AuthEvent {
  final String email;
  final String password;
  final String? firstName;
  final String? lastName;

  const SignUpRequested({required this.email, required this.password, this.firstName, this.lastName});

  @override
  List<Object> get props => [email, password, firstName ?? '', lastName ?? ''];
}

class SignOutRequested extends AuthEvent {}

class AuthCheckRequested extends AuthEvent {} // حدث للتحقق من حالة المصادقة عند بدء التطبيق