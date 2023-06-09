import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homaination_mobile/bloc/cubits/search_cubit/search_cubit.dart';
import 'package:homaination_mobile/model/services_model.dart';
import 'package:homaination_mobile/modules/search_page/search_page.dart';
import 'package:homaination_mobile/shared/components/price_range_text_field.dart';
import 'package:iconsax/iconsax.dart';

import '../../bloc/cubits/filter_cubit/filter_cubit.dart';
import '../style/constants.dart';

class FilterModalBottomSheet extends StatelessWidget {
   const FilterModalBottomSheet({Key? key, required List<ServicesModel> servicesModel}) : super(key: key);










  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => FilterCubit(),
        child: BlocConsumer<FilterCubit, FilterState>(


    listener: (context, state) {if (state is FilterApply) {
      // Do something with the applied filters, such as filtering a list of items or updating a UI widget
      final filterCubit = context.read<FilterCubit>();
      final selectedCategory = filterCubit.updateCategory;
      final selectedLocation = filterCubit.updateLocation;
      final minPriceRange = filterCubit.updateMinPrice;
      final maxPriceRange = filterCubit.applyFilters;

    }},
    builder: (context, state) {
    var filterCubit = FilterCubit.get(context);

            return FractionallySizedBox(
                heightFactor: 0.9,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        width: 80.w,
                        height: 4.h,
                        decoration: BoxDecoration(
                            color: const Color(0xffE1E1E1),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    SizedBox(height: 32.h),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color.fromRGBO(136, 68, 160, 1),
                      ),
                      clipBehavior: Clip.antiAlias,
                    ),
                    SizedBox(height: 25.h),
                    Text("Set Filters",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 50.h),
                    Padding(
                      padding: EdgeInsets.only(left: 20.0.w, bottom: 15.h),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text("Category",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.black,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        hint: Text(
                          'Select Category',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.normal,
                            color: Theme
                                .of(context)
                                .hintColor,
                          ),
                        ),
                        items: filterCubit.searchCategories
                            .map((item) =>
                            DropdownMenuItem(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ))
                            .toList(),
                        value: filterCubit.selectedCategory,
                        onChanged: (value) =>
                            context
                                .read<FilterCubit>()
                                .updateCategory(value as String),
                        buttonStyleData: ButtonStyleData(
                          height: 54.h,
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          width: 335.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.white,
                          ),
                        ),
                        iconStyleData: const IconStyleData(
                          icon: Icon(Iconsax.arrow_down_1),
                          openMenuIcon: Icon(
                            Iconsax.arrow_right_3,
                          ),
                          iconSize: 14,
                          iconEnabledColor: Colors.black,
                          iconDisabledColor: Colors.grey,
                        ),
                        dropdownStyleData: const DropdownStyleData(
                          maxHeight: 200,
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                        ),
                        dropdownSearchData: DropdownSearchData(
                          searchController: filterCubit
                              .searchTextEditingController,
                          searchInnerWidgetHeight: 50,
                          searchInnerWidget: Container(
                            height: 50,
                            padding: const EdgeInsets.only(
                              top: 8,
                              bottom: 4,
                              right: 8,
                              left: 8,
                            ),
                            child: TextFormField(
                              expands: true,
                              maxLines: null,
                              controller: filterCubit
                                  .searchTextEditingController,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 8,
                                ),
                                hintText: 'Search Category...',
                                hintStyle: const TextStyle(fontSize: 12),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          searchMatchFn: (item, searchValue) {
                            return (item.value
                                .toString()
                                .contains(searchValue));
                          },
                        ),
                        //This to clear the search value when you close the menu
                        onMenuStateChange: (isOpen) {
                          if (!isOpen) {
                            filterCubit.searchTextEditingController.clear();
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 30.h),
                    Padding(
                      padding: EdgeInsets.only(left: 20.0.w, bottom: 15.h),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text("Location",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.black,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        hint: Text(
                          'Select Location',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.normal,
                            color: Theme
                                .of(context)
                                .hintColor,
                          ),
                        ),
                        items: filterCubit.searchLocations
                            .map((item) =>
                            DropdownMenuItem(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ))
                            .toList(),
                        value: filterCubit.selectedLocation,
                        onChanged: (value) =>
                            context
                                .read<FilterCubit>()
                                .updateLocation(value as String),
                        buttonStyleData: ButtonStyleData(
                          height: 54.h,
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          width: 335.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.white,
                          ),
                        ),
                        iconStyleData: const IconStyleData(
                          icon: Icon(Iconsax.arrow_down_1),
                          openMenuIcon: Icon(
                            Iconsax.arrow_right_3,
                          ),
                          iconSize: 14,
                          iconEnabledColor: Colors.black,
                          iconDisabledColor: Colors.grey,
                        ),
                        dropdownStyleData: const DropdownStyleData(
                          maxHeight: 200,
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                        ),
                        dropdownSearchData: DropdownSearchData(
                          searchController: filterCubit
                              .locationTextEditingController,
                          searchInnerWidgetHeight: 50,
                          searchInnerWidget: Container(
                            height: 50,
                            padding: const EdgeInsets.only(
                              top: 8,
                              bottom: 4,
                              right: 8,
                              left: 8,
                            ),
                            child: TextFormField(
                              expands: true,
                              maxLines: null,
                              controller: filterCubit
                                  .locationTextEditingController,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 8,
                                ),
                                hintText: 'Search for an item...',
                                hintStyle: const TextStyle(fontSize: 12),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          searchMatchFn: (item, searchValue) {
                            return (item.value
                                .toString()
                                .contains(searchValue));
                          },
                        ),
                        //This to clear the search value when you close the menu
                        onMenuStateChange: (isOpen) {
                          if (!isOpen) {
                            filterCubit.locationTextEditingController.clear();
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 30.h),
                    Padding(
                      padding: EdgeInsets.only(left: 20.0.w, bottom: 15.h),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text("Budget",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.black,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 20.w,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text("From",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        const Icon(Iconsax.wallet_2),
                        Padding(
                          padding: EdgeInsets.only(left: 5.0.w),
                          child: SizedBox(
                            width: 65.w,
                            child: TextFormField(
                              controller: filterCubit
                                  .minPriceTextEditingController,
                              onChanged: (value) =>
                                  context
                                      .read<FilterCubit>()
                                      .updateMinPrice(value),
                              decoration: InputDecoration(
                                prefixText: "EGP ",
                                prefixStyle: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                    fontSize: 12.sp,
                                    fontWeight:
                                    FontWeight.bold)
                                ,
                                border: InputBorder.none,
                                hintText: 'price',
                                hintStyle: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.grey,
                                    fontSize: 14.sp,
                                    fontWeight:
                                    FontWeight.bold),),


                              keyboardType: TextInputType.number,

                              validator: (value) {
                               /* if (value!.isEmpty) {
                                  return 'Please enter a price range';
                                }
                                return null;*/
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text("to",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        const Icon(Iconsax.wallet_3),
                        Padding(
                          padding: EdgeInsets.only(left: 5.0.w),
                          child: SizedBox(
                            width: 65.w,
                            child: TextFormField(
                              controller: filterCubit
                                  .maxPriceTextEditingController,
                              onChanged: (value) =>
                                  context
                                      .read<FilterCubit>()
                                      .updateMaxPrice(value),
                              decoration: InputDecoration(
                                prefixText: "EGP ",
                                prefixStyle: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                    fontSize: 12.sp,
                                    fontWeight:
                                    FontWeight.bold)
                                ,
                                border: InputBorder.none,
                                hintText: 'price',
                                hintStyle: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.grey,
                                    fontSize: 14.sp,
                                    fontWeight:
                                    FontWeight.bold),),


                              keyboardType: TextInputType.number,

                              validator: (value) {
                                /*if (value!.isEmpty) {
                                  return 'Please enter a price range';
                                }
                                return null;*/
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                      ],
                    ),
                    Expanded(
                      child: Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          height: 110.h,
                          decoration: const BoxDecoration(
                              color: Color(0xffE1E1E1),
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(12))),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
                            child: SizedBox(
                              height: 54.h,
                              width: 400.w,
                              child: TextButton(
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(12.0)),
                                      ),
                                      backgroundColor:
                                      MaterialStateProperty.all(
                                          buttonColor)),
                                  onPressed: ()  {



                                    filterCubit.applyFilters();
                                    print(filterCubit.filters);

                                    Navigator.pop(context,filterCubit.filters);
                                    /*Navigator.push(context, MaterialPageRoute(
                                        builder: (_) =>
                                            SearchPage(query: "",
                                                service:
                                                    filterCubit.filteredItems)));*/

                                  },
                                  child: const Text(
                                    "Apply Filters",
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: Colors.white),
                                  )),
                            ),
                          ),
                        ),
                      ),
                    )
                  ].animate( interval: 100.ms).fadeIn(duration: 900.ms),
                ));
          },
        ));
  }
}
