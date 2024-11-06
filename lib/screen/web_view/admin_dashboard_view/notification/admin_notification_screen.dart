import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/provider/dashboard_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminNotificationScreen extends StatelessWidget {
  const AdminNotificationScreen({super.key, required this.isDialog});

  final bool isDialog;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Consumer<DashboardProvider>(builder: (context, provider, child) {
      return SizedBox(
        // height: size.height * 0.8,
        width: size.width * 0.2,

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            isDialog
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CommonTextWidget(
                          text: "Notifications",
                          fontSize: 16,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w700,
                          // top: 20,
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(
                              Icons.close,
                              size: 18,
                              color: Colors.black,
                            ))
                      ],
                    ),
                  )
                : SizedBox.shrink(),
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: provider.doctorNotifications.length,
                itemBuilder: (context, index) {
                  var data = provider.doctorNotifications[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CommonTextWidget(
                      text: data.toString(),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    thickness: 0.3,
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
