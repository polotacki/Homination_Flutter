part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class ServicesLoading extends HomeState {}

class ServicesError extends HomeState {
  final String error;

  ServicesError(this.error);
}

class ServicesSuccess extends HomeState {
  final List<ServicesModel> servicesModel;

  ServicesSuccess(this.servicesModel);
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