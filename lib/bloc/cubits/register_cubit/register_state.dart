part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}
class RegisterEmailChanged extends RegisterState {
  final String email;

  RegisterEmailChanged(this.email);
}

class RegisterPasswordChanged extends RegisterState {
  final String password;

  RegisterPasswordChanged(this.password);
}

class RegisterObscurePasswordChanged extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterError extends RegisterState {
  final String error;

  RegisterError(this.error);
}

class RegisterSuccess extends RegisterState {
  final UserModel registerModel;

  RegisterSuccess(this.registerModel);
}