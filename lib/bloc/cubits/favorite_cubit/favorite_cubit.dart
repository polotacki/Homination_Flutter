import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../model/review_model.dart';
import '../../../model/services_model.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../../shared/network/remote/http_helper.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());
  static FavoriteCubit get(context) => BlocProvider.of(context);
  List<ServicesModel> favoriteServices = [];
  List<Review> reviews=[];
  var id=CacheHelper.getData(key: "id");
  void getFavoriteServicesData() {
    print(id);

    emit(FavoriteLoading());

    HttpHelper.getData(url: servicesEndPoint+"$id/favorite").then((response) {

      if (response.statusCode == 200) {
        print('API call successful, response body:');
        print(response.body);
        favoriteServices =
            (jsonDecode(response.body) as List)
                .map((serviceJson) => ServicesModel.fromJson(serviceJson))
                .toList();

        print('Data processing successful, services:');
        favoriteServices.forEach((element) {print(element.location);});
        getReviewData(favoriteServices);

        emit(FavoriteSuccess(favoriteServices));

      }
      else
      {
        print('API call failed, response body:');
        print(response.body);

        emit(FavoriteError(response.body));
      }
    }
    ).catchError((error)
    {
      print('API call error:');
      print(error);
      emit(FavoriteError(error.toString()));
    });
  }

  void getReviewData(List<ServicesModel> services) {

    emit(FavoriteReviewsLoading());
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
            emit(FavoriteReviewsSuccess(reviews));
          }
        } else {
          print('API call failed, response body:');
          print(response.body);
          emit(FavoriteReviewsError(response.body));
        }
      }).catchError((error) {
        print('API call error:');
        print(error);
        emit(FavoriteReviewsError(error.toString()));
      });
    }
  }

  void deleteFavoriteService({

    required String serviceId,

  }) {

    emit(AddFavoriteServiceLoading());

    HttpHelper.deleteData(
        url: deleteFavoriteServiceEndPoint,
        data: {
          'userId': id,
          'serviceId': serviceId,
        },
        headers: {'Content-Type': 'application/json'}
    ).then((response) {
      if (response.statusCode == 200) {
        print(response.body);


        emit(DeleteFavoriteServiceSuccess());
        getFavoriteServicesData();
      } else {
        print(response.body);
        emit(AddFavoriteServiceError(response.body));
      }
    }).catchError((response) {
      print(response.toString());
      emit(AddFavoriteServiceError(response.toString()));
    });
  }
}
