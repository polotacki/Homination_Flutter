import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homaination_mobile/shared/components/drawer.dart';

import '../bloc/cubits/app_cupit/app_cubit.dart';
import '../model/services_mod.dart';
import '../shared/components/custom_bottom_navigation.dart';


class HomeLayout extends StatelessWidget {
  const HomeLayout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {

        },
        builder: (BuildContext context, AppStates state) {
          AppCubit cubit = AppCubit.get(context);

          return Scaffold(body: cubit.screens[cubit.currentIndex]
              ,drawer: MyDrawer(), bottomNavigationBar: CustomBottomNavigationBar());
        }
        );
  }

}
