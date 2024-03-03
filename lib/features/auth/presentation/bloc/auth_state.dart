part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoadingState extends AuthState{}

class SignedInState extends AuthState{
  final MyUser user;

  const SignedInState({required this.user});

  @override
  List<Object?> get props => [user];
}

class SignedUpState extends AuthState{}

class ForgotPasswordState extends AuthState{}

class UserUpdatedState extends AuthState{}

class AuthErrorState extends AuthState{
  final String errorMessage;

  const AuthErrorState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
