import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homaination_mobile/model/services_model.dart';
import 'package:icon_decoration/icon_decoration.dart';
import 'package:iconsax/iconsax.dart';
import 'custom_show_modal_sheet.dart';
import '../style/constants.dart';

class HorizontalCard extends StatelessWidget {
  final ServicesModel service;


  final double avarageRate;

  VoidCallback? favOnPressed;

   HorizontalCard({
    super.key,
    context,
    required this.service, required this.avarageRate,required this.favOnPressed
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: (){  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return
             CustomModalBottomSheet(service: service);

      },
    );
    },
      child: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Color(0xff403B4B),
                offset: Offset(0, 2),
                blurRadius: 15,
                spreadRadius: -10.0,
              ),
            ],
          ),
          child: Column(children: [
            Row(
              children: [
                Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color:  Colors.white,
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.network(
                    service.providerImage,fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  width: 20.w,
                ),
                Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                        Text(service.title,
                            style: TextStyle(
                                fontFamily: 'SFPRODISPLAY',
                                color: Colors.black,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold)),

                    SizedBox(
                      height: 6.w,
                    ),
                    Row(
                      children: [
                        RatingBar.builder(
                          initialRating: avarageRate,
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
                            print(rating);
                          },
                        ),
                        Text("${service.reviews.length} reviews",
                            style: TextStyle(
                                fontFamily: 'SFPRODISPLAY',
                                color: secondaryColor,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.normal))
                      ].animate(delay: 300.ms, interval: 200.ms).fadeIn(duration: 900.ms),
                    ),
                  ],
                )),
                IconButton(
                  icon: const Icon(
                    Iconsax.heart5,
                    size: 20,
                    color: Colors.red,
                  ),
                  onPressed: favOnPressed,
                ).animate( ).fadeIn(
                    duration: 300.ms),
              ].animate(
                   interval: 200.ms)
                  .fadeIn(duration: 900.ms),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(55.w, 6.h, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("EGP ${service.price}/meter",
                          style: const TextStyle(
                              fontFamily: 'Poppins',
                              color: secondaryColor,
                              fontSize: 12)),
                      SizedBox(
                        height: 6.h,
                      ),
                      Container(width: 130.w,
                        child: Text(service.categories,
                            style: TextStyle(
                                fontFamily: 'SFPRODISPLAY',
                                color: secondaryColor,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w300)),
                      ),
                    ].animate(delay: 600.ms, interval: 200.ms).fadeIn(duration: 900.ms),
                  ),
                  RawMaterialButton(
                    fillColor: Colors.white,
                    splashColor: Colors.grey,
                    onPressed: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (BuildContext context) {
                          return
                            CustomModalBottomSheet(service: service);

                        },
                      );


                    },
                    shape: const StadiumBorder(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 5.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Icon(
                            Iconsax.message,
                            color: Color(0xff6750A4),
                            size: 15,
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            'Send Proposal',
                            maxLines: 1,
                            style: TextStyle(
                              fontFamily: 'Gilroy',
                              color: const Color(0xff6750A4),
                              fontSize: 10.sp,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ].animate(delay: 600.ms, interval: 200.ms).fadeIn(duration: 900.ms),
              ),
            ),
          ])),


    );
  }
}

