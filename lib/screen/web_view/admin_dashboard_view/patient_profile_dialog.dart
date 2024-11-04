import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/common_button_widget.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/provider/report_provier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PatientProfileDialog extends StatelessWidget {
  const PatientProfileDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                // _commonIcon(),
            //    _commonIcon(),
                _commonIcon(icon: Icons.edit),
                _commonIcon(

                    icon: Icons.close,onTap: (){
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
                    commonProfileIcon(
                        path: context.read<ReportProvider>().image)
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
                      text: context.read<ReportProvider>().name,
                      fontSize: 16,
                    ),
                    CommonTextWidget(
                      top: 5,
                      fontWeight: FontWeight.w400,
                      text: "1402",
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
                    CommonTextWidget(
                      text: "Show balance",
                      fontSize: 12,
                      top: 5,
                      fontWeight: FontWeight.w600,
                      textColor: AppColors.primary,
                    )
                  ],
                )
              ],
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  _commonAvailableView(),
                  const SizedBox(
                    height: 10,
                  ),
                  _commonAvailableView(icon: Icons.credit_card_outlined),
                  const SizedBox(
                    height: 10,
                  ),
                  _commonAvailableView(icon: Icons.credit_card_outlined),
                  const SizedBox(
                    height: 10,
                  ),
                  _commonAvailableView(
                      title: "Token Not Available", icon: Icons.token)
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Row(
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
                              text: 'In-Clinic Appointment ',
                              style: commonTextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 12),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'with ',
                                    style: commonTextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400)),
                                TextSpan(
                                    text: 'Dr.Emily Davis',
                                    style: commonTextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12)),
                                TextSpan(
                                    text: ' at',
                                    style: commonTextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400)),
                                TextSpan(
                                    text: ' 9:45',
                                    style: commonTextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600)),
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
                  ),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CommonButtonWidget(
                        text: "No Show",
                        colorText: AppColors.colorTextNew,
                        colorButton: Colors.white,
                        colorBorder: Colors.black,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _commonIcon({IconData? icon,VoidCallback? onTap,Color ?color}) {
    return IconButton(
        onPressed:onTap,
        icon: Icon(
          icon ?? Icons.copy_outlined,
          color: color??Colors.grey,
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
