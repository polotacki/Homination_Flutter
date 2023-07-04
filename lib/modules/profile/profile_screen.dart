import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../bloc/cubits/app_cupit/app_cubit.dart';
import '../../layout/home_layout.dart';
import '../../shared/components/profile_menu.dart';
import '../../shared/components/profile_pic.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../shared/style/constants.dart';
import '../auth/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          String? token = CacheHelper.getData(key: 'Token');
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              scrolledUnderElevation: 0.0,
              title: Text(
                'Settings',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.black,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold),
              ) .animate()
                  .fadeIn(duration: 300.ms),
              centerTitle: true,

            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(visible:  (token != null),
                      child: Text(
                        "Account",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xff6a6a6a)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Visibility(visible:  (token == null),
                      child:  ProfileMenu(
                        text: "Log In",
                        icon: Iconsax.login,
                        press: () {       Navigator.push(context,
                            MaterialPageRoute(builder: (_) => LoginScreen()));},
                      ),
                    ),
                    Visibility(visible:  (token != null),
                      child: ProfileMenu(
                        text: "Personal information",
                        icon: Iconsax.profile_circle,
                        press: () => {},
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "General",
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff6a6a6a)),
                    ),
                    const SizedBox(height: 20),
                    ProfileMenu(
                      text: "Notifications",
                      icon: Iconsax.notification,
                      press: () {},
                    ),
                    ProfileMenu(
                      text: "Security",
                      icon: Iconsax.shield_tick,
                      press: () {},
                    ),
                    ProfileMenu(
                      text: "Language",
                      icon: Iconsax.language_square,
                      press: () {},
                    ),
                    const DarkMode(),
                    ProfileMenu(
                      text: "Help Center",
                      icon: Iconsax.warning_2,
                      press: () {},
                    ),
                    ProfileMenu(
                      text: "Rate Us",
                      icon: Iconsax.star,
                      press: () {},
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "About",
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff6a6a6a)),
                    ),
                    const SizedBox(height: 20),
                    ProfileMenu(
                      text: "Privacy & Policy",
                      icon: Iconsax.shield_tick,
                      press: () {},
                    ),
                    ProfileMenu(
                      text: "Terms of Services",
                      icon: Iconsax.key_square,
                      press: () {},
                    ),
                    ProfileMenu(
                      text: "About Us",
                      icon: Iconsax.warning_2,
                      press: () {},
                    ),


                    Visibility(visible:  (token != null),
                      child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextButton(
                      style: TextButton.styleFrom(
                        shape:
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                        backgroundColor: Colors.white,
                      ),
                      onPressed: () {    CacheHelper.removeData(key: "Token");
                      CacheHelper.removeData(key: "Token");
                      CacheHelper.removeData(key: "profilePic");
                      CacheHelper.removeData(key: "name");
                      CacheHelper.removeData(key: "email");
                      CacheHelper.removeData(key: "id");

                      Navigator.pushReplacement(context,   MaterialPageRoute(builder: (context) => const HomeLayout()));
                      },
                      child: Row(
                        children: [
                          Icon(
                            Iconsax.moon,
                            color:  Colors.redAccent,
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                              child: Text(
                                "Log Out",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.redAccent),
                              )),

                        ],
                      ),
                  ),
                ),
                    )
                  ].animate( interval: 100.ms).fadeIn(duration: 900.ms),
                ),
              ),
            ),
          );
        });
  }
}

class DarkMode extends StatefulWidget {
  const DarkMode({
    Key? key,
  }) : super(key: key);

  @override
  State<DarkMode> createState() => _DarkModeState();
}

class _DarkModeState extends State<DarkMode> {
  bool _darkModeEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          backgroundColor: Colors.white,
        ),
        onPressed: () {},
        child: Row(
          children: [
            Icon(
              Iconsax.moon,
              color: buttonColor,
            ),
            const SizedBox(width: 20),
            Expanded(
                child: Text(
              "Dark Mode",
              style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.normal,
                  color: Colors.black),
            )),
            Switch(
              value: _darkModeEnabled,
              onChanged: (value) => setState(() => _darkModeEnabled = value),
              activeColor: Colors.white,
              activeTrackColor: const Color(0xff4CA6A8),
              inactiveTrackColor: const Color(0xffE9E9E9),
              inactiveThumbColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
