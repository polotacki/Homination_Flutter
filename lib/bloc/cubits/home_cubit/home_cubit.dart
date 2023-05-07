import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homaination_mobile/model/services_model.dart';
import 'package:homaination_mobile/shared/network/remote/http_helper.dart';
import 'package:meta/meta.dart';

import '../../../shared/components/constants.dart';
import '../../../shared/network/end_points.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);
  List<ServicesModel>? services;
  void getServicesData() {
    emit(ServicesLoading());
    HttpHelper.getData(url: servicesEndPoint).then((response) {
      if (response.statusCode == 200) {
        print('API call successful, response body:');
        print(response.body);
        List<ServicesModel> services =
        (jsonDecode(response.body) as List)
            .map((serviceJson) => ServicesModel.fromJson(serviceJson))
            .toList();
        print('Data processing successful, services:');
        print(services);
        emit(ServicesSuccess(services));
      } else {
        print('API call failed, response body:');
        print(response.body);
        emit(ServicesError(response.body));
      }
    }).catchError((error) {
      print('API call error:');
      print(error);
      emit(ServicesError(error.toString()));
    });
  }

}
