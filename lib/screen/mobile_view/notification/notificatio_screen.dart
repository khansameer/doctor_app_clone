import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/app_scaffold.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/provider/dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return AppScaffold(
      right: 0,
      left: 0,
      appBar: commonAppBar(
          color: AppColors.colorGreen,
          colorText: Colors.white,
          title: "Notification".toUpperCase()),
      child: Consumer<DashboardProvider>(builder: (context, provider, child) {
        return SizedBox(
          width: size.width,
          height: size.height,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: provider.itemNotification.length,
              itemBuilder: (context, groupIndex) {
                var topData = provider.itemNotification[groupIndex];
                return Column(
                  children: [
                    Container(
                        width: size.width,
                        color: AppColors.colorBG,
                        padding: const EdgeInsets.all(10),
                        child: CommonTextWidget(
                          text: topData.date,
                          textColor: Colors.grey,
                          fontSize: 13,
                        )),
                    ListView.separated(
                      shrinkWrap: true,
                      itemCount: topData.items.length,
                      itemBuilder: (context, childIndex) {
                        var childData = topData.items[childIndex];
                        return Container(
                          margin: const EdgeInsets.all(5),
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            visualDensity: const VisualDensity(vertical: -3),
                            titleAlignment: ListTileTitleAlignment.center,
                            dense: true,
                            leading: const Icon(Icons.message),
                            title: CommonTextWidget(
                              fontSize: 12,
                              text: childData.content,
                            ),
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                CommonTextWidget(
                                  fontSize: 12,
                                  text: childData.days,
                                  top: 0,
                                  textColor: Colors.grey,
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(
                          thickness: 0.2,
                        );
                      },
                    )
                  ],
                );
              }),
        );
      }),
    );
  }
}
