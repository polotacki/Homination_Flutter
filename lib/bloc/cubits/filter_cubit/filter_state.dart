
part of 'filter_cubit.dart';



@immutable
abstract class FilterState {}

class FilterInitial extends FilterState {}

class FilterCategoryChanged extends FilterState {
  final String category;

  FilterCategoryChanged(this.category);
}

class FilterLocationChanged extends FilterState {
  final String location;

  FilterLocationChanged(this.location);
}

class FilterMinPriceChanged extends FilterState {
  final double minPrice;

  FilterMinPriceChanged(this.minPrice);
}

class FilterMaxPriceChanged extends FilterState {
  final double maxPrice;

  FilterMaxPriceChanged(this.maxPrice);
}

class FilterApply extends FilterState {}
class FilterUpdate extends FilterState {
  final List<ServicesModel> filterdServices;

  FilterUpdate(this.filterdServices);

  @override
  List<Object> get props => [filterdServices];
}