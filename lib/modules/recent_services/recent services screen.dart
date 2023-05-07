import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homaination_mobile/modules/home_screen/home_screen.dart';
import 'package:homaination_mobile/shared/components/horizontal_card.dart';
import 'package:iconsax/iconsax.dart';

import '../../bloc/cubits/home_cubit/home_cubit.dart';
import '../../data/cards.dart';
import '../../model/services_mod.dart';
import '../../model/services_model.dart';



class RecentServicesScreen extends StatefulWidget {
  @override
  _RecentServicesScreenState createState() => _RecentServicesScreenState();
}

class _RecentServicesScreenState extends State<RecentServicesScreen> {
  List<Service> _services = services.values.toList();
  String _sortBy = 'Price'; // default sort by price
  bool _isAscending = true; // default sort in ascending order

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

  void _sortServices(String sortBy, bool isAscending) {
    setState(() {
      _sortBy = sortBy;
      _isAscending = isAscending;

      // sort the services list based on the selected criteria
      switch (sortBy) {
        case 'Name':
          _services.sort((a, b) =>
          isAscending ? a.title.compareTo(b.title) : b.title.compareTo(a.title));
          break;
        case 'Price':
          _services.sort((a, b) =>
          isAscending ? int.parse(a.price).compareTo(int.parse(b.price)) : int.parse(b.price).compareTo(int.parse(a.price)));
          break;
        case 'Reviews':
          _services.sort((a, b) =>
          isAscending
              ? a.reviews.length.compareTo(b.reviews.length)
              : b.reviews.length.compareTo(a.reviews.length));
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
    builder: (context, state) {
    return Scaffold(
      appBar: AppBar(elevation: 0,scrolledUnderElevation: 0.0,
        title: Text('Recent Services',style:TextStyle(
            fontFamily: 'Poppins',
            color: Colors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold) ,),centerTitle: true,leading: IconButton(icon: Icon(Iconsax.arrow_left_24,),onPressed: (){Navigator.of(context).pop();}),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => _sortServices('Name', _sortBy != 'Name' || !_isAscending),
                child: Row(
                  children: [
                    Text('Sort by Name',style: TextStyle(
                        fontSize: 12.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500),),
                    if (_sortBy == 'Name')
                      Icon(_isAscending ? Iconsax.arrow_up_1 : Iconsax.arrow_down_2),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () => _sortServices('Price', _sortBy != 'Price' || !_isAscending),
                child: Row(
                  children: [
                    Text('Sort by Price',style: TextStyle(
                        fontSize: 12.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500),),
                    if (_sortBy == 'Price')
                      Icon(_isAscending ? Iconsax.arrow_up_1 : Iconsax.arrow_down_2),
                  ],
                ),
                ),
              ElevatedButton(
                onPressed: () => _sortServices('Reviews', _sortBy != 'Reviews' || !_isAscending),
                child: Row(
                  children: [
                    Text('Sort by Reviews',style: TextStyle(
                        fontSize: 12.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500),),
                    if (_sortBy == 'Reviews')
                      Icon(_isAscending ? Iconsax.arrow_up_1 : Iconsax.arrow_down_2),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: Scrollbar(
              child: ListView.builder(
                itemCount: _services.length,
                itemBuilder: (BuildContext context, int index) {
                  return HorizontalCard(service: HomeCubit.get(context).services![index],avarageRate:  calculateAverageRating(HomeCubit.get(context).services![index].reviews), state: state,);
                },
              ),
            ),
          ),
        ],
      ),
    );
    }); }
}
