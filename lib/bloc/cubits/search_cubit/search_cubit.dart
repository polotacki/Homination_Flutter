import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../model/filter.dart';
import '../../../model/services_model.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final List<ServicesModel> servicesModel;
  final searchCtrl = TextEditingController();
  List<ServicesModel> searchResults = [];

  List<Filter> filters;

  SearchCubit({required this.servicesModel,required this.filters}) : super(SearchInitial()) {
    searchCtrl.addListener(() {
      searchQueryChanged(servicesModel,filters);
    });
  }

  static SearchCubit get(context) => BlocProvider.of(context);

  void searchQueryChanged(servicesModel,List<Filter> filters) {
   filters.forEach((element) {print("from cubit          "+ element.location);});
    final filteredServices = servicesModel
        .where((service) =>
    service.provider.toLowerCase().contains(searchCtrl.text.toLowerCase()) ||
        service.desc.toLowerCase().contains(searchCtrl.text.toLowerCase()) ||
        service.title.toLowerCase().contains(searchCtrl.text.toLowerCase()))
        .toList();
    for (var filter in filters) {
      filteredServices.retainWhere((service) =>
      service.categories == filter.category &&
          service.location == filter.location &&
          service.price >= filter.minPrice &&
          service.price <= filter.maxPrice);
    }
   searchResults = [];

   searchResults.addAll(filteredServices);

   emit(SearchResultsLoaded(filteredServices));
  }
}