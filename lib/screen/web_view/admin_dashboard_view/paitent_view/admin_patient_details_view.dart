import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/image/image_path.dart';
import 'package:doctor_app/core/responsive.dart';
import 'package:doctor_app/screen/web_view/admin_dashboard_view/paitent_details/admin_patient_appointment.dart';
import 'package:doctor_app/screen/web_view/admin_dashboard_view/paitent_details/bill_info_view.dart';
import 'package:doctor_app/screen/web_view/admin_dashboard_view/paitent_details/next_followup_date.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../provider/patient_provider.dart';
import '../paitent_details/admin_patient_report_view.dart';
import '../paitent_details/demographics_view.dart';
import '../paitent_details/doctor_note_view.dart';

class AdminPatientDetailsView extends StatefulWidget {

  const AdminPatientDetailsView({
    super.key,
    required this.patientID,
  });

  final String patientID;

  @override
  State<AdminPatientDetailsView> createState() => _AdminPatientDetailsViewState();
}

class _AdminPatientDetailsViewState extends State<AdminPatientDetailsView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print('============widget.patientID====${widget.patientID}');
      context
          .read<PatientProvider>()
          .getPatientDetailsBYID(context: context, patientID: widget.patientID)
          .then((value) {});
    });

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    var isDesktop = Responsive.isDesktop(context);

    var provider = context.watch<PatientProvider>();
    var data = provider.commonPatientDetailsModel?.data;
    return SizedBox(
      width: isDesktop ? size.width : size.width * 0.7,
      height: size.height,
      child: Stack(
        children: [
          Column(
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
                          color: AppColors.colorBgNew,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      '${data?.user.profile.profilePicture}',
                                      width: 180,
                                      loadingBuilder: (BuildContext context, Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null) return child;
                                        return Center(
                                          child: showLoaderList(),
                                        );
                                      },
                                      errorBuilder:
                                          (BuildContext context, Object exception, StackTrace? stackTrace) {
                                        return Image.asset(
                                          icUserErrorImage,
                                          width: 180,
                                          height: 180,
                                        );
                                      },
                                      height: 180,
                                      fit: BoxFit.cover,

                                    ),
                                  ),
                                ),
                                CommonTextWidget(
                                  text: '${data?.user.firstName??''} ${data?.user.lastName??''}',
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
                                commonRow(title: "Age", desc: '${calculateAge(DateTime.parse(data?.user.dateOfBirth.toString()??DateTime.now().toString()))}'),
                                const SizedBox(
                                  height: 10,
                                ),
                                commonRow(title: "Mobile Number", desc: data?.user.phoneNumber??''),
                                const SizedBox(
                                  height: 10,
                                ),
                                commonRow(title: "Height", desc: '${data?.profile.height??'0'}ft'),
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
                                    color: AppColors
                                        .colorBgNew, // Customize the background color of the TabBar
                                    child: TabBar(
                                      labelStyle: commonTextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600),
                                      labelColor: AppColors.colorTextNew,
                                      indicatorColor: AppColors.colorTextNew,
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
                                   Expanded(
                                    child: TabBarView(
                                      children: [
                                        DoctorNoteView(),
                                        DemographicsView(),
                                        AdminPatientReportView(),
                                        AdminPatientAppointment(appointment: data?.appointment??[],),
                                        NextFollowupDate(),
                                        Center(
                                          child: CommonTextWidget(
                                            text: "No Data Found",
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                          ),
                                        ),
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
          context.watch<PatientProvider>().isLoading
              ? showLoaderList()
              : SizedBox.shrink()

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
