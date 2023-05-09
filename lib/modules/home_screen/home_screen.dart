import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homaination_mobile/bloc/cubits/home_cubit/home_cubit.dart';
import 'package:homaination_mobile/modules/recent_services/recent%20services%20screen.dart';
import 'package:homaination_mobile/shared/components/horizontal_card.dart';
import 'package:icon_decoration/icon_decoration.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shimmer/shimmer.dart';
import '../../model/services_model.dart';
import '../../shared/components/filter_modal_bottom_sheet.dart';
import '../../shared/components/vertical_card.dart';
import '../../shared/network/local/cache_helper.dart';
import '../search_page/search_page.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  var searchCtrl = TextEditingController();


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

    return BlocProvider(
        create: (context) => HomeCubit()..getServicesData(),
        child: BlocConsumer<HomeCubit, HomeState>(

            listener: (context, state) {},
            builder: (context, state) {

        var cubit=HomeCubit.get(context);



              return Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  scrolledUnderElevation: 0.0,
                  title: Text("Homination",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold)),
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
                  ),
                  actions: [
                    CacheHelper.getData(key: "Token") != null
                        ? Padding(
                            padding: const EdgeInsets.only(
                              right: 20.0,
                            ),
                            child: CircleAvatar(
                              backgroundImage:cubit.profilePic != null
                                  ? NetworkImage(cubit.profilePic)
                                  : const AssetImage('assets/images/anonymous.png')as ImageProvider,
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(
                              right: 20.0,
                            ),
                            child: CircleAvatar(
                              child: Image.asset('assets/images/anonymous.png'),
                            ),
                          )
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
                              left: 20.0, right: 20.0, top: 40.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 15.0),
                                  child: TextField(
                                    textAlign: TextAlign.left,
                                    controller: searchCtrl,
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
                                          searchCtrl.text;
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => SearchPage(
                                                query: searchCtrl.text,service: (state as ServicesSuccess).servicesModel,
                                              ),
                                            ),
                                          );
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
                                      return  FilterModalBottomSheet();
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
                                      builder: (_) => RecentServicesScreen(servicesModel: (state as ServicesSuccess).servicesModel),
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
                                condition: state is ServicesSuccess,
                                builder: (context) {
                                  final services = (state as ServicesSuccess).servicesModel;
                                  List<Widget> cardList = services.map((service) {
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
                                      height: 200.h,
                                      initialPage: 0,
                                      padEnds: true,
                                      autoPlayInterval: const Duration(seconds: 3),
                                      reverse: false,
                                      autoPlayAnimationDuration: const Duration(seconds: 1),
                                      enableInfiniteScroll: true,
                                      autoPlayCurve: Curves.fastOutSlowIn,
                                      scrollDirection: Axis.horizontal,
                                      autoPlay: true,
                                    ),
                                  );
                                },
                                fallback: (context) => CarouselSlider(
                                    items: [
                                Shimmer.fromColors( baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,child:
                                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 20.0.h),

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
                                            width: 260.w,)),
                                          ),
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
                              left: 20.0, right: 20.0, bottom: 20.0),
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
                                        builder: (_) => RecentServicesScreen(servicesModel: (state as ServicesSuccess).servicesModel
                                      ),)
                                    );
                                  },
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              RecentServicesScreen(servicesModel: (state as ServicesSuccess).servicesModel)
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
                                  ))
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: SizedBox(
                              height: 500.h,
                              child: Scrollbar(
                                radius: const Radius.circular(10),
                                child: ConditionalBuilder(
                                  condition: state is ServicesSuccess,
                                  builder: (context) {
                                    final services = (state as ServicesSuccess).servicesModel;
                                    return ListView.separated(
                                      padding: const EdgeInsets.all(8),
                                      itemCount: services.length,
                                      separatorBuilder: (context, index) => const SizedBox(height: 10),
                                      itemBuilder: (BuildContext context, int index) {
                                        return HorizontalCard(
                                          service: services[index],
                                          avarageRate: calculateAverageRating(services[index].reviews),

                                        );
                                      },
                                    );
                                  },
                                  fallback: (context) => ListView.separated(
                                      padding: const EdgeInsets.all(8),
                                      itemCount:5,physics: const NeverScrollableScrollPhysics(),
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(height: 10),
                                      itemBuilder:
                                          (BuildContext context, int index) {

                                        return Container(
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
                                                  Shimmer.fromColors( baseColor: Colors.grey[300]!,
                                                    highlightColor: Colors.grey[100]!,
                                                    child: Container(
                                                      width: 40.w,
                                                      height: 40.w,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(15),
                                                        color:  Colors.white,
                                                      ),
                                                      clipBehavior: Clip.antiAlias,

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
                                                              Shimmer.fromColors( baseColor: Colors.grey[300]!,
                                                                highlightColor: Colors.grey[100]!,
                                                                child: Container(
                                                                  height: 16.h,width: 150.w,
                                                                  decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(15),
                                                                    color:  Colors.white,
                                                                  ),),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 6.w,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Shimmer.fromColors( baseColor: Colors.grey[300]!,
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
                                                              Shimmer.fromColors( baseColor: Colors.grey[300]!,
                                                                highlightColor: Colors.grey[100]!,
                                                                child: Container(
                                                                  height: 16.h,width: 50.w,
                                                                  decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(15),
                                                                    color:  Colors.white,
                                                                  ),),
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      )),
                                                  Shimmer.fromColors( baseColor: Colors.grey[300]!,
                                                    highlightColor: Colors.grey[100]!,

                                                    child :const  Icon(
                                                      Iconsax.heart5,
                                                      size: 20,
                                                      color: Colors.red,
                                                    ),


                                                  )
                                                ],
                                              ),
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(55.w, 6.h, 0, 0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Shimmer.fromColors( baseColor: Colors.grey[300]!,
                                                          highlightColor: Colors.grey[100]!,
                                                          child: Container(
                                                            height: 16.h,width: 80.w,
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(15),
                                                              color:  Colors.white,
                                                            ),),
                                                        ),
                                                        SizedBox(
                                                          height: 6.h,
                                                        ),
                                                        Shimmer.fromColors( baseColor: Colors.grey[300]!,
                                                          highlightColor: Colors.grey[100]!,
                                                          child: Container(
                                                            height: 16.h,width: 150.w,
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(15),
                                                              color:  Colors.white,
                                                            ),),
                                                        ),
                                                      ],
                                                    ),
                                                    Shimmer.fromColors( baseColor: Colors.grey[300]!,
                                                      highlightColor: Colors.grey[100]!,
                                                      child: RawMaterialButton(
                                                        fillColor: Colors.white,
                                                        splashColor: Colors.grey,
                                                        onPressed: () {



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
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ]));
                                      }),
                                ),
                              )),
                        ),
                        SizedBox(
                          height: 30.h,
                        )
                      ],
                    ),
                  ),
                ),
              );
            }));
  }

 /* FractionallySizedBox buildFractionallySizedBox(BuildContext context) {
    return FractionallySizedBox(
                                        heightFactor: 0.9,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(top: 10),
                                              child: Container(
                                                width: 80.w,
                                                height: 4.h,
                                                decoration: BoxDecoration(
                                                    color: Color(0xffE1E1E1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                              ),
                                            ),
                                            SizedBox(height: 32.h),
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: const Color.fromRGBO(
                                                    136, 68, 160, 1),
                                              ),
                                              clipBehavior: Clip.antiAlias,
                                            ),
                                            SizedBox(height: 25.h),
                                            Text("Set Filters",
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    color: Colors.black,
                                                    fontSize: 20.sp,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            SizedBox(height: 50.h),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 20.0.w, bottom: 15.h),
                                              child: Align(
                                                alignment: Alignment.topLeft,
                                                child: Text("Category",
                                                    style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        color: Colors.black,
                                                        fontSize: 18.sp,
                                                        fontWeight:
                                                            FontWeight.bold)),
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
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Theme.of(context)
                                                        .hintColor,
                                                  ),
                                                ),
                                                items: searchCategories
                                                    .map((item) =>
                                                        DropdownMenuItem(
                                                          value: item,
                                                          child: Text(
                                                            item,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                        ))
                                                    .toList(),
                                                value: selectedCategory,
                                                onChanged: (value) {
                                                  selectedCategory =
                                                      value as String;
                                                },
                                                buttonStyleData:
                                                    ButtonStyleData(
                                                  height: 54.h,
                                                  padding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 20.w),
                                                  width: 335.w,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            14),
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                iconStyleData:
                                                    const IconStyleData(
                                                  icon: Icon(
                                                      Iconsax.arrow_down_1),
                                                  openMenuIcon: Icon(
                                                    Iconsax.arrow_right_3,
                                                  ),
                                                  iconSize: 14,
                                                  iconEnabledColor:
                                                      Colors.black,
                                                  iconDisabledColor:
                                                      Colors.grey,
                                                ),
                                                dropdownStyleData:
                                                    const DropdownStyleData(
                                                  maxHeight: 200,
                                                ),
                                                menuItemStyleData:
                                                    const MenuItemStyleData(
                                                  height: 40,
                                                ),
                                                dropdownSearchData:
                                                    DropdownSearchData(
                                                  searchController:
                                                      textEditingController,
                                                  searchInnerWidgetHeight: 50,
                                                  searchInnerWidget:
                                                      Container(
                                                    height: 50,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      top: 8,
                                                      bottom: 4,
                                                      right: 8,
                                                      left: 8,
                                                    ),
                                                    child: TextFormField(
                                                      expands: true,
                                                      maxLines: null,
                                                      controller:
                                                          textEditingController,
                                                      decoration:
                                                          InputDecoration(
                                                        isDense: true,
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 10,
                                                          vertical: 8,
                                                        ),
                                                        hintText:
                                                            'Search Category...',
                                                        hintStyle:
                                                            const TextStyle(
                                                                fontSize: 12),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  searchMatchFn:
                                                      (item, searchValue) {
                                                    return (item.value
                                                        .toString()
                                                        .contains(
                                                            searchValue));
                                                  },
                                                ),
                                                //This to clear the search value when you close the menu
                                                onMenuStateChange: (isOpen) {
                                                  if (!isOpen) {
                                                    textEditingController
                                                        .clear();
                                                  }
                                                },
                                              ),
                                            ),
                                            SizedBox(height: 30.h),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 20.0.w, bottom: 15.h),
                                              child: Align(
                                                alignment: Alignment.topLeft,
                                                child: Text("Location",
                                                    style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        color: Colors.black,
                                                        fontSize: 18.sp,
                                                        fontWeight:
                                                            FontWeight.bold)),
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
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Theme.of(context)
                                                        .hintColor,
                                                  ),
                                                ),
                                                items: searchLocations
                                                    .map((item) =>
                                                        DropdownMenuItem(
                                                          value: item,
                                                          child: Text(
                                                            item,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                        ))
                                                    .toList(),
                                                value: selectedLocation,
                                                onChanged: (value) {
                                                  selectedLocation =
                                                      value as String;
                                                },
                                                buttonStyleData:
                                                    ButtonStyleData(
                                                  height: 54.h,
                                                  padding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 20.w),
                                                  width: 335.w,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            14),
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                iconStyleData:
                                                    const IconStyleData(
                                                  icon: Icon(
                                                      Iconsax.arrow_down_1),
                                                  openMenuIcon: Icon(
                                                    Iconsax.arrow_right_3,
                                                  ),
                                                  iconSize: 14,
                                                  iconEnabledColor:
                                                      Colors.black,
                                                  iconDisabledColor:
                                                      Colors.grey,
                                                ),
                                                dropdownStyleData:
                                                    const DropdownStyleData(
                                                  maxHeight: 200,
                                                ),
                                                menuItemStyleData:
                                                    const MenuItemStyleData(
                                                  height: 40,
                                                ),
                                                dropdownSearchData:
                                                    DropdownSearchData(
                                                  searchController:
                                                      textEditingController,
                                                  searchInnerWidgetHeight: 50,
                                                  searchInnerWidget:
                                                      Container(
                                                    height: 50,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      top: 8,
                                                      bottom: 4,
                                                      right: 8,
                                                      left: 8,
                                                    ),
                                                    child: TextFormField(
                                                      expands: true,
                                                      maxLines: null,
                                                      controller:
                                                          textEditingController,
                                                      decoration:
                                                          InputDecoration(
                                                        isDense: true,
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 10,
                                                          vertical: 8,
                                                        ),
                                                        hintText:
                                                            'Search for an item...',
                                                        hintStyle:
                                                            const TextStyle(
                                                                fontSize: 12),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  searchMatchFn:
                                                      (item, searchValue) {
                                                    return (item.value
                                                        .toString()
                                                        .contains(
                                                            searchValue));
                                                  },
                                                ),
                                                //This to clear the search value when you close the menu
                                                onMenuStateChange: (isOpen) {
                                                  if (!isOpen) {
                                                    textEditingController
                                                        .clear();
                                                  }
                                                },
                                              ),
                                            ),
                                            SizedBox(height: 30.h),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 20.0.w, bottom: 15.h),
                                              child: Align(
                                                alignment: Alignment.topLeft,
                                                child: Text("Budget",
                                                    style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        color: Colors.black,
                                                        fontSize: 18.sp,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 20.w,
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.topLeft,
                                                  child: Text("From",
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'Poppins',
                                                          color: Colors.black,
                                                          fontSize: 16.sp,
                                                          fontWeight:
                                                              FontWeight
                                                                  .bold)),
                                                ),
                                                SizedBox(
                                                  width: 20.w,
                                                ),
                                                Icon(Iconsax.wallet_2),
                                                PriceRangeTextField(
                                                  controller:
                                                      _minPriceRangeController,
                                                ),
                                                SizedBox(
                                                  width: 20.w,
                                                ),
                                                Align(
                                                  alignment: Alignment.center,
                                                  child: Text("to",
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'Poppins',
                                                          color: Colors.black,
                                                          fontSize: 16.sp,
                                                          fontWeight:
                                                              FontWeight
                                                                  .bold)),
                                                ),
                                                SizedBox(
                                                  width: 20.w,
                                                ),
                                                Icon(Iconsax.wallet_3),
                                                PriceRangeTextField(
                                                  controller:
                                                      _maxPriceRangeController,
                                                ),
                                                SizedBox(
                                                  width: 20.w,
                                                ),
                                              ],
                                            ),
                                            Expanded(
                                              child: Align(
                                                alignment: FractionalOffset
                                                    .bottomCenter,
                                                child: Container(
                                                  width: double.infinity,
                                                  alignment: Alignment.center,
                                                  height: 110.h,
                                                  decoration: BoxDecoration(
                                                      color:
                                                          Color(0xffE1E1E1),
                                                      borderRadius:
                                                          BorderRadius.vertical(
                                                              top: Radius
                                                                  .circular(
                                                                      12))),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .fromLTRB(
                                                        16, 16, 16, 20),
                                                    child: SizedBox(
                                                      height: 54.h,
                                                      width: 400.w,
                                                      child: TextButton(
                                                          style: ButtonStyle(
                                                              shape: MaterialStateProperty
                                                                  .all<
                                                                      RoundedRectangleBorder>(
                                                                RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            12.0)),
                                                              ),
                                                              backgroundColor:
                                                                  MaterialStateProperty
                                                                      .all(
                                                                          buttonColor)),
                                                          onPressed: () {},
                                                          child: Text(
                                                            "Apply Filters",
                                                            style: GoogleFonts.poppins(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 16,
                                                                color: Colors
                                                                    .white),
                                                          )),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ));
  }*/
}
