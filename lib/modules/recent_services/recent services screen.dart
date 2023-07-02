import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:homaination_mobile/shared/components/horizontal_card.dart';
import 'package:iconsax/iconsax.dart';

import '../../bloc/cubits/home_cubit/home_cubit.dart';
import '../../model/review_model.dart';
import '../../model/services_model.dart';

class RecentServicesScreen extends StatefulWidget {
  RecentServicesScreen({
    super.key,
    required this.servicesModel,
  });

  final List<ServicesModel> servicesModel;

  @override
  _RecentServicesScreenState createState() => _RecentServicesScreenState();
}

class _RecentServicesScreenState extends State<RecentServicesScreen> {
  String _sortBy = 'Price'; // default sort by price
  bool _isAscending = true;

  // default sort in ascending order

  double calculateAverageRating(List<Review> reviews) {
    if (reviews.isEmpty) {
      return 0.0;
    }

    int totalRating = 0;

    for (var review in reviews) {
      totalRating += review.rating!;
    }

    return totalRating / reviews.length;
  }

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {},
            builder: (context, state) {
              var cubit = context.read<HomeCubit>();

              print(widget.servicesModel);
              void _sortServices(String sortBy, bool isAscending) {
                setState(() {
                  _sortBy = sortBy;
                  _isAscending = isAscending;

                  // sort the services list based on the selected criteria
                  switch (sortBy) {
                    case 'Name':
                      widget.servicesModel.sort((a, b) => isAscending
                          ? a.title.compareTo(b.title)
                          : b.title.compareTo(a.title));
                      break;
                    case 'Price':
                      widget.servicesModel.sort((a, b) => isAscending
                          ? a.price.compareTo(b.price)
                          : b.price.compareTo(a.price));
                      break;
                    case 'Reviews':
                      widget.servicesModel.sort((a, b) => isAscending
                          ? a.reviews.length.compareTo(b.reviews.length)
                          : b.reviews.length.compareTo(a.reviews.length));
                      break;
                  }
                });
              }

              return Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  scrolledUnderElevation: 0.0,
                  title: Text(
                    'Recent Services',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.black,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold),
                  ).animate()
                      .fadeIn(duration: 300.ms),
                  centerTitle: true,
                  leading: IconButton(
                      icon: const Icon(
                        Iconsax.arrow_left_24,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }).animate().fadeIn(duration: 300.ms, delay: 300.ms),
                ),
                body: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () => _sortServices(
                              'Name', _sortBy != 'Name' || !_isAscending),
                          style: ButtonStyle(
                            padding:
                                MaterialStateProperty.all(const EdgeInsets.all(8)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8))),
                          ),
                          child: Row(
                            children: [
                              Text(
                                'Sort by Name',
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500),
                              ),
                              if (_sortBy == 'Name')
                                Icon(
                                    _isAscending
                                        ? Iconsax.arrow_up_1
                                        : Iconsax.arrow_down_2,
                                    size: 18.sp),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => _sortServices(
                              'Price', _sortBy != 'Price' || !_isAscending),
                          style: ButtonStyle(
                            padding:
                                MaterialStateProperty.all(const EdgeInsets.all(8)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8))),
                          ),
                          child: Row(
                            children: [
                              Text(
                                'Sort by Price',
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500),
                              ),
                              if (_sortBy == 'Price')
                                Icon(
                                    _isAscending
                                        ? Iconsax.arrow_up_1
                                        : Iconsax.arrow_down_2,
                                    size: 18.sp),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => _sortServices(
                              'Reviews', _sortBy != 'Reviews' || !_isAscending),
                          style: ButtonStyle(
                            padding:
                                MaterialStateProperty.all(const EdgeInsets.all(8)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8))),
                          ),
                          child: Row(
                            children: [
                              Text(
                                'Sort by Reviews',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              if (_sortBy == 'Reviews')
                                Icon(
                                    _isAscending
                                        ? Iconsax.arrow_up_1
                                        : Iconsax.arrow_down_2,
                                    size: 18.sp),
                            ],
                          ),
                        ),
                      ].animate( delay: 600.ms,interval: 200.ms).fadeIn(duration: 900.ms),
                    ), SizedBox(height:18.h),
                    Expanded(
                      child: Scrollbar(radius: const Radius.circular(50.0),interactive: true,
                        child: ListView.separated(
                          itemCount: widget.servicesModel.length,
                          separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                          itemBuilder: (BuildContext context, int index) {
                            return AnimationConfiguration
                                .staggeredList(
                                position: index,
                                duration: const Duration(
                                milliseconds: 375),
                            child: SlideAnimation(
                            horizontalOffset: 50.0,
                            child: FadeInAnimation(
                            child: HorizontalCard(
                              service: widget.servicesModel[index],
                              avarageRate: calculateAverageRating(
                                  widget.servicesModel[index].reviews),
                                favOnPressed:() {cubit.addFavoriteService(serviceId:  widget.servicesModel[index].id);} ))));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            });
  }
}
