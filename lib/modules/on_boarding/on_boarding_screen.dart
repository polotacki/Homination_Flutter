import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homaination_mobile/shared/components/components.dart';
import 'package:homaination_mobile/shared/components/custom_button.dart';
import 'package:homaination_mobile/shared/style/constants.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../bloc/cubits/app_cupit/app_cubit.dart';
import '../../data/on_boarding.dart';
import '../../layout/home_layout.dart';
import '../../model/on_boarding_model.dart';
import '../../shared/network/local/cache_helper.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  double _currentPageIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController();
    super.initState();
  }

  void submit(){
    CacheHelper.saveData(key: "onBoarding", value: true).then((value) {
      if (value ) {
      Navigator.pushReplacement(context,  MaterialPageRoute(builder: (context) => const HomeLayout()));

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          body: SafeArea(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: Column(
                children: [
                  skipButton(context: context),
                  SizedBox(height: 35.h),
                  Expanded(
                    child: PageView.builder(
                      controller: _controller,
                      physics: const BouncingScrollPhysics(),
                      itemCount: 3,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPageIndex = index.toDouble();
                        });
                      },
                      itemBuilder: (context, index) {
                        final OnBoardingData element = onBoardingData[index];
                        return onBoardingElement(
                            subTitle: element.body,
                            title: element.title,
                            lottiePath: element.image);
                      },
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Column(
                    children: [
                      AnimatedSmoothIndicator(
                        duration: const Duration(milliseconds: 500),
                        activeIndex: _currentPageIndex.toInt(),
                        count: 3,
                        effect: WormEffect(
                          dotColor: Colors.deepPurple,
                          activeDotColor: buttonColor,
                          dotWidth: 35.w,
                          dotHeight: 10.h,
                          spacing: 20.w,
                          type: WormType.normal,
                        ),
                        curve: Curves.easeOutCubic,
                      ),
                      SizedBox(height: 15.h),
                      _currentPageIndex + 1 == onBoardingData.length
                          ? CustomButton(
                              onPress: () {
                                submit();
                              },
                              text: "Let’s Get Started",
                              fontWeight: FontWeight.normal,
                              padding:
                                  const EdgeInsets.fromLTRB(49, 60, 49, 60),
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(30, 60, 30, 59),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        _controller.jumpToPage(2);
                                      },
                                      style: TextButton.styleFrom(
                                        elevation: 0,
                                        textStyle: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13.w,
                                        ),
                                      ),
                                      child: const Text(
                                        "SKIP",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        _controller.nextPage(
                                          duration:
                                              const Duration(milliseconds: 200),
                                          curve: Curves.easeIn,
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: buttonColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        elevation: 0,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 20),
                                        textStyle: TextStyle(fontSize: 13.w),
                                      ),
                                      child: const Text("NEXT",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                  ]))
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget skipButton({required context}) {
  return Align(
    alignment: AlignmentDirectional.topEnd,
    child: GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HomeLayout()));
      },
      child: Container(
        width: 80.w,
        height: 40.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40), color: Colors.deepPurple),
        child: Center(
          child: Text(
            "Skip",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    ),
  );
}

Widget onBoardingElement(
    {required lottiePath, required title, required subTitle}) {
  return SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: Column(
      children: [
        Lottie.asset(
          lottiePath,
          width: 300.w,
          height: 300.h,
        ),
        SizedBox(height: 30.h),
        Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 34.sp,
              color: Colors.black),
        ),
        SizedBox(height: 15.h),
        Text(
          subTitle,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.normal,
              fontSize: 16.sp,
              color: Colors.black),
        ),
      ],
    ),
  );
}
