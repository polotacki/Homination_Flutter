import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homaination_mobile/shared/style/constants.dart';

class NotificationSettingsScreen extends StatefulWidget {
  @override
  _NotificationSettingsScreenState createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  bool _newServicesEnabled = true;
  bool _gotAcceptedEnabled = false;
  bool _getRejectedEnabled = true;
  bool _massageEnabled = false;
  bool _callEnabled = true;
  bool _darkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification Settings' ,style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.w600),),
      ),
      body: ListView(
        children: [
          _buildNotificationSetting(
            'New Services',
            'Receive notifications when new services are added',
            _newServicesEnabled,
            (value) => setState(() => _newServicesEnabled = value),
          ),
          _buildNotificationSetting(
            'Got Accepted',
            'Receive notifications when your request is accepted',
            _gotAcceptedEnabled,
            (value) => setState(() => _gotAcceptedEnabled = value),
          ),
          _buildNotificationSetting(
            'Get Rejected',
            'Receive notifications when your request is rejected',
            _getRejectedEnabled,
            (value) => setState(() => _getRejectedEnabled = value),
          ),
          _buildNotificationSetting(
            'Massage',
            'Receive notifications when you get a message',
            _massageEnabled,
            (value) => setState(() => _massageEnabled = value),
          ),

          _buildNotificationSetting(
            'Dark Mode',
            'Enable or disable dark mode',
            _darkModeEnabled,
            (value) => setState(() => _darkModeEnabled = value),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationSetting(
      String title, String subtitle, bool value, Function(bool) onChanged) {
    return ListTile(
      title: Text(title,
          style: TextStyle(
              color: Colors.black,
              fontSize: 20.sp,
              fontWeight: FontWeight.w600)),
      subtitle: Text(
        subtitle,
        style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.grey,
            fontSize: 10.sp,
            fontWeight: FontWeight.w200),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: Colors.white,
        activeTrackColor: const Color(0xff4CA6A8),
        inactiveTrackColor: const Color(0xffE9E9E9),inactiveThumbColor: Colors.white,
      ),
    );
  }
}
