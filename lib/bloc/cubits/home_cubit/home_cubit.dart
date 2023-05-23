import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homaination_mobile/model/services_model.dart';
import 'package:homaination_mobile/shared/network/remote/http_helper.dart';
import 'package:meta/meta.dart';
import '../../../model/review_model.dart';
import '../../../modules/search_page/search_page.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/local/cache_helper.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);
  List<ServicesModel> services = [];
  List<Review> reviews=[];
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
        services.forEach((element) {print(element.location);});
        getReviewData(services);

        emit(ServicesSuccess(services));

      }
      else
      {
        print('API call failed, response body:');
        print(response.body);

        emit(ServicesError(response.body));
      }
    }
    ).catchError((error)
    {
      print('API call error:');
      print(error);
      emit(ServicesError(error.toString()));
    });
  }

  void getReviewData(List<ServicesModel> services) {

    emit(ReviewsLoading());
    int responseCount = 0; // Counter variable to keep track of responses

    for (var service in services) {
      HttpHelper.getData(url: reviewEndPoint + service.provider).then((response) {
        if (response.statusCode == 200) {
          print('API call successful, response body:');
          print(response.body);
          List<dynamic> jsonData = jsonDecode(response.body);
          List<Review> serviceReviews = jsonData.map((json) => Review.fromJson(json)).toList();

          // Check if the provider of service is the same as the provider of review
          serviceReviews = serviceReviews.where((review) => review.providerName == service.provider).toList();

          // Add the filtered reviews to the service object
          service.reviews = serviceReviews;

          responseCount++; // Increment the response counter

          if (responseCount == services.length) { // Check if all requests have been completed
            print('Data processing successful, services:');
            print(reviews);
            emit(ReviewsSuccess(reviews));
          }
        } else {
          print('API call failed, response body:');
          print(response.body);
        emit(ReviewsError(response.body));
      }
      }).catchError((error) {
        print('API call error:');
        print(error);
        emit(ReviewsError(error.toString()));
      });
    }
  }
void search(context,service,filter){
  searchCtrl.text;
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => SearchPage(
        query: searchCtrl.text,service: service ,filter:filter
      ),
    ),
  );
  print(service);
  emit(SearchQueryState());
}
}
