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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ID: ${requestDescription.id}',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            Text(
              'Property in Meter: ${requestDescription.propertyInMeter}',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            Text(
              'Request Description: ${requestDescription.requestDesc}',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            Text(
              'Property Type: ${requestDescription.propertyType}',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            Text(
              'Location: ${requestDescription.location}',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Spacer(),
            TextButton(
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
          ],
        ),
      ),
    );
  }
}