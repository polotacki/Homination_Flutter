import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:homaination_mobile/bloc/cubits/home_cubit/home_cubit.dart';
import 'package:homaination_mobile/model/filter.dart';
import 'package:homaination_mobile/modules/recent_services/recent%20services%20screen.dart';
import 'package:homaination_mobile/shared/components/horizontal_card.dart';
import 'package:icon_decoration/icon_decoration.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shimmer/shimmer.dart';
import '../../bloc/cubits/filter_cubit/filter_cubit.dart';
import '../../model/review_model.dart';
import '../../model/services_model.dart';
import '../../shared/components/filter_modal_bottom_sheet.dart';
import '../../shared/components/vertical_card.dart';
import '../../shared/network/local/cache_helper.dart';
import '../search_page/search_page.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

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

  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<Filter> filter = [];
    return BlocProvider(
        create: (context) => HomeCubit()..getRecommendedServicesData()..getServicesData(),
        child: BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {},
            builder: (context, state) {
              var cubit = context.read<HomeCubit>();
              print(cubit.profilePic);

              return Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  scrolledUnderElevation: 0.0,
                  title: Text("Homination",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold))
                      .animate()
                      .fadeIn(duration: 300.ms),
                  leading: Padding(
                    padding:
                        const EdgeInsets.only(left: 20.0, top: 1, bottom: 1),
                    child: FloatingActionButton(
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      heroTag: 'menu',
                      mini: false,
                      backgroundColor: const Color(0xFF4CA6A8),
                      elevation: 0,
                      child: const Icon(Iconsax.menu_1, color: Colors.white),
                    ),
                  ).animate().fadeIn(duration: 300.ms, delay: 300.ms),
                  actions: [
                    CacheHelper.getData(key: "Token") != null &&
                            cubit.profilePic != null
                        ? Padding(
                            padding: const EdgeInsets.only(
                              right: 20.0,
                            ),
                            child: CircleAvatar(
                              backgroundImage: cubit.profilePic == null
                                  ? NetworkImage(cubit.profilePic)
                                  : const AssetImage(
                                          'assets/images/anonymous.png')
                                      as ImageProvider,
                            ),
                          ).animate().fadeIn(duration: 300.ms, delay: 300.ms)
                        : Padding(
                            padding: const EdgeInsets.only(
                              right: 20.0,
                            ),
                            child: CircleAvatar(
                              child: Image.asset('assets/images/anonymous.png'),
                            ),
                          ).animate().fadeIn(duration: 300.ms, delay: 300.ms),
                  ],
                  leadingWidth: 70.7.w,
                ),
                body: Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: const Color(0xffFBFBFB),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 55.0),
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
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: const BorderSide(
                                            width: 0,
                                            style: BorderStyle.none,
                                          ),
                                        ),
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            cubit.search(context,
                                                cubit.services, filter);
                                          },
                                          icon: const Icon(Icons.search),
                                        ),
                                        filled: true,
                                        contentPadding:
                                            const EdgeInsets.all(16),
                                        fillColor: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                FloatingActionButton(
                                  onPressed: () async {
                                    filter = await showModalBottomSheet(
                                      isScrollControlled: true,
                                      context: context,
                                      builder: (BuildContext context) =>
                                          FilterModalBottomSheet(
                                              servicesModel: cubit.services),
                                    );
                                    filter.forEach((element) {
                                      print(element.location);
                                      print(element.category);
                                      print(element.minPrice);
                                    });
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
                              ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Expanded(
                                child: Padding(
                                    padding: EdgeInsets.only(right: 15.0),
                                    child: Text(
                                      "Popular Services",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => RecentServicesScreen(
                                          servicesModel: cubit.services),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Show All",
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w300,
                                      color: const Color(0xff6A6A6A)),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(
                              left: 20.0,
                              right: 20.0,
                              top: 20.0,
                            ),
                            child: ConditionalBuilder(
                                condition: cubit.recommendedServices.isNotEmpty,
                                builder: (context) {
                                  final services = cubit.recommendedServices;
                                  List<Widget> cardList =
                                      services.map((service) {
                                    return VerticalCard(
                                      cardName: service.title,
                                      reviews: service.reviews.length,
                                      price: (service.price),
                                      imageAsset: service.providerImage,
                                      category: service.categories,
                                      averageReviews: service.reviews,
                                      service: service,
                                    );
                                  }).toList();
                                  return CarouselSlider(
                                    items: cardList,
                                    options: CarouselOptions(
                                      animateToClosest: true,
                                      height: 200.h,
                                      initialPage: 0,
                                      padEnds: true,
                                      autoPlayInterval:
                                          const Duration(seconds: 3),
                                      reverse: false,
                                      autoPlayAnimationDuration:
                                          const Duration(seconds: 1),
                                      enableInfiniteScroll: true,
                                      autoPlayCurve: Curves.fastOutSlowIn,
                                      scrollDirection: Axis.horizontal,
                                      autoPlay: true,
                                    ),
                                  );
                                },
                                fallback: (context) => CarouselSlider(
                                        items: [
                                          Shimmer.fromColors(
                                            baseColor: Colors.grey[300]!,
                                            highlightColor: Colors.grey[100]!,
                                            child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 20.0.h),
                                                child: Container(
                                                  height: 160.h,
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    boxShadow: const [
                                                      BoxShadow(
                                                        color:
                                                            Color(0xff403B4B),
                                                        offset: Offset(0, 2),
                                                        blurRadius: 15,
                                                        spreadRadius: -10.0,
                                                      ),
                                                    ],
                                                  ),
                                                  width: 260.w,
                                                )),
                                          ).animate().fadeIn(duration: 300.ms),
                                        ],
                                        options: CarouselOptions(
                                            height: 200.h,
                                            initialPage: 0,
                                            padEnds: true,
                                            scrollPhysics:
                                                const NeverScrollableScrollPhysics(),
                                            autoPlayInterval:
                                                const Duration(seconds: 0),
                                            reverse: false,
                                            autoPlayAnimationDuration:
                                                const Duration(seconds: 0),
                                            enableInfiniteScroll: true,
                                            autoPlayCurve: Curves.fastOutSlowIn,
                                            scrollDirection: Axis.horizontal,
                                            autoPlay: false)))),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Expanded(
                                child: Padding(
                                    padding: EdgeInsets.only(right: 15.0),
                                    child: Text(
                                      "Recent Services",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => RecentServicesScreen(
                                              servicesModel: cubit.services),
                                        ));
                                  },
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                RecentServicesScreen(
                                                    servicesModel:
                                                        cubit.services)),
                                      );
                                    },
                                    child: Text(
                                      "Show All",
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w300,
                                          color: const Color(0xff6A6A6A)),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 20.0, right: 20.0,top:20),
                          child: SizedBox(
                              height: 500.h,
                              child: Scrollbar(
                                radius: const Radius.circular(10),
                                child: ConditionalBuilder(
                                  condition: cubit.services.isNotEmpty,
                                  builder: (context) {
                                    final services = cubit.services;
                                    return ListView.separated(
                                      padding: const EdgeInsets.all(8),
                                      itemCount: services.length,
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(height: 10),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return AnimationConfiguration
                                            .staggeredList(
                                                position: index,
                                                duration: const Duration(
                                                    milliseconds: 375),
                                                child: SlideAnimation(
                                                    horizontalOffset: 50.0,
                                                    child: FadeInAnimation(
                                                        child: HorizontalCard(
                                                              service: services[
                                                          index],
                                                              avarageRate:
                                                          calculateAverageRating(
                                                              services[
                                                                      index]
                                                                  .reviews),
                                                            favOnPressed:() {cubit.addFavoriteService(serviceId: cubit.services[
                                                            index].id);}))));
                                      },
                                    );
                                  },
                                  fallback: (context) => ListView.separated(
                                      padding: const EdgeInsets.all(8),
                                      itemCount: 5,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(height: 10),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return AnimationConfiguration
                                            .staggeredList(
                                                position: index,
                                                duration: const Duration(
                                                    milliseconds: 375),
                                                child: SlideAnimation(
                                                    horizontalOffset: 50.0,
                                                    child: FadeInAnimation(
                                                        child: Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        10.0),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                  boxShadow: const [
                                                                    BoxShadow(
                                                                      color: Color(
                                                                          0xff403B4B),
                                                                      offset:
                                                                          Offset(
                                                                              0,
                                                                              2),
                                                                      blurRadius:
                                                                          15,
                                                                      spreadRadius:
                                                                          -10.0,
                                                                    ),
                                                                  ],
                                                                ),
                                                                child: Column(
                                                                  children: [
                                                                    Row(
                                                                      children:
                                                                          [
                                                                        Shimmer
                                                                            .fromColors(
                                                                          baseColor:
                                                                              Colors.grey[300]!,
                                                                          highlightColor:
                                                                              Colors.grey[100]!,
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                40.w,
                                                                            height:
                                                                                40.w,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(15),
                                                                              color: Colors.white,
                                                                            ),
                                                                            clipBehavior:
                                                                                Clip.antiAlias,
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              20.w,
                                                                        ),
                                                                        Expanded(
                                                                            child:
                                                                                Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Shimmer.fromColors(
                                                                              baseColor: Colors.grey[300]!,
                                                                              highlightColor: Colors.grey[100]!,
                                                                              child: Container(
                                                                                height: 16.h,
                                                                                width: 150.w,
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(15),
                                                                                  color: Colors.white,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 6.w,
                                                                            ),
                                                                            Row(
                                                                              children: [
                                                                                Shimmer.fromColors(
                                                                                  baseColor: Colors.grey[300]!,
                                                                                  highlightColor: Colors.grey[100]!,
                                                                                  child: RatingBar.builder(
                                                                                    initialRating: 4,
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
                                                                                ),
                                                                                Shimmer.fromColors(
                                                                                  baseColor: Colors.grey[300]!,
                                                                                  highlightColor: Colors.grey[100]!,
                                                                                  child: Container(
                                                                                    height: 16.h,
                                                                                    width: 50.w,
                                                                                    decoration: BoxDecoration(
                                                                                      borderRadius: BorderRadius.circular(15),
                                                                                      color: Colors.white,
                                                                                    ),
                                                                                  ),
                                                                                )
                                                                              ].animate(delay: 2000.ms, interval: 200.ms).fadeIn(duration: 900.ms),
                                                                            ),
                                                                          ],
                                                                        )),
                                                                        Shimmer
                                                                            .fromColors(
                                                                          baseColor:
                                                                              Colors.grey[300]!,
                                                                          highlightColor:
                                                                              Colors.grey[100]!,
                                                                          child:
                                                                              const Icon(
                                                                            Iconsax.heart5,
                                                                            size:
                                                                                20,
                                                                            color:
                                                                                Colors.red,
                                                                          ),
                                                                        )
                                                                      ].animate(delay: 1600.ms, interval: 200.ms).fadeIn(
                                                                              duration: 300.ms),
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsets.fromLTRB(
                                                                          55.w,
                                                                          6.h,
                                                                          0,
                                                                          0),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children:
                                                                            [
                                                                          Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children:
                                                                                [
                                                                              Shimmer.fromColors(
                                                                                baseColor: Colors.grey[300]!,
                                                                                highlightColor: Colors.grey[100]!,
                                                                                child: Container(
                                                                                  height: 16.h,
                                                                                  width: 80.w,
                                                                                  decoration: BoxDecoration(
                                                                                    borderRadius: BorderRadius.circular(15),
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              SizedBox(
                                                                                height: 6.h,
                                                                              ),
                                                                              Shimmer.fromColors(
                                                                                baseColor: Colors.grey[300]!,
                                                                                highlightColor: Colors.grey[100]!,
                                                                                child: Container(
                                                                                  height: 16.h,
                                                                                  width: 150.w,
                                                                                  decoration: BoxDecoration(
                                                                                    borderRadius: BorderRadius.circular(15),
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ].animate(delay: 1800.ms, interval: 200.ms).fadeIn(duration: 900.ms),
                                                                          ),
                                                                          Shimmer
                                                                              .fromColors(
                                                                            baseColor:
                                                                                Colors.grey[300]!,
                                                                            highlightColor:
                                                                                Colors.grey[100]!,
                                                                            child:
                                                                                RawMaterialButton(
                                                                              fillColor: Colors.white,
                                                                              splashColor: Colors.grey,
                                                                              onPressed: () {},
                                                                              shape: const StadiumBorder(),
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
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
                                                                            ),
                                                                          )
                                                                        ].animate(delay: 1800.ms, interval: 200.ms).fadeIn(duration: 900.ms),
                                                                      ),
                                                                    ),
                                                                  ]
                                                                      .animate(
                                                                          delay: 600
                                                                              .ms,
                                                                          interval: 200
                                                                              .ms)
                                                                      .fadeIn(
                                                                          duration:
                                                                              900.ms),
                                                                )))));
                                      }),
                                ),
                              )),
                        ),
                        SizedBox(
                          height: 30.h,
                        )
                      ]
                          .animate(delay: 600.ms, interval: 200.ms)
                          .fadeIn(duration: 300.ms),
                    ),
                  ),
                ),
              );
            }));
  }
}
