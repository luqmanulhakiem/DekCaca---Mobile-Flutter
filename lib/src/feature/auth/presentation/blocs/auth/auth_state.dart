part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccessLogout extends AuthState {}

final class AuthSuccessLogin extends AuthState {}

final class AuthFailure extends AuthState {
  final String error;

  AuthFailure({required this.error});
}
