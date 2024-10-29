import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_app/core/color_utils.dart';
import 'package:doctor_app/core/common/CustomAlertDialog.dart';

import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/image/image_path.dart';
import 'package:doctor_app/provider/admin_dashboard_provider.dart';
import 'package:doctor_app/screen/web_view/screen/calender/get_edit_appointments_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'admin_patient_details_view.dart';

class AdminAllListScreen extends StatelessWidget {
  const AdminAllListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminDashboardProvider>(
        builder: (context, provider, child) {
      return ListView.builder(
          shrinkWrap: true,
          itemCount: provider.patients.length,
          itemBuilder: (context, index) {
            var data = provider.patients[index];
            return Container(
              decoration: BoxDecoration(
                  color: colorBG, borderRadius: BorderRadius.circular(8)),
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(15),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 25.0, right: 25),
                          child: CommonTextWidget(
                            text:
                                data.isActive == false ? "InActive" : "Active",
                            textColor: data.isActive == false
                                ? Colors.red
                                : Colors.green,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    commonInkWell(
                      onTap: () {
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) {
                              return CustomAlertDialog(
                                content: AdminPatientDetailsView(),
                              );
                            });
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20),
                            child: CommonTextWidget(
                              text: "View Profile",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: setAssetImage(
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                    image: icDummyUser,
                  ) /*commonImageNetworkWidget(path: provider.patients[index].photo)*/,
                ),
                title: CommonTextWidget(
                  text: data.name.toString(),
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
                subtitle: CommonTextWidget(
                  text: "28 years",
                  top: 5,
                  fontSize: 12,
                ),
              ),
            );
          });
    });
  }
}
