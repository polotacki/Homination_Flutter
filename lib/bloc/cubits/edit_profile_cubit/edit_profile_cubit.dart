import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homaination_mobile/model/user_model.dart';
import 'package:homaination_mobile/shared/network/end_points.dart';
import 'package:meta/meta.dart';

import '../../../shared/network/local/cache_helper.dart';
import '../../../shared/network/remote/http_helper.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(EditProfileInitial());

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  var id = CacheHelper.getData(key: "id");
  var token = CacheHelper.getData(key: 'Token');

  File? profilePicFile;
  String? encodedImage;

  Future<void> directUpdateImage(File? file) async {
    if (file == null) return;

    final fileBytes = await file.readAsBytes();
    final base64Image = base64Encode(fileBytes);

    profilePicFile = file;
    encodedImage = base64Image;
    print(base64Image);
    emit(EditProfilePictureState(base64Image));
  }

  void editProfile() {
    emit(EditProfileLoading());
    print("sharedprefrences :$token");
    HttpHelper.putData(url: editProfileEndPoint + id, data: {
      "userId": id,
      "profilePic": encodedImage,
      "name": nameController.text,
      "email": emailController.text,
      "password": passwordController.text
    }, headers: {
      'Content-Type': 'application/json',
      'Authorization': '$token',
      'Accept': 'application/json',
    }).then((response) {
      if (response.statusCode == 200) {
        print(response.body);
        CacheHelper.saveData(key: "profilePic", value: encodedImage);
        CacheHelper.saveData(key: "name", value: nameController.text);
        CacheHelper.saveData(key: "email", value: emailController.text);
        emit(EditProfileSuccess());
      } else {
        print(response.body);
        emit(EditProfileError(response.body));
      }
    }).catchError((response) {
      print(response.toString());
      emit(EditProfileError(response.toString()));
    });
  }
}
