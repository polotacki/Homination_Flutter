part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginEmailChanged extends LoginState {
  final String email;

  LoginEmailChanged(this.email);
}

class LoginPasswordChanged extends LoginState {
  final String password;

  LoginPasswordChanged(this.password);
}

class LoginObscurePasswordChanged extends LoginState {}

class LoginLoading extends LoginState {}

class LoginError extends LoginState {
  final String error;

  LoginError(this.error);
}

class LoginSuccess extends LoginState {
  final UserModel loginModel;

  LoginSuccess(this.loginModel);
}
