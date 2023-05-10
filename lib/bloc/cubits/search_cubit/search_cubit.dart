import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

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

  void searchQueryChanged(servicesModel) {

    final filteredServices = servicesModel
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
