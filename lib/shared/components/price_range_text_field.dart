import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PriceRangeTextField extends StatelessWidget {
  final TextEditingController controller;


  const PriceRangeTextField({Key? key, required this.controller, })
      : super(key: key);

  @override
  Widget build(BuildContext context) {


    return Padding(
      padding:  EdgeInsets.only(left: 5.0.w),
      child: SizedBox(
        width: 65.w,
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            prefixText:   "EGP ",
            prefixStyle: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.black,
              fontSize: 14.sp,
              fontWeight:
              FontWeight.bold)
          ,border: InputBorder.none,
            hintText: 'price',hintStyle:TextStyle(
      fontFamily: 'Poppins',
      color: Colors.grey,
      fontSize: 14.sp,
      fontWeight:
      FontWeight.bold) ,),



          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
          ],
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter a price range';
            }
            return null;
          },
        ),
      ),
    );
  }
}
