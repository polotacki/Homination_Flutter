import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:homaination_mobile/bloc/cubits/home_cubit/home_cubit.dart';
import 'package:homaination_mobile/layout/home_layout.dart';
import 'package:homaination_mobile/shared/components/horizontal_card.dart';

import '../../bloc/cubits/app_cupit/app_cubit.dart';
import '../../data/cards.dart';
import '../../model/services_mod.dart';
import '../../model/services_model.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  double _calculateAverageRating(List<Review> reviews) {
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
    return BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(shadowColor: Colors.black12,
                centerTitle: true,
                title: Text("Favorites",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.black,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold))),
            body: Scrollbar(radius: Radius.circular(10) ,
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    final service = services.values.toList()[index];
                    return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 300),
                        child: SlideAnimation(
                            horizontalOffset: 50.0,
                            child: FadeInAnimation(
                                child: HorizontalCard(state: state,
                                    service: HomeCubit.get(context).services![index],
                                    avarageRate: _calculateAverageRating(
                                        HomeCubit.get(context).services![index].reviews)))));
                  },
                  separatorBuilder: (context, index) => const Divider(
                        color: Colors.transparent,
                      ),
                  itemCount: services.length),
            ),
          );
        });
  }
}
