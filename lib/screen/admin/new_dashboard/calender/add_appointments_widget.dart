import 'package:doctor_app/core/app_constants.dart';
import 'package:doctor_app/core/color_utils.dart';
import 'package:doctor_app/core/common/common_button_widget.dart';
import 'package:doctor_app/core/common/common_drop_down_view.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/responsive.dart';
import 'package:doctor_app/provider/calender_provider.dart';
import 'package:doctor_app/service/gloable_status_code.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddAppointmentsWidget extends StatefulWidget {
  const AddAppointmentsWidget({super.key, this.dateTime, this.patientID});

  final DateTime? dateTime;
  final String? patientID;

  @override
  State<AddAppointmentsWidget> createState() => _AddAppointmentsWidgetState();
}

class _AddAppointmentsWidgetState extends State<AddAppointmentsWidget> {
  var tetDate = TextEditingController();
  var tetTime = TextEditingController();
  var tetReason = TextEditingController();
  String? valueS;

  @override
  void initState() {
    DateTime? now = widget.dateTime;
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      tetTime.text = "${now?.hour}:${now?.minute}:${now?.second}";
      tetDate.text = '${now?.year}-${now?.month}-${now?.day}';
      context.read<CalenderProvider>().getPatientDetails().then((value) {
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var isMobile = Responsive.isMobile(context);
    var isDesktop = Responsive.isDesktop(context);
    var size = MediaQuery.sizeOf(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Consumer<CalenderProvider>(builder: (context, provider, child) {
      return Stack(
        children: [
          SizedBox(
            height: isMobile
                ? height * zero29
                : isDesktop
                    ? size.height * 0.65
                    : height * 0.4,
            width: isMobile
                ? width * zero9
                : isDesktop
                    ? width * 0.2
                    : width * 0.19,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: CommonTextWidget(
                          text: "Add Appointment",
                          fontSize: 16,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w700,
                          top: 20,
                        ),
                      ),
                      commonTextFiledView(
                          height: 45,
                          radius: 8,
                          topText: 5,
                          controller: tetDate,
                          topTextField: 10,
                          title: "Date"),
                      commonTextFiledView(
                          height: 45,
                          topText: 10,
                          controller: tetTime,
                          topTextField: 10,
                          radius: 8,
                          title: "Time"),
                      CommonTextWidget(
                        text: "Select Patient",
                        top: 10,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      widget.patientID == null
                          ? CommonDropDownView(
                              horizontal: 10,
                              height: 45,
                              selectedValue: provider.selectedValue,
                              onChanged: (value) {
                                provider.updateValue(value);
                                if (provider.selectedValue != null) {
                                  provider.updateID(provider
                                      .patientDetailsModel?.patients
                                      .firstWhere((item) =>
                                          '${item.firstName} ${item.lastName}' ==
                                          value)
                                      .sId);

                                  print(
                                      'Selected Patient: ${provider.selectedID}');
                                }
                              },
                              size: size,
                              items:
                                  provider.patientDetailsModel?.patients != null
                                      ? provider.patientDetailsModel!.patients
                                          .map((patient) {
                                          return '${patient.firstName} ${patient.lastName}';
                                        }).toList()
                                      : [])
                          : SizedBox.shrink(),
                      commonTextFiledView(
                        title: "Reason",
                        topText: 10,
                        maxLines: 3,
                        controller: tetReason,
                        topTextField: 10,
                        height: 45,
                        radius: 8,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: CommonButtonWidget(
                              onPressed: () async {
                                String userId = await getUserID();

                                Map<String, dynamic> body = {
                                  "patientId":
                                      widget.patientID ?? provider.selectedID,
                                  "doctorId": userId,
                                  "dateTime": widget.dateTime.toString(),
                                  "reason": tetReason.text,
                                  "isVirtual": true,
                                };
                                print('========${body.toString()}');
                                provider
                                    .createAppointment(
                                  body: body,
                                  context: context,
                                )
                                    .then((value) {
                                  if (globalStatusCode == 200 ||
                                      globalStatusCode == 201) {
                                    Navigator.of(context).pop();
                                  }
                                });
                              },
                              colorButton: colorGreen,
                              fontSize: 12,
                              text: "Add",
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: CommonButtonWidget(
                              text: "Cancel",
                              colorBorder: Colors.black,
                              colorButton: Colors.white,
                              colorText: Colors.black,
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          provider.isAdding ? showLoaderList() : SizedBox.shrink()
        ],
      );
    });
  }
}
