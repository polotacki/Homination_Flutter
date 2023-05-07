import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';


import '../../data/service_application_data.dart';
import '../../model/service_application_model.dart';
import '../../shared/components/application_card.dart';


class ProposalsHistory extends StatelessWidget {
  const ProposalsHistory({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Proposals History',style:TextStyle(
            fontFamily: 'Poppins',
            color: Colors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold) ,),centerTitle: true,leading: IconButton(icon: Icon(Iconsax.arrow_left_24,),onPressed: (){Navigator.of(context).pop();}),
      ),
      body: ListView.builder(
        itemCount: constructionApplications.length,
        itemBuilder: (BuildContext context, int index) {  String key = constructionApplications.keys.elementAt(index);
        ServiceApplication application = constructionApplications[key]!;
          return ApplicationCard(
            company: application.company,
            jobTitle: application.jobTitle,
            city: application.city,
            status: application.status,
            price: application.price,
            companyImage: application.companyImage,
          );/*ListTile(
            title: Text(jobApplications[index].company,
                style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.grey,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w300)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(jobApplications[index].jobTitle,
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600)),
                SizedBox(height: 4.0),
                Text(jobApplications[index].status,
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.grey,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w300)),
                SizedBox(height: 4.0),
                Divider(height: 1.0, color: Colors.grey),
              ],
            ),
            trailing: Text(jobApplications[index].status),
          );*/
        },
      ),
    );
  }
}
