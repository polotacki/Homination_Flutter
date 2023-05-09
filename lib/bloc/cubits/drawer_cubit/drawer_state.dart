part of 'drawer_cubit.dart';

@immutable
abstract class DrawerState {}

class DrawerInitial extends DrawerState {}

class SelectProfileState extends DrawerState {}

class SelectApplicationsState extends DrawerState {}

class SelectNotificationsState extends DrawerState {}

class SelectRateState extends DrawerState {}

class SelectLogoutState extends DrawerState {}
