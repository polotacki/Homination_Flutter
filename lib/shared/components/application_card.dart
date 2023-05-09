import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ApplicationCard extends StatelessWidget {
  ApplicationCard(
      {Key? key,
      required this.city,
      required this.company,
      required this.jobTitle,
      required this.status,
      required this.price,
      required this.companyImage})
      : super(key: key);
  final String companyImage;

  final String city;
  final String company;
  final String jobTitle;
  final String status;
  final String price;

  final _iconSizeWidth = 50.0.w;
  final _iconSizeHeight = 50.0.w;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 10.w),
      child: Container(
        width: 335.w,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            const BoxShadow(
                color: Color(0x1a403b4b),
                offset: Offset(0, 10),
                blurRadius: 35,
                blurStyle: BlurStyle.normal,
                spreadRadius: -10.0)
          ],
          color: Colors.white,
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: 20.0.h, left: 20.w, right: 20.w, bottom: 25.h),
                  child: Container(
                      width: _iconSizeWidth,
                      height: _iconSizeHeight,clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color.fromRGBO(68, 96, 160, 1),
                      ),
                      child: Image.network(
                        companyImage,
                        fit: BoxFit.fill,
                      )),
                ),
                Expanded(
                  child: ListTile(
                    title: Text(company,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.grey,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w300)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(jobTitle,
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.black,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600)),
                        const SizedBox(height: 4.0),
                        Text(city,
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.grey,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w300)),
                        const SizedBox(height: 4.0),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.more_vert),
                      onPressed: () {},
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    width: 135.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: status == 'Accepted'
                          ? const Color(0xffDDFFE9)
                          : status == 'Rejected'
                              ? const Color(0xffFFD4E5)
                              : Colors.white,
                    ),
                    child: Text(status,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: status == 'Accepted'
                                ? const Color(0xff1ED760)
                                : status == 'Rejected'
                                    ? const Color(0xffEA4C89)
                                    : const Color(0xff1976D2),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
                SizedBox(width: 40.w),
                Text("EGP $price/meter",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: status == 'Accepted'
                            ? const Color(0xff1ED760)
                            : status == 'Rejected'
                                ? const Color(0xffEA4C89)
                                : const Color(0xff1976D2),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
