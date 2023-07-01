import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../model/proposal_history.dart';
import '../../shared/style/constants.dart';

class RequestDescriptionScreen extends StatelessWidget {
  final RequestDescription requestDescription;

  const RequestDescriptionScreen({required this.requestDescription, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request Description'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Container(decoration: BoxDecoration(
              color: Color(0xffD9D9D9), borderRadius: BorderRadius.circular(18),),padding: EdgeInsets.only(top: 18,left: 18,right: 18) ,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [


                Text(
                  'Property in Meter: ${requestDescription.propertyInMeter}',
                  style: TextStyle(fontFamily: "Poppins",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Location: ${requestDescription.location}',
                  style: TextStyle(fontFamily: "Poppins",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 16.0), Text(
                  'Property Type: ${requestDescription.propertyType}',
                  style: TextStyle(fontFamily: "Poppins",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 32.0),
                Text(
                  'Request description:',
                  style: TextStyle(fontFamily: "Poppins",
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 32.0),
                Text(
                  'style: ${requestDescription.requestDesc.style}',
                  style: TextStyle(fontFamily: "Poppins",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 16.0),
                Text(
                  'color: ${requestDescription.requestDesc.color}',
                  style: TextStyle(fontFamily: "Poppins",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 16.0),
                Text(
                  'materials: ${requestDescription.requestDesc.materials}',
                  style: TextStyle(fontFamily: "Poppins",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 16.0),
                Text(
                  'total cost: ${requestDescription.requestDesc.totalCost}',
                  style: TextStyle(fontFamily: "Poppins",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 16.0),
                Text(
                  'time frame: ${requestDescription.requestDesc.timeFrame}',
                  style: TextStyle(fontFamily: "Poppins",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500),
                ),

                SizedBox(height: 8.0),
                SizedBox(height: 16.0),
                Text(
                  'Property Type: ${requestDescription.propertyType}',
                  style: TextStyle(fontFamily: "Poppins",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Location: ${requestDescription.location}',
                  style: TextStyle(fontFamily: "Poppins",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 16.0),

                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
                  child: SizedBox(
                    height: 54.h,
                    width: 400,
                    child: TextButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(12.0)),
                            ),
                            backgroundColor:
                            MaterialStateProperty.all(
                                buttonColor)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Okay",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}