import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:homaination_mobile/bloc/cubits/custom_modal_bottom_sheet_cubit/custom_modal_bottom_sheet_cubit.dart';
import 'package:homaination_mobile/bloc/cubits/drawer_cubit/drawer_cubit.dart';
import 'package:homaination_mobile/bloc/cubits/filter_cubit/filter_cubit.dart';
import 'package:homaination_mobile/bloc/cubits/login_cubit/login_cubit.dart';
import 'package:homaination_mobile/bloc/cubits/search_cubit/search_cubit.dart';
import 'package:homaination_mobile/layout/home_layout.dart';
import 'package:homaination_mobile/shared/network/local/cache_helper.dart';
import 'package:homaination_mobile/shared/style/themes.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'bloc/cubits/app_cupit/app_cubit.dart';
import 'bloc/cubits/home_cubit/home_cubit.dart';
import 'bloc/simple_bloc_observer.dart';
import 'modules/on_boarding/on_boarding_screen.dart';

Future<void> main() async {
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocOBserver();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getData(key: 'isDark');
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  Widget widget;
  if (onBoarding != null) {
    widget = const HomeLayout();
  } else {
    widget = const OnBoardingScreen();
  }
  print("initScreen = $widget");

  runApp(
    MultiProvider(
      providers: [
        BlocProvider<HomeCubit>(
          create: (context) => HomeCubit(),
        ),
        BlocProvider<CustomModalBottomSheetCubit>(
          create: (context) => CustomModalBottomSheetCubit(),
        ),
        BlocProvider<DrawerCubit>(
          create: (context) => DrawerCubit(),
        ),
        BlocProvider<FilterCubit>(
          create: (context) => FilterCubit(),
        ),
        BlocProvider<LoginCubit>(
          create: (context) => LoginCubit(),
        ),

      ],
      child: MyApp(isDark: isDark, startScreen: widget),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.isDark, required this.startScreen})
      : super(key: key);

  final bool? isDark;
  final Widget startScreen;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AppCubit(),
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
                        darkTheme: darkTheme,
                        theme: lightTheme,
                        home: AnimatedSplashScreen.withScreenFunction(
                          splash:
                              Container(width: 200,
                                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                                  children: [Image.asset("assets/images/logo.png",fit: BoxFit.fill),SizedBox(height: 15,),
                                   Text("Homination",style: TextStyle(fontFamily: "Poppins",fontWeight: FontWeight.bold,fontSize: 30))
                                   , SizedBox(width:60,height:60,child: Lottie.asset("assets/animations/loading.json")),
                                  ],
                                ),
                              ),
                          backgroundColor: Theme.of(context).canvasColor,
                          screenFunction: () async {
                            await Future.delayed(const Duration(seconds: 100));
                            return startScreen;
                          },
                          splashTransition: SplashTransition.rotationTransition,
                          pageTransitionType: PageTransitionType.fade,
                          animationDuration: const Duration(seconds: 0),
                        ));
                  });
            }));
  }
}
