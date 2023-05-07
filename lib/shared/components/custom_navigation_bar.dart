import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../style/constants.dart';

class CustomNavBar extends StatefulWidget {
  final List<String> children;
  final int currentIndex;
  final ValueChanged<int> onTap;

  CustomNavBar({
    required this.children,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  CustomNavigationBar createState() =>
      CustomNavigationBar();
}

class CustomNavigationBar extends State<CustomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: widget.children.asMap().entries.map(
            (entry) {
          final index = entry.key;
          final child = entry.value;
          final isActive = index == widget.currentIndex;

          return GestureDetector(
            onTap: () {
              widget.onTap(index);
            },
            child: Container(
              width: 110.w,
              alignment: Alignment.center,
              height: 50.h,
              child: Text(child,
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      color:isActive ?Colors.white:Color(0xFF6A6A6A),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400)),
              decoration:
                  BoxDecoration(
                color: isActive ? buttonColor:Colors.white,
                borderRadius:
                BorderRadius.circular(12)),

            ),
          );
        },
      ).toList(),
    );
  }
}