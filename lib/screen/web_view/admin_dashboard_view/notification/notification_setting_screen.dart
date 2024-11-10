import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationSettingScreen extends StatefulWidget {
  const NotificationSettingScreen({super.key});

  @override
  State<NotificationSettingScreen> createState() =>
      _NotificationSettingScreenState();
}

class _NotificationSettingScreenState extends State<NotificationSettingScreen> {
  bool _switchValueNotification = true;
  bool _switchValueAppointment = true;
  bool _switchValuePatient = true;
  bool _switchValuEmergency = false;
  bool _switchValuGeneral = true;
  bool _switchValuMessage = true;

  // Callback to update switch values
  void _onSwitchChanged(String switchType, bool value) {
    setState(() {
      switch (switchType) {
        case 'notification':
          _switchValueNotification = value;
          break;
        case 'appointment':
          _switchValueAppointment = value;
          break;
        case 'patient':
          _switchValuePatient = value;
          break;
        case 'emergency':
          _switchValuEmergency = value;
          break;
        case 'general':
          _switchValuGeneral = value;
          break;
        case 'message':
          _switchValuMessage = value;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: [
            commonView(
              title: "Notification Settings",
              desc:
                  "Customize how you receive important updates, reminders, and alerts about your patients and appointments.",
              switchValue: _switchValueNotification,
              onSwitchChanged: (value) =>
                  _onSwitchChanged('notification', value),
            ),
            commonView(
              title: "Appointment Reminders",
              desc:
                  "Get reminders for upcoming appointments, cancellations, or schedule changes to stay on top of your day",
              switchValue: _switchValueAppointment,
              onSwitchChanged: (value) =>
                  _onSwitchChanged('appointment', value),
            ),
            commonView(
              title: "Patient Updates",
              desc:
                  "Receive notifications when there are updates or changes in your patients' records, test results, or status",
              switchValue: _switchValuePatient,
              onSwitchChanged: (value) => _onSwitchChanged('patient', value),
            ),
            commonView(
              title: "Emergency Alerts",
              desc:
                  "Enable alerts for critical patient cases or emergency situations requiring your immediate attention.",
              switchValue: _switchValuEmergency,
              onSwitchChanged: (value) => _onSwitchChanged('emergency', value),
            ),
            commonView(
              title: "General Reminders",
              desc:
                  "Set up alerts for daily tasks, follow-up calls, and routine checks to ensure nothing is overlooked",
              switchValue: _switchValuGeneral,
              onSwitchChanged: (value) => _onSwitchChanged('general', value),
            ),
            commonView(
              title: "Message Notifications",
              desc:
                  "Receive instant notifications when a new message or patient inquiry is received, ensuring timely responses",
              switchValue: _switchValuMessage,
              onSwitchChanged: (value) => _onSwitchChanged('message', value),
            ),
          ],
        ),
      ],
    );
  }

  Widget commonView({
    required String title,
    required String desc,
    required bool switchValue,
    required Function(bool) onSwitchChanged,
  }) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.colorBgNew,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(
              Icons.notifications_none,
              color: AppColors.colorTextNew,
              size: 20,
            ),
          ),
        ),
        title: CommonTextWidget(
          text: title,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        subtitle: CommonTextWidget(
          text: desc,
          fontSize: 11,
          top: 5,
          fontWeight: FontWeight.w400,
        ),
        trailing: CupertinoSwitch(
          value: switchValue,
          onChanged: onSwitchChanged,
        ),
      ),
    );
  }
}
