part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final UserModel userModel;

  LoginSuccess(this.userModel);
}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure(this.error);
}
