import 'package:doctor_app/core/app_constants.dart';
import 'package:doctor_app/core/color_utils.dart';
import 'package:doctor_app/core/common/common_button_widget.dart';
import 'package:doctor_app/core/common/common_drop_down_view.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/responsive.dart';
import 'package:doctor_app/main.dart';
import 'package:doctor_app/provider/calender_provider.dart';
import 'package:doctor_app/service/gloable_status_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
  void dispose() {
    super.dispose();
    resetField();
  }

  CalenderProvider? _calendarProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Save a reference to the CalendarProvider here
    _calendarProvider = context.read<CalenderProvider>();
  }

  resetField() {
    // Clear the controllers
    tetDate.clear();
    tetTime.clear();
    tetReason.clear();

    // Set values to null
    // widget.patientID =null ;  // Use assignment = instead of ==

    // Safely reset the provider value if needed
    //var  calendarProvider = context.read<CalenderProvider>();
    _calendarProvider?.updateValue(null); // Use assignment = instead of ==
  }

  @override
  Widget build(BuildContext context) {
    var isMobile = Responsive.isMobile(context);
    var isDesktop = Responsive.isDesktop(context);
    var size = MediaQuery.sizeOf(context);

    var width = MediaQuery.of(context).size.width;

    return Consumer<CalenderProvider>(builder: (context, provider, child) {
      return SizedBox(
        width: isMobile
            ? width * zero9
            : isDesktop
                ? width * 0.3
                : width * 0.19,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CommonTextWidget(
                            text: "Add Appointment",
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
                      widget.patientID == null
                          ? CommonTextWidget(
                              text: "Select Patient",
                              top: 10,
                            )
                          : const SizedBox.shrink(),
                      widget.patientID == null
                          ? const SizedBox(
                              height: 10,
                            )
                          : const SizedBox.shrink(),
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
                          : const SizedBox.shrink(),
                      commonTextFiledView(
                        title: "Description",
                        topText: 10,
                        maxLines: 3,
                        controller: tetReason,
                        topTextField: 10,
                        height: 45,
                        radius: 8,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: CommonButtonWidget(
                              radius: 8,
                              height: 40,
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
                                provider
                                    .createAppointment(
                                  body: body,
                                  context: context,
                                )
                                    .then((value) {
                                  if (globalStatusCode == 200 ||
                                      globalStatusCode == 201) {
                                    resetField();
                                    provider.selectedID == null;
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
                              radius: 8,
                              height: 40,
                              colorBorder: Colors.black,
                              colorButton: Colors.white,
                              colorText: Colors.black,
                              onPressed: () {
                                SchedulerBinding.instance
                                    .addPostFrameCallback((_) {
                                  setState(() {
                                    resetField();
                                    provider.selectedID == null;
                                    Navigator.of(context).pop();
                                  });
                                });
                              },
                              fontSize: 12,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                provider.isAdding ? showLoaderList() : const SizedBox.shrink()
              ],
            ),
          ],
        ),
      );
    });
  }
}
