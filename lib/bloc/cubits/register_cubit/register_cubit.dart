import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../model/user_model.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote/http_helper.dart';
import '../../../shared/style/constants.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  static RegisterCubit get(context) => BlocProvider.of(context);
  UserModel? registerModel;
  void emailChanged(String email) {
    print(email);

    emit(RegisterEmailChanged(email));
  }

  void passwordChanged(String password) {
    print(password);

    emit(RegisterPasswordChanged(password));
  }

  bool passwordVisible = false;
  IconData suffixIcon = Icons.visibility_off;
  Color suffixColor = secondaryColor;
  void changePasswordVisibility() {
    passwordVisible = !passwordVisible;
    suffixIcon = passwordVisible ? Icons.visibility : Icons.visibility_off;
    suffixColor = passwordVisible ? Colors.blue : secondaryColor;
    emit(RegisterObscurePasswordChanged());
  }
  void register({
    required String name,
    required String username,
    required String password,
    required String email,
  }) {

    emit(RegisterLoading());

    HttpHelper.postData(
        url: registerEndPoint,
        data: {
          'name': name,
          'username': username,
          'email': email,
          'password': password,
        },
        headers: {'Content-Type': 'application/json'}
    ).then((response) {
      if (response.statusCode == 200) {
        print(response.body);
        registerModel = UserModel.fromJson(jsonDecode(response.body));

        emit(RegisterSuccess(registerModel!));
      } else {
        print(response.body);
        emit(RegisterError(response.body));
      }
    }).catchError((response) {
      print(response.toString());
      emit(RegisterError(response.toString()));
    });
  }
}
