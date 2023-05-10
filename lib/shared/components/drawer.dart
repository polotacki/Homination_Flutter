import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homaination_mobile/modules/auth/login_screen.dart';
import 'package:homaination_mobile/modules/notification_settings/notification_settings_screen.dart';
import 'package:homaination_mobile/shared/network/local/cache_helper.dart';
import 'package:iconsax/iconsax.dart';

import '../../bloc/cubits/drawer_cubit/drawer_cubit.dart';
import '../../modules/edit_profile.dart';
import '../../modules/proposals_history/proposals_history_screen.dart';
import '../style/constants.dart';

class MyDrawer extends StatelessWidget {
  final DrawerCubit cubit = DrawerCubit();

  @override
  Widget build(BuildContext context) {
    String? token = CacheHelper.getData(key: 'Token');

    return Drawer(
      child: token != null
          ? Padding(
              padding: EdgeInsets.only(top: 100.h, left: 30.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: CacheHelper.getData(key: "profilePic") !=
                            null
                        ? NetworkImage(CacheHelper.getData(key: "profilePic"))
                        : const AssetImage('assets/images/anonymous.png')
                            as ImageProvider,
                    radius: 40,
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    CacheHelper.getData(key: "name") ?? "",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    CacheHelper.getData(key: "email") ?? "",
                    style: TextStyle(
                      color: Color(0xff6A6A6A),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: 46.h),
                  ListTile(
                    leading: Icon(
                      Icons.account_circle,
                      color: Color(0xffFF5441),
                      size: 36.h,
                    ),
                    title: Text(
                      'Edit Profile',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    selected: cubit.state == SelectProfileState,
                    onTap: () {
                      cubit.selectProfile();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const EditProfile()));
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Iconsax.clock5,
                      color: Color(0xffFF9087),
                      size: 36,
                    ),
                    title: Text(
                      'Applications',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                    selected: cubit.state == SelectApplicationsState,
                    onTap: () {
                      cubit.selectApplications();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const ProposalsHistory()));
                    },
                  ),
                  ListTile(
                    leading:   FaIcon(FontAwesomeIcons.gear,
                      color: Color(0xff2CB9B5),
                      size: 36,
                    ),
                    title: Text(
                      'Notification Settings',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                    selected: cubit.state == SelectNotificationsState,
                    onTap: () {
                      cubit.selectNotifications();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => NotificationSettingsScreen()));
                    },
                  ),
                  ListTile(
                    leading:Icon(
                      Icons.favorite,
                      color: Color(0xffFE33BF),
                      size: 40.h,
                    ),
                    title: Text(
                      'Rate App',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                    selected: cubit.state == SelectRateState,
                    onTap: () {
                      cubit.selectRate();
                      // TODO: Implement rate app functionality
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Iconsax.back_square,
                      color: Color(0xffFF454C),
                      size: 40.h,
                    ),
                    title: Text(
                      'Logout',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                    selected: cubit.state == SelectLogoutState,
                    onTap: () {
                      cubit.selectLogout(context);
                    },
                  ),
                ],
              ),
            )
          : Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: BoxDecoration(
                  color: buttonColor,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => LoginScreen()));
                  },
                  child: Text(
                    "login",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18.sp,
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
