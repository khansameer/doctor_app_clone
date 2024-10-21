import 'package:doctor_app/core/color_utils.dart';
import 'package:doctor_app/core/common/app_scaffold.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/responsive.dart';
import 'package:doctor_app/provider/dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../procedure_charges_screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var isMobile = Responsive.isMobile(context);

    return Consumer<DashboardProvider>(builder: (context, provider, child) {
      return AppScaffold(
        color: Colors.white,
        left: 0,
        right: 0,
        appBar: isMobile
            ? commonAppBar(title: "Settings".toUpperCase())
            : const PreferredSize(
                preferredSize: Size.zero, child: SizedBox.shrink()),
        child: Container(
          color: colorBG,
          child: ListView(
            children: [
              commonList(
                  trailing:
                      const Icon(Icons.refresh, color: Colors.grey, size: 24),
                  subTitle: CommonTextWidget(
                    text: "Last synced - 4 minutes ago",
                    fontSize: 11,
                    textColor: Colors.black.withOpacity(0.80),
                  )),
              commonList(
                  title: "Support",
                  trailing: const Icon(Icons.email_outlined,
                      color: Colors.grey, size: 24),
                  subTitle: CommonTextWidget(
                    fontSize: 11,
                    text: "Last synced - 4 minutes ago",
                    textColor: Colors.black.withOpacity(0.80),
                  )),
              commonList(
                  top: 10,
                  title: "Caller ID",
                  trailing: Switch(
                    activeColor: Colors.white,
                    inactiveTrackColor: Colors.white,
                    inactiveThumbColor: Colors.grey,
                    activeTrackColor: colorGreen,
                    value: provider.isOn,
                    onChanged: (value) {
                      provider.toggleSwitch();
                    },
                  )),
              commonList(top: 10, title: "Ray"),
              commonList(title: "Consult"),
              commonList(title: "Cashless Setting"),
              commonList(title: "Account", top: 10),
              commonList(
                title: "Notification",
              ),
              commonList(title: "Invite Friends", top: 10),
              commonList(title: "Rate us on the App Store", top: 0),
            ],
          ),
        ),
      );
    });
  }

  commonList(
      {String? title,
      Widget? subTitle,
      Widget? trailing,
      double? top,
      VoidCallback? onTap}) {
    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      decoration: commonBoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.withOpacity(0.50), width: 0)),
      margin: EdgeInsets.only(left: 0, right: 0, top: top ?? 0),
      child: ListTile(
        onTap: onTap,
        dense: true,
        titleAlignment: ListTileTitleAlignment.center,
        trailing: trailing ??
            const Icon(
              Icons.arrow_forward_ios_outlined,
              color: Colors.grey,
              size: 15,
            ),
        title: CommonTextWidget(
          text: title ?? "Sync Now",
          fontWeight: FontWeight.w600,
        ),
        subtitle: subTitle,
      ),
    );
  }
}
