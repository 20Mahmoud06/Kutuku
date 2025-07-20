part of 'auth_cubit.dart';

// Using Equatable to allow for easy state comparison
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

// Initial state, nothing has happened yet.
class AuthInitial extends AuthState {}

// State when an auth process (login, signup) is in progress.
class AuthLoading extends AuthState {}

// State when the user is successfully authenticated.
class Authenticated extends AuthState {
  final User user;

  const Authenticated(this.user);

  @override
  List<Object> get props => [user];
}

// State when an authentication attempt fails.
class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object> get props => [message];
}