part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class ServicesLoading extends HomeState {}
class favsSuccess extends HomeState {}
class ServicesError extends HomeState {
  final String error;

  ServicesError(this.error);
}

class ServicesSuccess extends HomeState {
  final List<ServicesModel> servicesModel;

  ServicesSuccess(this.servicesModel);
}
class RecommendedServicesLoading extends HomeState {}

class RecommendedServicesError extends HomeState {
  final String error;

  RecommendedServicesError(this.error);
}

class RecommendedServicesSuccess extends HomeState {
  final List<ServicesModel> servicesModel;

  RecommendedServicesSuccess(this.servicesModel);
}

class ReviewsLoading extends HomeState {}

class ReviewsError extends HomeState {
  final String error;
  ReviewsError(this.error);
}

class ReviewsSuccess extends HomeState {
  final List<Review> reviewModel;
  ReviewsSuccess(this.reviewModel);
}

class SearchQueryState extends HomeState {}

class AddFavoriteServiceLoading extends HomeState {}

class AddFavoriteServiceError extends HomeState {
  final String error;
  AddFavoriteServiceError(this.error);
}

class AddFavoriteServiceSuccess extends HomeState {}

class FavoriteLoading extends HomeState {}

class FavoriteError extends HomeState {
  final String error;
  FavoriteError(this.error);
}

class FavoriteSuccess extends HomeState {
  final List<ServicesModel> servicesModel;
  FavoriteSuccess(this.servicesModel);
}
