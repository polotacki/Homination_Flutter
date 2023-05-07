import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homaination_mobile/layout/home_layout.dart';
import 'package:homaination_mobile/modules/auth/login_screen.dart';
import 'package:homaination_mobile/shared/network/local/cache_helper.dart';
import 'package:homaination_mobile/shared/style/themes.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bloc/cubits/app_cupit/app_cubit.dart';
import 'bloc/simple_bloc_observer.dart';
import 'modules/on_boarding/on_boarding_screen.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocOBserver();
 await CacheHelper.init();
  bool? isDark = CacheHelper.getData(key: 'isDark');
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  Widget widget;
  if (onBoarding != null) {
   widget = HomeLayout();
  }else{
    widget= OnBoardingScreen();
  }
print("initScreen = $widget");

  runApp(MyApp(isDark: isDark, startScreen: widget,));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.isDark, required this.startScreen})
      : super(key: key);

  final bool? isDark;
  final Widget startScreen;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context)
    =>
        AppCubit()
    ,
    child: BlocConsumer<AppCubit, AppStates>(
    listener: (BuildContext context, AppStates state) {},
    builder: (BuildContext, AppStates state) {
    return ScreenUtilInit(
    designSize: const Size(375, 812),
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (context, child) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,
    darkTheme: darkTheme ,
    theme: lightTheme,
    home: AnimatedSplashScreen.withScreenFunction(
    splash: Lottie.asset(
    "assets/animations/loading.json"),
    backgroundColor: Theme.of(context).canvasColor,
    screenFunction: () async {
    await Future.delayed(
    const Duration(seconds: 0));
    return startScreen;
    },
    splashTransition:
    SplashTransition.rotationTransition,
    pageTransitionType: PageTransitionType.fade,
    animationDuration: const Duration(seconds: 0),
      ));
    });

  }

  )

  );
}}
