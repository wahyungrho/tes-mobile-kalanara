part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthLoginEvent extends AuthEvent {
  final String username;
  final String password;

  AuthLoginEvent(this.username, this.password);
}

final class AuthLogoutEvent extends AuthEvent {}

final class AuthCheckEvent extends AuthEvent {}
