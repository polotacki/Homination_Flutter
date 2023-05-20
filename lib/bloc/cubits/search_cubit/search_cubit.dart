import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homaination_mobile/bloc/cubits/filter_cubit/filter_cubit.dart';
import 'package:homaination_mobile/bloc/cubits/home_cubit/home_cubit.dart';
import 'package:meta/meta.dart';

import '../../../model/filter.dart';
import '../../../model/services_model.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final List<ServicesModel> servicesModel;
  final searchCtrl = TextEditingController();
  List<ServicesModel> searchResults = [];

  SearchCubit({required this.servicesModel}) : super(SearchInitial()) {
    searchCtrl.addListener(() {
      searchQueryChanged(servicesModel);
    });
  }
  static SearchCubit get(context) => BlocProvider.of(context);
/*void appliiedFilters(filters,services){final filteredServices= services;
  for (var filter in filters) {
print(services);
    filteredServices.retainWhere((service) =>
    service.categories == filter.category &&
        service.location == filter.location &&
        service.price >= filter.minPrice &&
        service.price <= filter.maxPrice);
    searchResults = [];

    searchResults.addAll(filteredServices);
    for( var element in searchResults){
      print(element.title);
      emit(SearchResultsLoaded(filteredServices));
    }
  }
}*/
  void searchQueryChanged(services ) {

    final filteredServices = services
        .where((service) =>
    service.provider.toLowerCase().contains(searchCtrl.text.toLowerCase()) ||
        service.desc.toLowerCase().contains(searchCtrl.text.toLowerCase()) ||
        service.title.toLowerCase().contains(searchCtrl.text.toLowerCase()))
        .toList();


    searchResults = [];

    searchResults.addAll(filteredServices);

    emit(SearchResultsLoaded(filteredServices));
  }
}
