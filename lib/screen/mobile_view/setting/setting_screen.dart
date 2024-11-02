import 'package:doctor_app/core/common/app_scaffold.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/responsive.dart';
import 'package:doctor_app/core/route/route.dart';
import 'package:doctor_app/provider/dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/colors.dart';

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
          color: AppColors.colorBG,
          child: ListView(
            children: [
              commonList(
                onTap: () {
                  pushScreen(
                      context: context,
                      routeName: RouteName.procedureChargesScreen);
                },
                title: "Procedure Catalog",
              ),
              commonList(
                title: "Clinic Address",
              ),
              commonList(
                title: "Notification",
              ),
              commonList(title: "Consent Forms"),
              commonList(title: "Billing"),
              commonList(
                title: "EMR",
              ),
              commonList(
                title: "Prescriptions",
              ),
              commonList(
                title: "Calendar",
              ),
              commonList(
                title: "Communications",
              ),
              commonList(
                title: "Contacts",
              ),
              commonList(
                title: "Email PDF Settings",
              ),
              commonList(title: "Medical History"),
            ],
          ),
        ),
      );
    });
  }

  commonList({String? title, double? top, VoidCallback? onTap}) {
    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      decoration: commonBoxDecoration(
          color: Colors.white,
          border:
              Border.all(color: Colors.grey.withValues(alpha: 0.50), width: 0)),
      margin: EdgeInsets.only(left: 0, right: 0, top: top ?? 0),
      child: ListTile(
        onTap: onTap,
        dense: true,
        titleAlignment: ListTileTitleAlignment.center,
        trailing: const Icon(
          Icons.arrow_forward_ios_outlined,
          color: Colors.grey,
          size: 15,
        ),
        title: CommonTextWidget(
          text: title ?? "Sync Now",
          fontWeight: FontWeight.w600,
        ),
        //subtitle: subTitle,
      ),
    );
  }
}
