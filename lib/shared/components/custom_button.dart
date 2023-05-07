
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../style/constants.dart';

class CustomButton extends StatelessWidget {
  final onPress;

  final text;

  final padding;

  final fontWeight;

   CustomButton({Key? key,required this.onPress, required this.text,required this.padding,required this.fontWeight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Padding(
      padding: padding,
      child: SizedBox(
        height: 57.h,
        width: 400,
        child: TextButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all<
                    RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                ),
                backgroundColor:
                MaterialStateProperty.all(buttonColor)),
            onPressed: onPress,
            child: Text(
              text,
              style: GoogleFonts.poppins(
                  fontWeight: fontWeight,
                  fontSize: 16,
                  color: Colors.white),
            )),
      ),
    );
  }
}
