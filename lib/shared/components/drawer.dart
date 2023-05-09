
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homaination_mobile/modules/auth/login_screen.dart';
import 'package:homaination_mobile/modules/notification_settings/notification_settings_screen.dart';
import 'package:homaination_mobile/shared/network/local/cache_helper.dart';

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
          ? ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage:
                  CacheHelper.getData(key: "profilePic") != null
                      ? NetworkImage(
                      CacheHelper.getData(key: "profilePic"))
                      : const AssetImage('assets/images/anonymous.png')
                  as ImageProvider,
                  radius: 40,
                ),
                const SizedBox(height: 10),
                Text(
                  CacheHelper.getData(key: "name") ?? "",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Edit Profile'),
            selected: cubit.state == SelectProfileState,
            onTap: () {
              cubit.selectProfile();
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const EditProfile()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.apps),
            title: const Text('Applications'),
            selected: cubit.state == SelectApplicationsState,
            onTap: () {
              cubit.selectApplications();
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const ProposalsHistory()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notification Settings'),
            selected: cubit.state == SelectNotificationsState,
            onTap: () {
              cubit.selectNotifications();
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => NotificationSettingsScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.star),
            title: const Text('Rate App'),
            selected: cubit.state == SelectRateState,
            onTap: () {
              cubit.selectRate();
              // TODO: Implement rate app functionality
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            selected: cubit.state == SelectLogoutState,
            onTap: () {
              cubit.selectLogout(context);

            },
          ),
        ],
      )
          : Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(18),
          ),
          child: TextButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => LoginScreen()));
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
