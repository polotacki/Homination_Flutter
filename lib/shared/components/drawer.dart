import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:homaination_mobile/model/user_model.dart';
import 'package:homaination_mobile/modules/auth/login_screen.dart';
import 'package:homaination_mobile/modules/notification_settings/notification_settings_screen.dart';
import 'package:homaination_mobile/shared/network/local/cache_helper.dart';

import '../../bloc/cubits/login_cubit/login_cubit.dart';
import '../../modules/edit_profile.dart';
import '../../modules/proposals_history/proposals_history_screen.dart';
import '../style/constants.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? token = CacheHelper.getData(key: 'Token');

    return Drawer(
      child: token != null
          ? ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://example.com/profile_image.jpg'),
                        radius: 30,
                      ),
                      SizedBox(height: 10),
                      Text(
                        '',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Edit Profile'),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => EditProfile()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.apps),
                  title: Text('Applications'),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => ProposalsHistory()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.notifications),
                  title: Text('Notification Settings'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => NotificationSettingsScreen()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.star),
                  title: Text('Rate App'),
                  onTap: () {
                    // TODO: Implement rate app functionality
                  },
                ),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Logout'),
                  onTap: () {
                    CacheHelper.removeData(key: "Token");

                    print(CacheHelper.getData(key: "Token"));
                  },
                ),
              ],
            )
          : Center(
              child: Container(padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),decoration: BoxDecoration(color: buttonColor,borderRadius: BorderRadius.circular(18)),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => LoginScreen()));
                  },
                  child: Text(
                    "login",
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold,color: Colors.white,
                        fontSize: 18.sp),
                  ),
                ),
              ),
            ),
    );
  }
}
