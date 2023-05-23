import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homaination_mobile/shared/style/constants.dart';
import 'package:icon_decoration/icon_decoration.dart';
import 'package:iconsax/iconsax.dart';

import '../../model/review_model.dart';
import '../../model/services_model.dart';
import 'custom_show_modal_sheet.dart';

class VerticalCard extends StatelessWidget {
  final String imageAsset;

  final int reviews;

  final String cardName;

  final String category;

  final int price;

  final List<Review> averageReviews;

  final service;

  const VerticalCard(
      {super.key,
      context,
      required this.cardName,
      required this.imageAsset,
      required this.reviews, required this.category, required this.price, required this.averageReviews,required this.service});

  @override
  Widget build(BuildContext context) {
    double _calculateAverageRating(List<Review> reviews) {
      if (reviews.isEmpty) {
        return 0.0;
      }

      int totalRating = 0;

      for (var review in reviews) {
        totalRating += review.rating!;
      }

      return totalRating / reviews.length;
    }
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.0.h),
      child: GestureDetector(onTap: (){showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return
            CustomModalBottomSheet(service: service);

        },
      );},
        child: Container(
          height: 160.h,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20),boxShadow: const [
            BoxShadow(

              color: Color(0xff403B4B),

              offset: Offset(0, 2),
              blurRadius: 15,
              spreadRadius: -10.0,
            ),
          ],),
          width: 260.w,
          child: Column(children: [
            Row(
              children: [
                Container(width: 40.w,height: 40.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color.fromRGBO(68, 96, 160, 1),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.network(
                    imageAsset,fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(
                  width: 6,
                ),
                Expanded(child: Text(cardName,style:  TextStyle(
                    fontFamily: 'Poppins',
                    color: secondaryColor,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w200))),
                IconButton(
                  icon: const Icon(
                    Iconsax.heart5,
                    size: 28,
                    color: Colors.red,
                  ),
                  onPressed: () {},
                )
              ],
            ),
            Row(
              children: [
                RatingBar.builder(
                  initialRating: _calculateAverageRating(averageReviews),
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 12,
                  itemPadding: const EdgeInsets.only(right: 9.0),
                  itemBuilder: (context, _) => const DecoratedIcon(
                      icon: Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      decoration: IconDecoration(
                        border: IconBorder(color: Colors.black),
                      )),
                  onRatingUpdate: (rating) {

                  },
                ),
                Text("$reviews reviews",
                    style:  TextStyle(
                        fontFamily: 'SFPRODISPLAY',
                        color: secondaryColor,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.normal))
              ],
            ),
            SizedBox(
              height: 18.h,
            ),
            Row(
              children: [
                Text(category,
                  style:  TextStyle(
        fontFamily: 'SFPRODISPLAY',
        color: Colors.black,
        fontSize: 14.sp,
        fontWeight: FontWeight.normal))
              ],
            ),
            SizedBox(
              height: 18.h,
            ),
            Row(
              children: [
                Text("EGP $price/meter",
                    style:  TextStyle(
                        fontFamily: 'SFPRODISPLAY',
                        color: secondaryColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w200))
              ],
            )
          ]),
        ),
      ),
    );
  }
}
