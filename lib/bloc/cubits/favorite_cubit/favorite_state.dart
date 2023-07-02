part of 'favorite_cubit.dart';

@immutable
abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}
class FavoriteLoading extends FavoriteState {}

class FavoriteError extends FavoriteState {
  final String error;

  FavoriteError(this.error);
}

class FavoriteSuccess extends FavoriteState {
  final List<ServicesModel> servicesModel;

  FavoriteSuccess(this.servicesModel);
}

class FavoriteReviewsLoading extends FavoriteState {}

class FavoriteReviewsError extends FavoriteState {
  final String error;

  FavoriteReviewsError(this.error);
}

class FavoriteReviewsSuccess extends FavoriteState {
  final List<Review> reviewModel;

  FavoriteReviewsSuccess(this.reviewModel);
}
class AddFavoriteServiceLoading extends FavoriteState {}

class AddFavoriteServiceError extends FavoriteState {
  final String error;

  AddFavoriteServiceError(this.error);
}

class AddFavoriteServiceSuccess extends FavoriteState {
}