import 'package:doctor_app/core/color_utils.dart';
import 'package:doctor_app/core/common/app_scaffold.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/provider/dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReportAndIssueScreen extends StatelessWidget {
  const ReportAndIssueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(builder: (context, provider, child) {
      return AppScaffold(
        color: Colors.white,
        left: 0,
        right: 0,
        appBar: commonAppBar(title: "Report and issue".toUpperCase()),
        child: Container(
          color: colorGreen.withOpacity(0.10),
          child: ListView(
            children: [
              commonList(
                fontWeight: FontWeight.w400,
                  title: "I have an issue with",
                  color: colorGreen.withOpacity(0.05)),
              commonList(title: "Ray"),
              commonList(title: "Reach"),
              commonList(title: "Consult"),
              commonList(
                title: "Health feed",
              ),
              commonList(
                title: "profile",
              ),
              commonList(
                title: "Other",
              ),
            ],
          ),
        ),
      );
    });
  }

  commonList({
    String? title,
    Widget? subTitle,
    Widget? trailing,
    FontWeight? fontWeight,
    Color? color,
    double? top,
  }) {
    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      decoration: commonBoxDecoration(
          color: color ?? Colors.white,
          border: Border.all(color: Colors.grey.withOpacity(0.50), width: 0)),
      margin: EdgeInsets.only(left: 0, right: 0, top: top ?? 0),
      child: ListTile(
        dense: true,
        titleAlignment: ListTileTitleAlignment.center,
        title: CommonTextWidget(
          text: title ?? "Sync Now",
          fontWeight: fontWeight??FontWeight.w600,
        ),
        subtitle: subTitle,
      ),
    );
  }
}
