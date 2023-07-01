import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homaination_mobile/model/services_model.dart';
import 'package:homaination_mobile/modules/proposal/proposal_screen2.dart';
import 'package:icon_decoration/icon_decoration.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';

import '../../bloc/cubits/custom_modal_bottom_sheet_cubit/custom_modal_bottom_sheet_cubit.dart';
import '../../modules/auth/login_screen.dart';
import '../../modules/proposal/proposal_screen.dart';
import '../network/local/cache_helper.dart';
import '../style/constants.dart';
import 'custom_navigation_bar.dart';
import 'full_screen_image.dart';
class CustomModalBottomSheet extends StatelessWidget {
   CustomModalBottomSheet({Key? key, required this.service}) : super(key: key);

   final ServicesModel service;


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => CustomModalBottomSheetCubit(),
        child: BlocConsumer<CustomModalBottomSheetCubit, CustomModalBottomSheetState>(

            listener: (context, state) {},
            builder: (context, state) {

              var cubit=CustomModalBottomSheetCubit.get(context);


              return FractionallySizedBox(
          heightFactor: 0.88,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  width: 80.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                      color: const Color(0xffFBFBFB),
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
                child: Image.network(
                  service.providerImage,fit: BoxFit.fill,
                  width: 70,
                  height: 70,
                ),
              ),
              SizedBox(height: 19.h),
              Text(service.provider,
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold)),
              Text(service.categories,
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500)),
              SizedBox(height: 33.h),
              Padding(
                padding: EdgeInsets.only(left: 41.0.w),
                child: Row(
                  children: [
                    const Icon(Iconsax.star),
                    SizedBox(
                      width: 9.w,
                    ),
                    Text("${service.reviews.length} reviews",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: secondaryColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.normal)),
                    SizedBox(width: 48.w),
                    Text(
                      "EGP ${service.price}/meter",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          color: secondaryColor,
                          fontSize: 16.sp),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 27.h,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                  child: CustomNavBar(
                    children: const ["About Us", "Company", "Reviews"],
                    currentIndex: cubit.currentIndex,
                    onTap:  (index) => cubit.buttonSelected(index),
                  )),
              SizedBox(
                height: 40.h,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 20.0.w,
                  right: 20.0.w,
                ),
                child: SizedBox(
                    width: double.infinity,
                    height: 250.h,
                    child: PageView(
                        scrollDirection: Axis.horizontal,
                        controller: cubit.controller,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Description:",
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: 20.h,
                              ),
                              Expanded(
                                child: Scrollbar(
                                  radius: const Radius.circular(10),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Text(service.desc,
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Colors.black54,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400)),
                                  ),
                                ),
                              ),
                            ].animate( delay:200.ms , interval: 200.ms).fadeIn(duration: 900.ms),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Gallery:",
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: 10.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: const Color(0xffD9D9D9),
                                        borderRadius:
                                            BorderRadius.circular(18)),
                                    width: 300.w,
                                    height: 200.h,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Scrollbar(
                                        radius: const Radius.circular(10),
                                        child: ListView.separated(
                                            scrollDirection: Axis.horizontal,
                                            padding: const EdgeInsets.all(8),
                                            itemCount: service.gallery.length,
                                            separatorBuilder:
                                                (context, index) =>
                                                    const SizedBox(width: 10),
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              final image =
                                                  service.gallery[index];
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 20.0),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (_) =>
                                                            FullScreenImageWidget(
                                                          imageUrl: image,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    child: Image.network(
                                                      image,
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ].animate( interval: 200.ms).fadeIn(duration: 900.ms),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Reviews:",
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: 10.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: const Color(0xffD9D9D9),
                                        borderRadius:
                                            BorderRadius.circular(18)),
                                    width: 300.w,
                                    height: 200.h,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ListView.separated(
                                          scrollDirection: Axis.vertical,
                                          padding: const EdgeInsets.all(2.0),
                                          itemCount: service.reviews.length,
                                          separatorBuilder: (context, index) =>
                                              const SizedBox(
                                                height: 20,
                                              ),
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            final review =
                                                service.reviews[index];
                                            return Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Color(0xff403B4B),
                                                    offset: Offset(0, 2),
                                                    blurRadius: 15,
                                                    spreadRadius: -10.0,
                                                  ),
                                                ],
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          width: 50.w,
                                                          height: 50.w,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                            color: const Color
                                                                    .fromRGBO(
                                                                136,
                                                                68,
                                                                160,
                                                                1),
                                                          ),
                                                          clipBehavior:
                                                              Clip.antiAlias,
                                                          child: Image.network(
                                                            review.image,
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 20.w,
                                                        ),
                                                        Expanded(
                                                            child: Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Text(
                                                                    review.clientName,
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'SFPRODISPLAY',
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize: 14
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight.bold)),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 6.w,
                                                            ),
                                                            Row(
                                                              children: [
                                                                RatingBar
                                                                    .builder(
                                                                  initialRating:
                                                                      review
                                                                          .rating
                                                                          .toDouble(),
                                                                  minRating: 1,
                                                                  direction: Axis
                                                                      .horizontal,
                                                                  allowHalfRating:
                                                                      true,
                                                                  itemCount: 5,
                                                                  itemSize: 12,
                                                                  itemPadding:
                                                                      const EdgeInsets
                                                                              .only(
                                                                          right:
                                                                              9.0),
                                                                  itemBuilder: (context,
                                                                          _) =>
                                                                      const DecoratedIcon(
                                                                          icon:
                                                                              Icon(
                                                                            Icons.star,
                                                                            color:
                                                                                Colors.amber,
                                                                          ),
                                                                          decoration:
                                                                              IconDecoration(
                                                                            border:
                                                                                IconBorder(color: Colors.black),
                                                                          )),
                                                                  onRatingUpdate:
                                                                      (rating) {
                                                                    print(
                                                                        rating);
                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                            Align(
                                                                alignment: Alignment
                                                                    .bottomLeft,
                                                                child: ReadMoreText(
                                                                    review
                                                                        .comment,
                                                                    trimLines:
                                                                        2,
                                                                    colorClickableText:
                                                                        Colors
                                                                            .pink,
                                                                    trimMode: TrimMode
                                                                        .Line,
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'SFPRODISPLAY',
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize: 10
                                                                            .sp,
                                                                        fontWeight: FontWeight
                                                                            .normal),
                                                                    trimCollapsedText:
                                                                        'Show more',
                                                                    trimExpandedText:
                                                                        '.. Show less',
                                                                    lessStyle: TextStyle(
                                                                        fontFamily:
                                                                            'SFPRODISPLAY',
                                                                        color: Colors
                                                                            .teal,
                                                                        fontSize: 10
                                                                            .sp,
                                                                        fontWeight: FontWeight
                                                                            .normal),
                                                                    moreStyle: TextStyle(
                                                                        fontFamily:
                                                                            'SFPRODISPLAY',
                                                                        color: Colors.teal,
                                                                        fontSize: 10.sp,
                                                                        fontWeight: FontWeight.normal)))
                                                          ],
                                                        )),
                                                      ],
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      child: Text(
                                                          review.timestamps
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'SFPRODISPLAY',
                                                              color:
                                                                  secondaryColor,
                                                              fontSize: 10.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal)),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          }),
                                    ),
                                  ),
                                ],
                              )
                            ].animate( interval: 200.ms).fadeIn(duration: 900.ms),
                          ),
                        ])),
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
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(12))),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
                      child: SizedBox(
                        height: 54.h,
                        width: 400,
                        child: TextButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(12.0)),
                                ),
                                backgroundColor:
                                    MaterialStateProperty.all(buttonColor)),
                            onPressed: () {
                              Widget widget;
                              String? token = CacheHelper.getData(key: 'Token');

                              if (token != null) {
                                if (service.categories == "Foundation Builder") {
                                  widget = ProposalScreen2  (proposalService: service,);

                                }  else{
                                  widget = ProposalScreen(proposalService: service,);

                                }
                              } else {
                                widget = LoginScreen();
                              }
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) => widget));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Iconsax.message5,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 6.w,
                                ),
                                const Text(
                                  "Send Proposal",
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: Colors.white),
                                ),
                              ].animate( delay:1600.ms,interval: 200.ms).fadeIn(duration: 600.ms),
                            )),
                      ),
                    ),
                  ),
                ),
              )
            ].animate( interval: 100.ms).fadeIn(duration: 900.ms),
          ));
  }));
}  }

