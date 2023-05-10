  import 'package:flutter/material.dart';
  import 'package:flutter_bloc/flutter_bloc.dart';
  import 'package:flutter_screenutil/flutter_screenutil.dart';
  import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';

  import '../../bloc/cubits/search_cubit/search_cubit.dart';
  import '../../model/services_model.dart';
  import '../../shared/components/filter_modal_bottom_sheet.dart';
  import '../../shared/components/horizontal_card.dart';
  class SearchPage extends StatelessWidget {
     SearchPage({Key? key, required this.query, required this.service}) : super(key: key);

      final String query;



    final List<ServicesModel> service;

    double calculateAverageRating(List<Review> reviews) {
      if (reviews.isEmpty) {
        return 0.0;
      }

      int totalRating = 0;

      for (var review in reviews) {
        totalRating += review.rating;
      }

      return totalRating / reviews.length;
    }

    @override
    Widget build(BuildContext context) {
      return
        BlocProvider(
          create: (context) => SearchCubit(servicesModel: service)..searchQueryChanged(service),
          child: BlocConsumer<SearchCubit, SearchState>(

              listener: (context, state) {},
              builder: (context, state) {
                var cubit = SearchCubit.get(context);
                return Scaffold(
                  appBar: AppBar(
                    title: Text('Search',style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.black,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold),
                    ), centerTitle: true,
                  ),
                  body:  SingleChildScrollView(
                    child: Column(
                      children: [ Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 15.0),
                                child: TextField(
                                  textAlign: TextAlign.left,
                                  controller: cubit.searchCtrl,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    hintText: 'Search here...',
                                    hintStyle: TextStyle(
                                        fontSize: 16.sp,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w200),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        cubit.searchQueryChanged( service);

                                      },
                                      icon: const Icon(Icons.search),
                                    ),
                                    filled: true,
                                    contentPadding: const EdgeInsets.all(16),
                                    fillColor: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            FloatingActionButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return FilterModalBottomSheet();
                                  },
                                );
                              },
                              heroTag: 'filter',
                              mini: false,
                              backgroundColor: const Color(0xFF4CA6A8),
                              elevation: 0,
                              child: const Icon(
                                Iconsax.setting_4,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                       Visibility(visible: cubit.searchResults.isEmpty,
                           child: Padding(padding: EdgeInsets.only(top: 100.h),child: Lottie.asset(
                         "assets/animations/no_results.json",
                         width: 300.w,
                         height: 300.h,
                       ),)),
                        Visibility(visible: cubit.searchResults.isEmpty,
                            child:
                            Center(
                              child: Text('No results found',style:  TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w300),
                              ),),

                            ),

                        ListView.builder(physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: cubit.searchResults.length,
                          itemBuilder: (BuildContext context, int index) {
                            final service = cubit.searchResults[index];

                            return HorizontalCard(
                              avarageRate: calculateAverageRating(
                                  service.reviews), service: service,);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }),
        );
    }
  }
