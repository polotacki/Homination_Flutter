import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';


import '../../data/service_application_data.dart';
import '../../model/service_application_model.dart';
import '../../shared/components/application_card.dart';
import '../../shared/components/overall_radial_bar_chart.dart';


class ProposalsHistory extends StatelessWidget {
  const ProposalsHistory({super.key});



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(
          'Proposals History',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Iconsax.arrow_left_24),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            OverallRadialBarChart(applications: constructionApplications),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: constructionApplications.length,
              itemBuilder: (BuildContext context, int index) {
                String key = constructionApplications.keys.elementAt(index);
                ServiceApplication application = constructionApplications[key]!;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ApplicationCard(
                    company: application.company,
                    jobTitle: application.jobTitle,
                    city: application.city,
                    status: application.status,
                    price: application.price,
                    companyImage: application.companyImage
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
