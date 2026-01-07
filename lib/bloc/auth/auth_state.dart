part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final String uid;

  AuthAuthenticated(this.uid);
}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}

