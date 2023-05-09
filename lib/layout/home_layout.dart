import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../bloc/cubits/app_cupit/app_cubit.dart';
import '../shared/components/custom_bottom_navigation.dart';
import '../shared/components/drawer.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, AppStates state) {},
      builder: (BuildContext context, AppStates state) {
        AppCubit cubit = AppCubit.get(context);

        return OfflineBuilder(
          connectivityBuilder: (
            BuildContext context,
            ConnectivityResult connectivity,
            Widget child,
          ) {
            final bool connected = connectivity != ConnectivityResult.none;
            return Stack(
              children: [
                Scaffold(
                  body: cubit.screens[cubit.currentIndex],
                  drawer: MyDrawer(),
                  bottomNavigationBar: const CustomBottomNavigationBar(),
                ),
                Visibility(
                  visible: !connected,
                  child: Positioned(
                    top: 87,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      color: Colors.black54,
                      child: Row(
                        children: const [   Padding(
                          padding: EdgeInsets.only(top: 15.0,bottom: 15,left: 15),
                          child: Icon(Icons.error_outline,color: Colors.amber,)
                        ),
                          Padding(
                            padding: EdgeInsets.only(top: 15.0,bottom: 15,left: 15),
                            child: Text(
                              'OFFLINE Mode',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Poppins",
                                fontSize: 14.0,    decoration: TextDecoration.none,

                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
          child: Scaffold(
            body: cubit.screens[cubit.currentIndex],
            drawer: MyDrawer(),
            bottomNavigationBar: const CustomBottomNavigationBar(),
          ),
        );
      },
    );
  }
}
