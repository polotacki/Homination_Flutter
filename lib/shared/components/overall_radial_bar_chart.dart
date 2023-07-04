import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../model/proposal_history.dart';
import '../network/local/cache_helper.dart';

class OverallRadialBarChart extends StatelessWidget {
  final List<ProposalHistory> applications;

  const OverallRadialBarChart({Key? key, required this.applications})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double acceptedCount = 0;
    double pendingCount = 0;
    double rejectedCount = 0;
    for (var application in applications) {
      switch (application.status) {
        case "accepted":
          acceptedCount++;
          break;
        case "pending":
          pendingCount++;
          break;
        case "rejected":
          rejectedCount++;
          break;
      }
    }

    List<_StatusData> chartData = [
      _StatusData("Accepted", acceptedCount),
      _StatusData("Pending", pendingCount),
      _StatusData("Rejected", rejectedCount),
    ];
    var profilePic =CacheHelper.getData(key: "profilePic");
    return Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      Container(
        height: 250,
        child: SfCircularChart(
          title: ChartTitle(
            text: "Overall Applications Status",
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          series: <CircularSeries>[
            DoughnutSeries<_StatusData, String>(
              dataSource: chartData,
              xValueMapper: (_StatusData data, _) => data.status,
              yValueMapper: (_StatusData data, _) => data.count,
              pointColorMapper: (_StatusData data, _) =>
                  _getStatusColor(data.status),
              animationDuration: 1000,
              enableTooltip: true,
              innerRadius: "60",
              dataLabelSettings: const DataLabelSettings(
                isVisible: false,
              ),
              dataLabelMapper: (datum, _) =>
                  '${datum.status}: ${datum.count.toInt()}',
            ),
          ],annotations:  <CircularChartAnnotation>[
          CircularChartAnnotation(
            widget: CircleAvatar(
              backgroundImage:profilePic!=null && profilePic != ""?MemoryImage(base64Decode( profilePic)
              )as ImageProvider:AssetImage("assets/images/anonymous.png")
            ),height: "100",width: "100"
          ),
        ],
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _StatusBox(
            color: _getStatusColor('Accepted'),
            status: 'Accepted',
            count: acceptedCount.toInt(),
          ),
          const SizedBox(width: 20),
          _StatusBox(
            color: _getStatusColor('Pending'),
            status: 'Pending',
            count: pendingCount.toInt(),
          ),
          const SizedBox(width: 20),
          _StatusBox(
            color: _getStatusColor('Rejected'),
            status: 'Rejected',
            count: rejectedCount.toInt(),
          ),
        ],
      ),
    ]);
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Accepted":
        return const Color(0xff56ff8d);
      case "Pending":
        return const Color(0xff449aff);
      case "Rejected":
        return const Color(0xffff488d);
      default:
        return Colors.black;
    }
  }
}

class _StatusData {
  final String status;
  final double count;

  _StatusData(this.status, this.count);
}

class _StatusBox extends StatelessWidget {
  final Color color;
  final String status;
  final int count;

  const _StatusBox({
    Key? key,
    required this.color,
    required this.status,
    required this.count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: 18,
              height: 18,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Text(
          status,
          style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16.sp,
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 5),
        Text(
          count.toString(),
          style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16.sp,
              fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
