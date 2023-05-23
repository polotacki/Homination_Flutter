import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/user_model.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote/http_helper.dart';
import '../../../shared/style/constants.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);
  UserModel? loginModel;
  void emailChanged(String email) {
    print(email);

    emit(LoginEmailChanged(email));
  }

  void passwordChanged(String password) {
    print(password);

    emit(LoginPasswordChanged(password));
  }

  bool passwordVisible = false;
  IconData suffixIcon = Icons.visibility;
  Color suffixColor = Colors.blue;

  void changePasswordVisibility() {
    passwordVisible = !passwordVisible;
    suffixIcon = passwordVisible ? Icons.visibility : Icons.visibility_off;
    suffixColor = passwordVisible ? Colors.blue : secondaryColor;
    emit(LoginObscurePasswordChanged());
  }

  void login({
    required String username,
    required String password,
  }) {
    emit(LoginLoading());
    // Make login API call, e.g. using http package
    HttpHelper.postData(
      url: loginEndPoint,
      data: {
        'username': username,
        'password': password,
      },
      headers: {'Content-Type': 'application/json'}
    ).then((response) {
      if (response.statusCode == 200) {
        print(response.body);
        loginModel = UserModel.fromJson(jsonDecode(response.body));

        emit(LoginSuccess(loginModel!));
      } else {
        print(response.body);
        emit(LoginError(response.body));
      }
    }).catchError((response) {
      print(response.toString());
      emit(LoginError(response.toString()));
    });
  }
}
