import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '../style/constants.dart';

class TimeRangeFormField extends StatefulWidget {
  const TimeRangeFormField({
    Key? key,
    required this.initialStartTime,
    required this.initialEndTime,
    required this.onChanged,
  }) : super(key: key);

  final DateTime initialStartTime;
  final DateTime initialEndTime;
  final void Function(DateTime startTime, DateTime endTime) onChanged;

  @override
  _TimeRangeFormFieldState createState() => _TimeRangeFormFieldState();
}

class _TimeRangeFormFieldState extends State<TimeRangeFormField> {
  late DateTime _startTime;
  late DateTime _endTime;

  @override
  void initState() {
    super.initState();
    _startTime = widget.initialStartTime;
    _endTime = widget.initialEndTime;
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final selectedRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now().subtract(Duration(days: 365)),
      lastDate: DateTime.now().add(Duration(days: 365)),
      initialDateRange: DateTimeRange(start: _startTime, end: _endTime),
    );
    if (selectedRange != null) {
      setState(() {
        _startTime = selectedRange.start;
        _endTime = selectedRange.end;
        widget.onChanged(_startTime, _endTime);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMM d, y');
    final startTimeString = dateFormat.format(_startTime);
    final endTimeString = dateFormat.format(_endTime);

    return GestureDetector(
      onTap: () async {
        await _selectDateRange(context);
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'Select a time frame',prefixIcon: Icon(Iconsax.calendar_circle,color: buttonColor,),labelStyle: TextStyle(fontFamily: "Poppins",fontSize: 16.sp ,fontWeight: FontWeight.w600) ,
          border: OutlineInputBorder(),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(startTimeString,style: TextStyle(fontFamily: "Poppins",fontSize: 16.sp ,fontWeight: FontWeight.w600) ,),
            Text('-'),
            Text(endTimeString,style: TextStyle(fontFamily: "Poppins",fontSize: 16.sp ,fontWeight: FontWeight.w600) ),
          ],
        ),
      ),
    );
  }
}