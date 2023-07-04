import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:homaination_mobile/bloc/cubits/favorite_cubit/favorite_cubit.dart';
import 'package:homaination_mobile/shared/components/horizontal_card.dart';
import 'package:iconsax/iconsax.dart';

import '../../model/review_model.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

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
    return BlocProvider(
      create: (context) => FavoriteCubit()..getFavoriteServicesData(),
      child: BlocConsumer<FavoriteCubit, FavoriteState>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = context.read<FavoriteCubit>();

            return Scaffold(
              appBar: AppBar(shadowColor: Colors.black12,
                  centerTitle: true,
                  title: Text("Favorites",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold))),
              body: Scrollbar(radius: Radius.circular(10),
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 300),
                          child: SlideAnimation(
                              horizontalOffset: 50.0,
                              child: FadeInAnimation(
                                  child: HorizontalCard( icon :const Icon(
                                    Iconsax.trash,
                                    size: 20,
                                    color: Colors.red,
                                  ),
                                      service: cubit.favoriteServices[index],
                                      avarageRate: calculateAverageRating(cubit.favoriteServices[
                                      index]
                                          .reviews),favOnPressed:() {cubit.deleteFavoriteService(serviceId: cubit.favoriteServices[
                                  index].id);}))));
                    },
                    separatorBuilder: (context, index) =>
                    const Divider(
                      color: Colors.transparent,
                    ),
                    itemCount: cubit.favoriteServices.length),
              ),
            );
          }),
    );
  }
}
