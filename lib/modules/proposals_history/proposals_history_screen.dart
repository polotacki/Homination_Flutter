
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';


import '../../bloc/cubits/proposal_history/proposal_history_cubit.dart';
import '../../model/proposal_history.dart';
import '../../shared/components/application_card.dart';
import '../../shared/components/overall_radial_bar_chart.dart';
import '../request_description/request_description.dart';


class ProposalsHistory extends StatelessWidget {
  const ProposalsHistory({super.key});



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ProposalHistoryCubit()..getProposalHistoryData(),
        child: BlocConsumer<ProposalHistoryCubit, ProposalHistoryState>(

        listener: (context, state) {},
    builder: (context, state) {

    var cubit=context.read<ProposalHistoryCubit>();


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
            OverallRadialBarChart(applications: cubit.proposalHistory),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: cubit.proposalHistory.length,
              itemBuilder: (BuildContext context, int index) {
                ProposalHistory proposalHistory = cubit.proposalHistory[index];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(onTap: (){Navigator.push(
                      context,
                      MaterialPageRoute(
                      builder: (context) => RequestDescriptionScreen(
                    requestDescription: proposalHistory.requestDescription

                  )));},
                    child: ApplicationCard(companyImage: "",
                      providerName: proposalHistory.providerName,
                        serviceTitle: proposalHistory.serviceName,
                      createdAt : proposalHistory.createdAt,
                      status: proposalHistory.status,
                      updatedAt: proposalHistory.updatedAt,

                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }));}
}
