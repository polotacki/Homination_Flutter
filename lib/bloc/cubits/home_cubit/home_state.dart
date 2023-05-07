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
