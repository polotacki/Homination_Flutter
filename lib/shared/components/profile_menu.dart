import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:homaination_mobile/shared/style/constants.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    this.press,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric( vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(


          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          backgroundColor:  Colors.white,
        ),
        onPressed: press,
        child: Row(
          children: [
            Icon(icon,color: buttonColor,),
            const SizedBox(width: 20),
            Expanded(child: Text(text,style: TextStyle(fontFamily: "Poppins",fontSize: 16.sp,fontWeight:FontWeight.normal,color: Colors.black ),)),
            const Icon(Icons.arrow_forward_ios,color: Color(0xff6a6a6a),),
          ],
        ),
      ),
    );
  }
}