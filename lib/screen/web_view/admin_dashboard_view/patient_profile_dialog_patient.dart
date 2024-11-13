import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/common_button_widget.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/context_extension.dart';
import 'package:doctor_app/provider/model/upcoming_appointment_model.dart';
import 'package:doctor_app/provider/report_provier.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../model/patient_details_model.dart';

class PatientProfileDialogPatient extends StatelessWidget {
  const PatientProfileDialogPatient({
    super.key,
    this.aptData,
    this.appointment,
  });
  final dynamic aptData;
  final Patients? appointment;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.colorWhite,
      child: SizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _commonIcon(icon: Icons.edit),
                _commonIcon(
                    icon: Icons.close,
                    onTap: () {
                      Navigator.of(context).pop();
                    }),
              ],
            ),
            Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Row(
                  children: [
                    commonImageNetworkWidget(
                        width: 50,
                        boxFit: BoxFit.cover,
                        height: 50,
                        path: '${appointment?.profile?.profilePicture}'),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonTextWidget(
                      fontWeight: FontWeight.w700,
                      text:
                          '${appointment?.firstName.toString()} ${appointment?.lastName.toString()}',
                      fontSize: 16,
                    ),
                    CommonTextWidget(
                      top: 5,
                      fontWeight: FontWeight.w400,
                      text: '${appointment?.email}',
                      textColor: Colors.grey,
                      fontSize: 12,
                    ),
                    CommonTextWidget(
                      text: "Profile Completed",
                      fontSize: 12,
                      top: 5,
                      fontWeight: FontWeight.w400,
                      textColor: Colors.grey,
                    ),
                    /*CommonTextWidget(
                      text: "Show balance",
                      fontSize: 12,
                      top: 5,
                      fontWeight: FontWeight.w600,
                      textColor: AppColors.primary,
                    )*/
                  ],
                )
              ],
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  _commonAvailableView(title: '${appointment?.phoneNumber}'),
                  const SizedBox(
                    height: 10,
                  ),
                  _commonAvailableView(
                      title: '${appointment?.email}', icon: Icons.email),
                  const SizedBox(
                    height: 10,
                  ),
                  _commonAvailableView(
                      title: '${appointment?.gender.toString().toCapitalize()}',
                      icon: Icons.person),
                  const SizedBox(
                    height: 10,
                  ),
                  _commonAvailableView(
                      title: appointment?.dateOfBirth != null
                          ? '${appointment?.dateOfBirth.toString().toString().toCapitalize()}'
                          : "",
                      icon: Icons.cake)
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 5,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.settings_outlined,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            /* text: removeSpecialSymbolsAndEnsureSpace(
                                '${appointment?.appointmentType.toString().toCapitalize()} '),*/
                            // text: 'asassaas',
                            style: commonTextStyle(
                                fontWeight: FontWeight.w600, fontSize: 12),
                            children: <TextSpan>[
                              TextSpan(
                                  text: ' with ',
                                  style: commonTextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400)),
                              /* TextSpan(
                                  text:
                                  'Dr.${appointment?.name.toString()}',
                                  style: commonTextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12)),*/
                              TextSpan(
                                  text: ' at ',
                                  style: commonTextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400)),
                              /*   TextSpan(
                                  text: DateFormat('yyyy-MM-dd hh:mm:a').format(
                                      DateTime.parse(
                                          appointment?.dateTime.toString() ??
                                              DateTime.now().toString())),
                                  style: commonTextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600)),*/
                              TextSpan(
                                  text: ' for 15 min',
                                  style: commonTextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400)),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CommonButtonWidget(
                        text: "No Show",
                        top: 20,
                        fontSize: 12,
                        borderWidth: 0.5,
                        colorText: AppColors.colorTextNew,
                        colorButton: Colors.transparent,
                        colorBorder: Colors.black,
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _commonIcon({IconData? icon, VoidCallback? onTap, Color? color}) {
    return IconButton(
        onPressed: onTap,
        icon: Icon(
          icon ?? Icons.copy_outlined,
          color: color ?? Colors.grey,
        ));
  }

  _commonAvailableView({IconData? icon, String? title}) {
    return Row(
      children: [
        const SizedBox(
          width: 10,
        ),
        Icon(
          icon ?? Icons.call,
          color: Colors.grey,
          size: 20,
        ),
        CommonTextWidget(
          left: 15,
          fontSize: 13,
          textColor: Colors.grey,
          fontWeight: FontWeight.w400,
          text: title ?? "Not Available",
        )
      ],
    );
  }
}
