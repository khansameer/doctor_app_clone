import 'package:doctor_app/core/app_constants.dart';
import 'package:doctor_app/core/colors.dart';

import 'package:doctor_app/core/common/common_button_widget.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/responsive.dart';
import 'package:doctor_app/provider/appointments_provider.dart';
import 'package:doctor_app/provider/patient_provider.dart';
import 'package:doctor_app/screen/web_view/model/patient_details_model.dart';
import 'package:doctor_app/service/gloable_status_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:searchfield/searchfield.dart';

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
  var tetDesc = TextEditingController();
  var tetPatientName = TextEditingController();
  var tetPatientEmail = TextEditingController();
  var tetPatientPhone = TextEditingController();
  String? valueS;
  final FocusNode searchFieldFocusNode = FocusNode();

  @override
  void initState() {
    DateTime? now = widget.dateTime;
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<PatientProvider>(context, listen: false);
      tetTime.text = "${now?.hour}:${now?.minute}:${now?.second}";
      tetDate.text = '${now?.year}-${now?.month}-${now?.day}';
      provider.getPatientDetails(context: context);
    });
  }

  resetField() {
    tetDate.clear();
    tetTime.clear();
    tetDesc.clear();
    tetPatientName.clear();
    tetPatientPhone.clear();
    tetDesc.clear();
  }

  @override
  void dispose() {
    super.dispose();
    tetDate.dispose();
    tetTime.dispose();
    tetDesc.dispose();
    tetPatientName.dispose();
    tetPatientEmail.dispose();
    tetPatientPhone.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var isMobile = Responsive.isMobile(context);
    var isDesktop = Responsive.isDesktop(context);

    var width = MediaQuery.of(context).size.width;
    final provider = context.read<PatientProvider>();
    return SizedBox(
      width: isMobile
          ? width * zero9
          : isDesktop
              ? width * 0.3
              : width * 0.19,
      child: ListView(
        children: [
          Column(
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
                        const SizedBox(height: 20),
                        commonTextFiledView(
                            height: 45,
                            radius: 8,
                            topText: 10,
                            fontSize: 14,
                            controller: tetDate,
                            topTextField: 10,
                            title: "Date"),
                        commonTextFiledView(
                            height: 45,
                            topText: 10,
                            fontSize: 14,
                            controller: tetTime,
                            topTextField: 10,
                            radius: 8,
                            title: "Time"),
                        widget.patientID == null
                            ? const SizedBox(
                                height: 10,
                              )
                            : const SizedBox.shrink(),
                        CommonTextWidget(
                          /* text: "Select Patient",*/
                          text: "Patient Name",
                          top: 10,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SearchField<Patients>(
                          suggestionStyle: commonTextStyle(),
                          suggestionItemDecoration:
                              const BoxDecoration(color: Colors.white),

                          focusNode: searchFieldFocusNode, // Add the focus node
                          searchInputDecoration: SearchInputDecoration(
                              labelStyle: commonTextStyle(fontSize: 14),
                              hintText: "Search Patient Name",
                              hintStyle: commonTextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                              border: const OutlineInputBorder(
                                  gapPadding: ten,
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: AppColors.primary,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(eight))),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.primary
                                        .withOpacity( 0.20),
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(eight))),
                              focusedBorder: const OutlineInputBorder(
                                  gapPadding: ten,
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: AppColors.primary,
                                  ),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(eight)))),
                          textInputAction: TextInputAction.next,
                          controller: tetPatientName,
                          suggestions: provider.patientDetailsModel?.patients !=
                                  null
                              ? provider.patientDetailsModel!.patients
                                  .map(
                                    (patient) => SearchFieldListItem<Patients>(
                                      patient.firstName
                                          .toString(), // Create a fullName getter if necessary
                                      item: patient,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            const SizedBox(width: 10),
                                            CommonTextWidget(
                                                text: patient.firstName ??
                                                    ' ${patient.lastName}'),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList()
                              : [],
                          onSuggestionTap: (suggestion) {
                            final selectedPatientId = suggestion.item?.sId;

                            // provider.selectedID=
                            widget.patientID == selectedPatientId;
                            //  print('============${suggestion.}');

                            provider.updateID(selectedPatientId);
                            searchFieldFocusNode
                                .unfocus(); // Close the keyboard to prevent reopening suggestions
                            // Handle the tap event (e.g., populate a text field with the selected patient's name)
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        widget.patientID == null
                            ? commonTextFiledView(
                                title: "Patient Email Address",
                                topText: 10,
                                maxLines: 3,
                                controller: tetPatientEmail,
                                topTextField: 10,
                                height: 45,
                                radius: 8,
                              )
                            : const SizedBox.shrink(),
                        widget.patientID == null
                            ? commonTextFiledView(
                                title: "Patient Phone No",
                                topText: 10,
                                maxLines: 3,
                                controller: tetPatientPhone,
                                topTextField: 10,
                                height: 45,
                                radius: 8,
                              )
                            : const SizedBox.shrink(),
                        commonTextFiledView(
                          title: "Description",
                          topText: 10,
                          keyboardType: TextInputType.multiline,
                          maxLines: 3,
                          controller: tetDesc,
                          topTextField: 10,
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
                                height: isMobile ? null : 40,
                                onPressed: () async {
                                  String userId = await getUserID();

                                  Map<String, dynamic> body = {
                                    "patientId":
                                        widget.patientID ?? provider.selectedID,
                                    "doctorId": userId,
                                    "dateTime": widget.dateTime.toString(),
                                    "reason": tetDesc.text,
                                    "isVirtual": true,
                                  };
                                  context
                                      .read<AppointmentsProvider>()
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
                                colorButton: AppColors.colorGreen,
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
                                height: isMobile ? null : 40,
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
                  context.watch<AppointmentsProvider>().isAdding
                      ? showLoaderList()
                      : const SizedBox.shrink()
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
