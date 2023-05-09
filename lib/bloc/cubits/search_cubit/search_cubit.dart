import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../model/services_model.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  void searchQueryChanged(String query,servicesModel) {
    final filteredServices = servicesModel
        .where((service) =>
    service.provider.toLowerCase().contains(query.toLowerCase()) ||
        service.desc.toLowerCase().contains(query.toLowerCase()) ||
        service.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    emit(SearchResultsLoaded(filteredServices));
  }
}
