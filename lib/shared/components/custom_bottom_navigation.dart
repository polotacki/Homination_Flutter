import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

import '../../bloc/cubits/app_cupit/app_cubit.dart';
import '../style/constants.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    super.key, context
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {

        },
        builder: (BuildContext context, AppStates state) {
          return Container(decoration: const BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black45,
                    blurRadius: 8, offset: Offset(2, 4)
                ),
              ]),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(18), topRight: Radius.circular(18)),
              child: BottomNavigationBar(
                elevation: 8,
                type: BottomNavigationBarType.fixed,
                // Fixed
                backgroundColor: const Color(0xFFE9E9E9),
                currentIndex: AppCubit
                    .get(context)
                    .currentIndex,
                onTap: (index) {
                  AppCubit.get(context).changeIndex(index);
                  print(index);
                },
                showSelectedLabels: false,
                showUnselectedLabels: false,
                unselectedItemColor: const Color(0xFF292D32),
                items: [
                  BottomNavigationBarItem(
                      activeIcon: ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: const [0.0, 0.5],
                            colors: colors,
                            tileMode: TileMode.mirror,
                          ).createShader(bounds);
                        },
                        child: const Icon(Iconsax.home),
                      ),
                      icon: const Icon(Iconsax.home),
                      label: 'Home'),
                  BottomNavigationBarItem(
                      activeIcon: ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: const [0.0, 0.5],
                            colors: colors,
                            tileMode: TileMode.mirror,
                          ).createShader(bounds);
                        },
                        child: const Icon(Iconsax.message),
                      ),
                      icon: const Icon(Iconsax.message),
                      label: 'Contracts'),
                  BottomNavigationBarItem(
                      activeIcon: ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: const [0.0, 0.5],
                            colors: colors,
                            tileMode: TileMode.mirror,
                          ).createShader(bounds);
                        },
                        child: const Icon(Iconsax.heart),
                      ),
                      icon: const Icon(Iconsax.heart),
                      label: 'heart'),
                  BottomNavigationBarItem(
                    activeIcon: ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: const [0.0, 0.5],
                          colors: colors,
                          tileMode: TileMode.mirror,
                        ).createShader(bounds);
                      },
                      child: const Icon(Iconsax.profile_circle),
                    ),
                    icon: const Icon(Iconsax.profile_circle),
                    label: 'Profile',
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}