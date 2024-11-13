import 'package:doctor_app/core/app_constants.dart';
import 'package:doctor_app/core/colors.dart';

import 'package:doctor_app/core/common/common_button_widget.dart';
import 'package:doctor_app/core/common/common_drop_down_view.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/context_extension.dart';
import 'package:doctor_app/core/responsive.dart';
import 'package:doctor_app/provider/appointments_provider.dart';
import 'package:doctor_app/provider/patient_provider.dart';
import 'package:doctor_app/provider/profile_provider.dart';
import 'package:doctor_app/screen/web_view/model/patient_details_model.dart';
import 'package:doctor_app/service/gloable_status_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
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
      if (now != null) {
        // Format the time with AM/PM
        tetTime.text = DateFormat('hh:mm a').format(now);

        // Format the date
        tetDate.text = DateFormat('yyyy-MM-dd').format(now);
      } else {
        // Handle null case, e.g., set default text or show an error
        tetTime.text = 'Time not available';
        tetDate.text = 'Date not available';
      }
      context
          .read<PatientProvider>()
          .getPatientDetails(context: context)
          .then((value) {
        print(
            '=======sdsdd======${context.read<PatientProvider>().patients?.length}');
      });
    });
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
    var size = MediaQuery.sizeOf(context);
    final formAddApt = GlobalKey<FormState>();
    var width = MediaQuery.of(context).size.width;
    final provider = context.read<PatientProvider>();
    final providerApt = context.read<AppointmentsProvider>();
    return SizedBox(
      width: isMobile
          ? width * zero9
          : isDesktop
              ? width * 0.3
              : width * 0.19,
      child: ListView(
        children: [
          Form(
            key: formAddApt,
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
                          const SizedBox(height: 20),
                          commonTextFiledView(
                              radius: 8,
                              topText: 10,
                              isReadOnly: true,
                              fontSize: 14,
                              borderColor: Colors.grey.withOpacity(0.40),
                              controller: tetDate,
                              topTextField: 10,
                              title: "Date"),
                          commonTextFiledView(
                              topText: 10,
                              fontSize: 14,
                              isReadOnly: true,
                              borderColor: Colors.grey.withOpacity(0.40),
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
                            text: "Patient Name",
                            top: 10,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Consumer<PatientProvider>(
                              builder: (context, provider, child) {
                            return SearchField<Patients>(
                              validator: (value) {
                                if (value.toString().trim().isEmpty) {
                                  return "Please enter patient name.";
                                }

                                return null;
                              },
                              suggestionStyle: commonTextStyle(),
                              suggestionItemDecoration:
                                  const BoxDecoration(color: Colors.white),

                              focusNode:
                                  searchFieldFocusNode, // Add the focus node
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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(eight))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey.withOpacity(0.40),
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
                              suggestions: provider.patients != null
                                  ? provider.patients!
                                      .map(
                                        (patient) =>
                                            SearchFieldListItem<Patients>(
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

                                setState(() {
                                  tetPatientEmail.text =
                                      '${suggestion.item?.email.toString()}';
                                  tetPatientPhone.text =
                                      '${suggestion.item?.phoneNumber.toString()}';

                                  /*if (context
                                      .read<ProfileProvider>()
                                      .itemGenderList
                                      .contains(
                                          suggestion.item?.gender.toString())) {
                                    providerApt.setGenderValue(
                                        suggestion.item?.gender.toString());
                                    //  provider.setGenderValue = data!.gender.toString().toCapitalize();
                                  }*/
                                });

                                widget.patientID == selectedPatientId;
                                //  print('============${suggestion.}');

                                provider.updateID(selectedPatientId);
                                searchFieldFocusNode
                                    .unfocus(); // Close the keyboard to prevent reopening suggestions
                                // Handle the tap event (e.g., populate a text field with the selected patient's name)
                              },
                            );
                          }),
                          const SizedBox(
                            height: 10,
                          ),
                          widget.patientID == null
                              ? commonTextFiledView(
                                  title: "Patient Email Address",
                                  topText: 10,
                                  validator: (value) {
                                    if (value.toString().trim().isEmpty) {
                                      return "Please enter patient email id.";
                                    }

                                    return null;
                                  },
                                  borderColor: Colors.grey.withOpacity(0.40),
                                  controller: tetPatientEmail,
                                  topTextField: 10,
                                  radius: 8,
                                )
                              : const SizedBox.shrink(),
                          widget.patientID == null
                              ? commonTextFiledView(
                                  title: "Patient Phone No",
                                  topText: 10,
                                  validator: (value) {
                                    if (value.toString().trim().isEmpty) {
                                      return "Please enter patient phone number.";
                                    }

                                    return null;
                                  },
                                  borderColor: Colors.grey.withOpacity(0.40),
                                  controller: tetPatientPhone,
                                  topTextField: 10,
                                  radius: 8,
                                )
                              : const SizedBox.shrink(),
                          commonDropDown(
                            size: size,
                            hint: "Select Gender",
                            items:
                                context.read<ProfileProvider>().itemGenderList,
                            onChanged: (value) {
                              providerApt.setGenderValue(value.toString());
                            },

                            selectedValue: providerApt.selectGender,
                            // selectedValue: provider.selectedGender,
                          ),
                          CommonTextWidget(
                            text: "Appointment Type",
                            top: 10,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CommonDropDownView(
                              horizontal: 5,
                              height: 50,
                              hint: "Select appointment type",
                              borerColor: Colors.grey.withOpacity(0.40),
                              selectedValue: providerApt.selectAPTName,
                              size: size,
                              onChanged: (value) {
                                providerApt.setAptName(value);
                              },
                              items: providerApt.appointmentType),
                          commonTextFiledView(
                            title: "Description",
                            topText: 10,
                            borderColor: Colors.grey.withOpacity(0.40),
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
                                    final isValid =
                                        formAddApt.currentState?.validate() ??
                                            false;

                                    if (isValid) {
                                      if (providerApt.selectGender == null) {
                                        showCommonDialog(
                                            context: context,
                                            title: "Error",
                                            content: "Please pick gender",
                                            isMessage: true);
                                      } else if (providerApt.selectAPTName ==
                                          null) {
                                        showCommonDialog(
                                            context: context,
                                            title: "Error",
                                            content:
                                                "Please pick appointment type",
                                            isMessage: true);
                                      } else {
                                        String userId = await getUserID();
                                        String? aptType;
                                        if (providerApt.selectAPTName ==
                                            "Routine Checkup") {
                                          aptType = "routine_checkup";
                                        } else if (providerApt.selectAPTName ==
                                            "Emergency") {
                                          aptType = "emergency";
                                        } else if (providerApt.selectAPTName ==
                                            "Consultation") {
                                          aptType = "consultation";
                                        } else if (providerApt.selectAPTName ==
                                            "Sick Visit") {
                                          aptType = "sick_visit";
                                        } else if (providerApt.selectAPTName ==
                                            "Examination") {
                                          aptType = "examination";
                                        }
                                        Map<String, dynamic> body = {
                                          "patient_name": tetPatientName.text,
                                          "patient_email": tetPatientEmail.text,
                                          "patient_phone": tetPatientPhone.text,
                                          "patient_gender":
                                              providerApt.selectGender,
                                          "appointment_type": aptType,
                                          "patientId": widget.patientID ??
                                              provider.selectedID,
                                          "doctorId": userId,
                                          "dateTime":
                                              widget.dateTime.toString(),
                                          "description": tetDesc.text,
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
                                            //   resetField();
                                            //provider.selectedID == null;
                                            Navigator.of(context).pop();
                                            //Navigator.of(context).pop();
                                          }
                                        });
                                      }
                                    } else {
                                      formAddApt.currentState?.save();
                                    }
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
                                        //resetField();
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
          ),
        ],
      ),
    );
  }

  commonDropDown(
      {required Size size,
      String? title,
      String? hint,
      List<String>? items,
      void Function(String?)? onChanged,
      String? selectedValue}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonTextWidget(
          text: title ?? "Gender",
          top: 10,
        ),
        const SizedBox(
          height: 5,
        ),
        CommonDropDownView(
            height: 50,
            hint: hint,
            onChanged: onChanged,
            selectedValue: selectedValue,
            horizontal: 5,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border:
                    Border.all(color: Colors.grey.withOpacity(0.40), width: 1)),
            size: size,
            items: items ?? ["Sa", "dddd", "dd"]),
      ],
    );
  }
}
