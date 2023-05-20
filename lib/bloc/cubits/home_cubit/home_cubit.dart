import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homaination_mobile/model/services_model.dart';
import 'package:homaination_mobile/shared/network/remote/http_helper.dart';
import 'package:meta/meta.dart';
import '../../../modules/search_page/search_page.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/local/cache_helper.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);
  List<ServicesModel> services = [];
  var profilePic=CacheHelper.getData(key: "profilePic");
  var searchCtrl = TextEditingController();

  void getServicesData() {
    emit(ServicesLoading());
    HttpHelper.getData(url: servicesEndPoint).then((response) {
      if (response.statusCode == 200) {
        print('API call successful, response body:');
        print(response.body);
        services =
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
void search(context,service,filters){
  searchCtrl.text;
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => SearchPage(
        query: searchCtrl.text,service: service
      ),
    ),
  );
  print(service);
  emit(SearchQueryState());
}
}
