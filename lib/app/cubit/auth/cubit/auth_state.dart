part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthUserAuthenticated extends AuthState {
  final String uid;

  AuthUserAuthenticated({required this.uid});

  @override
  List<Object> get props => [uid];
}

class AuthUserNotAuthenticated extends AuthState {
  @override
  List<Object> get props => [];
}
