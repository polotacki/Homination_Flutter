import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../modules/chat_screen/chat_screen.dart';
import '../../../modules/favorite_screen/favorite_screen.dart';
import '../../../modules/home_screen/home_screen.dart';
import '../../../modules/profile/profile_screen.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitial());
  int currentIndex = 0;

  List<Widget> screens = [
     HomeScreen(),
    const ChatScreen(),
    const FavoriteScreen(),
    const ProfileScreen(),
  ];
  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }
  static AppCubit get(context) => BlocProvider.of(context);
}
