import 'dart:convert';
import 'dart:typed_data';

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
  List<ServicesModel> recommendedServices = [];
  List<Review> reviews = [];
  var id = CacheHelper.getData(key: "id");
  var searchCtrl = TextEditingController();
  var base64String = CacheHelper.getData(key: "profilePic");
  List<ServicesModel> favoriteServices = [];
  List<bool> favs = [];

  void getFavoriteServicesData() {
    emit(FavoriteLoading());
    favs = [];

    HttpHelper.getData(url: servicesEndPoint + "$id/favorite").then((response) {
      if (response.statusCode == 200) {
        //print('API call successful, response body:');
        //print(response.body);
        favoriteServices = (jsonDecode(response.body) as List)
            .map((serviceJson) => ServicesModel.fromJson(serviceJson))
            .toList();

        //print('Data processing successful, services:');
        favoriteServices.forEach((element) {
          print(element.location);
        });

        emit(FavoriteSuccess(favoriteServices));
      } else {
        //print('API call failed, response body:');
        //print(response.body);

        emit(FavoriteError(response.body));
      }
    }).catchError((error) {
      //print('API call error:');
      //print(error);
      emit(FavoriteError(error.toString()));
    });
  }

  void getServicesData() {
    emit(ServicesLoading());

    HttpHelper.getData(url: servicesEndPoint).then((response) {
      if (response.statusCode == 200) {
        //print('API call successful, response body:');
        //print(response.body);
        services = (jsonDecode(response.body) as List)
            .map((serviceJson) => ServicesModel.fromJson(serviceJson))
            .toList();

        getReviewData(services);

        emit(ServicesSuccess(services));

      } else {
        // print('API call failed, response body:');
        // print(response.body);

        emit(ServicesError(response.body));
      }
    }).catchError((error) {
      //  print('API call error:');
      //  print(error);
      emit(ServicesError(error.toString()));
    });
  }

  void getRecommendedServicesData() {
    emit(RecommendedServicesLoading());

    HttpHelper.getData(
            url: recommendedServicesEndPoint +
                "Desing And Planing?provider=naser&lat=90&long=90")
        .then((response) {
      if (response.statusCode == 200) {
        //     print('API call successful, response body:');
        //   print(response.body);
        recommendedServices = (jsonDecode(response.body) as List)
            .map((serviceJson) => ServicesModel.fromJson(serviceJson))
            .toList();

        //   print('Data processing successful, services:');
        recommendedServices.forEach((element) {
          print(element.location);
        });
        getReviewData(recommendedServices);

        emit(RecommendedServicesSuccess(recommendedServices));
      } else {
        //  print('API call failed, response body:');
        //  print(response.body);

        emit(RecommendedServicesError(response.body));
      }
    }).catchError((error) {
      // print('API call error:');
      //print(error);
      emit(RecommendedServicesError(error.toString()));
    });
  }

  void getReviewData(List<ServicesModel> services) {
    emit(ReviewsLoading());
    int responseCount = 0; // Counter variable to keep track of responses

    for (var service in services) {
      HttpHelper.getData(url: reviewEndPoint + service.provider)
          .then((response) {
        if (response.statusCode == 200) {
          //    print('API call successful, response body:');
          //    print(response.body);
          List<dynamic> jsonData = jsonDecode(response.body);
          List<Review> serviceReviews =
              jsonData.map((json) => Review.fromJson(json)).toList();

          // Check if the provider of service is the same as the provider of review
          serviceReviews = serviceReviews
              .where((review) => review.providerName == service.provider)
              .toList();

          // Add the filtered reviews to the service object
          service.reviews = serviceReviews;

          responseCount++; // Increment the response counter

          if (responseCount == services.length) {
            // Check if all requests have been completed
            //      print('Data processing successful, services:');
            //       print(reviews);
            emit(ReviewsSuccess(reviews));
            services.forEach((service) {
              bool isFavorite = false;
              favoriteServices.forEach((favService) {
                if (service.id == favService.id) {
                  isFavorite = true;
                  return;
                }
              });
              favs.add(isFavorite);
            });
            emit(favsSuccess());

          }
        } else {
          //    print('API call failed, response body:');
          //    print(response.body);
          emit(ReviewsError(response.body));
        }
      }).catchError((error) {
        //  print('API call error:');
        //   print(error);
        emit(ReviewsError(error.toString()));
      });
    }
  }

  void search(context, service, filter) {
    searchCtrl.text;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchPage(
            favs: HomeCubit.get(context).favs,
            query: searchCtrl.text,
            service: service,
            filter: filter),
      ),
    );
    // print(service);
    emit(SearchQueryState());
  }

  void addFavoriteService({
    required String serviceId,
  }) {
    emit(AddFavoriteServiceLoading());

    HttpHelper.postData(url: addFavoriteServiceEndPoint, data: {
      'userId': id,
      'serviceId': serviceId,
    }, headers: {
      'Content-Type': 'application/json'
    }).then((response) {
      if (response.statusCode == 200) {
        //     print(response.body);
        getFavoriteServicesData();
getServicesData();
        emit(AddFavoriteServiceSuccess());
      } else {
        //     print(response.body);
        emit(AddFavoriteServiceError(response.body));
      }
    }).catchError((response) {
      //   print(response.toString());
      emit(AddFavoriteServiceError(response.toString()));
    });
  }
}
