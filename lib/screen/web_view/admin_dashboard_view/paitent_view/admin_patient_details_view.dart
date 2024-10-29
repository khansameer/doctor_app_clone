import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_app/core/color_utils.dart';
import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/image/image_path.dart';
import 'package:doctor_app/core/responsive.dart';
import 'package:doctor_app/screen/web_view/admin_dashboard_view/paitent_details/admin_patient_appointment.dart';
import 'package:doctor_app/screen/web_view/admin_dashboard_view/paitent_details/bill_info_view.dart';
import 'package:doctor_app/screen/web_view/admin_dashboard_view/paitent_details/next_followup_date.dart';
import 'package:flutter/material.dart';

import '../paitent_details/admin_patient_report_view.dart';
import '../paitent_details/demographics_view.dart';
import '../paitent_details/doctor_note_view.dart';

class AdminPatientDetailsView extends StatelessWidget {
  const AdminPatientDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    var isMobile = Responsive.isMobile(context);
    var isDesktop = Responsive.isDesktop(context);
    return SizedBox(
      width: isDesktop ? size.width : size.width * 0.7,
      height: size.height,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonTextWidget(
                  text: "Patient Details",
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.clear))
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                    flex: 2,
                    child: Container(
                      height: size.height,
                      color: colorBG,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: setAssetImage(
                                width: 180,
                                height: 180,
                                fit: BoxFit.cover,
                                image: icDummyUser,
                              ),
                            ),
                            CommonTextWidget(
                              text: "Robert Jones",
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              top: 15,
                            ),
                            CommonTextWidget(
                              text: "Active",
                              top: 5,
                              textColor: Colors.green,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            commonRow(),
                            const SizedBox(
                              height: 10,
                            ),
                            commonRow(title: "Age", desc: "20"),
                            const SizedBox(
                              height: 10,
                            ),
                            commonRow(title: "Language", desc: "English"),
                            const SizedBox(
                              height: 10,
                            ),
                            commonRow(title: "Height", desc: "5Ft"),
                          ],
                        ),
                      ),
                    )),
                Expanded(
                    flex: 8,
                    child: Container(
                      height: size.height,
                      color: Colors.white,
                      child: DefaultTabController(
                          length: 7,
                          child: Column(
                            children: [
                              Container(
                                color:
                                    colorBG, // Customize the background color of the TabBar
                                child: TabBar(
                                  labelStyle: commonTextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600),
                                  labelColor: AppColors.colorText,
                                  indicatorColor: AppColors.colorText,
                                  unselectedLabelColor: Colors.grey,
                                  tabs: const [
                                    Tab(text: 'Doctor Notes'),
                                    Tab(text: 'Demographics Details'),
                                    Tab(text: 'Reports'),
                                    Tab(text: 'Appointment Details'),
                                    Tab(text: 'Next Followup date'),
                                    Tab(text: 'Chat with Patient'),
                                    Tab(text: 'Bill Info'),
                                  ],
                                ),
                              ),
                              const Expanded(
                                child: TabBarView(
                                  children: [
                                    DoctorNoteView(),
                                    DemographicsView(),
                                    AdminPatientReportView(),
                                    AdminPatientAppointment(),
                                    NextFollowupDate(),
                                    Center(child: Text('Coming soon')),
                                    BillInfoView()
                                  ],
                                ),
                              ),
                            ],
                          )),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  commonRow({String? title, String? desc}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonTextWidget(
          text: title ?? "Gender",
          textColor: Colors.grey,
          fontSize: 13,
        ),
        CommonTextWidget(
          text: desc ?? "Male",
          textColor: Colors.black,
          fontSize: 13,
        ),
        const SizedBox(
          width: 20,
        ),
      ],
    );
  }
}
