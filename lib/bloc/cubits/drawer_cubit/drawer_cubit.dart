import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:homaination_mobile/layout/home_layout.dart';

import '../../../shared/network/local/cache_helper.dart';


part 'drawer_state.dart';


class DrawerCubit extends Cubit<DrawerState> {
  DrawerCubit() : super(DrawerInitial());

  void selectProfile() => emit(SelectProfileState());

  void selectApplications() => emit(SelectApplicationsState());

  void selectNotifications() => emit(SelectNotificationsState());

  void selectRate() => emit(SelectRateState());

  void selectLogout(context) {
    CacheHelper.removeData(key: "Token");
    print(CacheHelper.getData(key: "Token"));
    emit(SelectLogoutState());
    Navigator.pop(context); // Pop the drawer
    Navigator.pushReplacement(context,   MaterialPageRoute(builder: (context) => const HomeLayout()),

    );
  }

  }
