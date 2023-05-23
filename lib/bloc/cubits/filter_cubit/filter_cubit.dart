import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homaination_mobile/bloc/cubits/home_cubit/home_cubit.dart';

import '../../../model/filter.dart';
import '../../../model/services_model.dart';
import '../search_cubit/search_cubit.dart';

part 'filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  FilterCubit() : super(FilterInitial());

  static FilterCubit get(context) => BlocProvider.of(context);

  String? selectedCategory ;
  String? selectedLocation ;
  final List<String> searchCategories = [


    'Foundation Builder',
    'Interior Designers and Decorators',

  ];
  final List<String> searchLocations = [
    'cairo',
    'Giza',
    '6th of October',
    'El tagamoa Elkhames',
    'El Shorouk',
    'El Nozha',
    'El Zahraa',
    'Heliopolis',
    'Maadi',
    'Nasr City',
    'New Cairo',
    'Zayed'
  ];

  List<Filter> filters = [];

  TextEditingController searchTextEditingController = TextEditingController();

  TextEditingController locationTextEditingController = TextEditingController();
  TextEditingController minPriceTextEditingController = TextEditingController();
  TextEditingController maxPriceTextEditingController = TextEditingController();

  void updateCategory(String category) {
    selectedCategory = category;
    print(selectedCategory);
    emit(FilterCategoryChanged(category));
  }

  void updateLocation(String location) {
    selectedLocation = location;
    emit(FilterLocationChanged(location));
  }

  void updateMinPrice(String minPrice) {
    var selectedminPrice = double.tryParse(minPrice) ?? 50.0;
    emit(FilterMinPriceChanged(selectedminPrice));
  }

  void updateMaxPrice(String maxPrice) {
    var selectedMaxPrice = double.tryParse(maxPrice) ?? 50.0;
    emit(FilterMaxPriceChanged(selectedMaxPrice));
  }

  void applyFilters() {

    // Create a new Filter object with the selected filters
    final filter = Filter(
      category: selectedCategory.toString() ?? '',
      location: selectedLocation.toString() ?? '',
      minPrice: double.tryParse(minPriceTextEditingController.text) ?? 0.0,
      maxPrice: double.tryParse(maxPriceTextEditingController.text) ??
          double.infinity,
    );
filters=[];
    // Add the new Filter object to your filters list
    filters.add(filter);


    for (var filter in filters) {
      print(filter.category.toString() +
          "      " +
          filter.location.toString() +
          "       " +
          filter.maxPrice.toString() +
          "         " +
          filter.minPrice.toString());
    }

    // Update your filteredItems list here based on the selected filters
    emit(FilterApply());
  }
}
