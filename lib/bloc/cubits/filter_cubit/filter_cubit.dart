import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homaination_mobile/bloc/cubits/home_cubit/home_cubit.dart';

import '../../../model/services_model.dart';


part 'filter_state.dart';


class FilterCubit extends Cubit<FilterState> {
  FilterCubit() : super(FilterInitial());
  static FilterCubit get(context) => BlocProvider.of(context);

  String? selectedCategory ;
  String? selectedLocation ;
  final List<String> searchCategories = [
    'Architects & Building Designers',
    'General Contractors',
    'Home Builders',
    'Interior Designers & Decorators',
    'Kitchen & Bathroom Designers',
    'Kitchen & Bathroom Remodelers',
    'Landscape Architects & Landscape Designers',
    'Landscape Contractors',
  ];
  final List<String> searchLocations = [
    'Cairo',
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
  double selectedminPrice =0.0;
  double selectedMaxPrice = 0.0;
 TextEditingController textEditingController = TextEditingController();
  void updateCategory(String category) {
     selectedCategory = category;
    emit(FilterCategoryChanged(category));
  }

  void updateLocation(String location) {
    selectedLocation=location;
    emit(FilterLocationChanged(location));
  }

  void updateMinPrice(double minPrice) {
    selectedminPrice = minPrice;
    emit(FilterMinPriceChanged(minPrice));
  }

  void updateMaxPrice(double maxPrice) {
    selectedMaxPrice= maxPrice;
    emit(FilterMaxPriceChanged(maxPrice));
  }

  void applyFilters() {
    emit(FilterApply());
  }

  void updateFilters({required String selectedCategory, required String selectedLocation, required double minPriceRange, required double maxPriceRange}) {
    final filteredItems = (state as ServicesSuccess).servicesModel.where((item) {
      // Check if the item matches the selected category and location
      if (selectedCategory.isNotEmpty && item.categories != selectedCategory) {
        return false;
      }
      if (selectedLocation.isNotEmpty && item.location != selectedLocation) {
        return false;
      }

      // Check if the item price is within the selected price range
      if (minPriceRange != null && item.price < minPriceRange) {
        return false;
      }
      if (maxPriceRange != null && item.price > maxPriceRange) {
        return false;
      }

      // If all conditions are met, include the item in the filtered list
      return true;
    }).toList();

    // Update the state with the filtered list of items
    emit(FilterUpdate(filteredItems));
  }
}