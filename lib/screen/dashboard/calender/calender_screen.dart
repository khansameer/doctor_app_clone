import 'package:doctor_app/core/color_utils.dart';
import 'package:doctor_app/core/common/app_scaffold.dart';
import 'package:doctor_app/core/common/common_drop_down_view.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/provider/dashboard_provider.dart';
import 'package:doctor_app/screen/dashboard/calender/calender_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CalenderScreen extends StatelessWidget {
  const CalenderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return AppScaffold(
      left: 0,
      right: 0,

      appBar: commonAppBar(title: "Calender",color: colorBG,colorText:colorText,leading: Container() ,actions: [
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: colorText,
            ))
      ]),


      child: Consumer<DashboardProvider>(builder: (context, provider, child) {
        return SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              Expanded(
                  child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: IntrinsicHeight(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CommonTextWidget(
                                    text: "Practice".toUpperCase(),
                                    textColor: Colors.grey,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                  CommonDropDownView(
                                    size: size,
                                    decoration: const BoxDecoration(),
                                    items: provider.items,
                                    onChanged: (String? value) {
                                      provider.selectionValue = value ?? '';
                                    },
                                    selectedValue: provider.selectedValue,
                                    hint: "Medicine",
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const VerticalDivider(
                            thickness: 0.3,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CommonTextWidget(
                                    text: "Practice".toUpperCase(),
                                    textColor: Colors.grey,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                  CommonDropDownView(
                                    size: size,
                                    decoration: const BoxDecoration(),
                                    items: provider.items,
                                    onChanged: (String? value) {
                                      provider.selectionValue = value ?? '';
                                    },
                                    selectedValue: provider.selectedValue,
                                    hint: "Medicine",
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(
                    thickness: 0.3,
                  ),
                  CalenderView(provider: provider),
                  MeetingView(
                    provider: provider,
                  ),
                ],
              )),
              Container(
                color: colorGreen.withOpacity(0.03),
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonTextWidget(
                      text: "Block Or set Reminder".toUpperCase(),
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      textColor: colorAmber,
                    ),
                    CommonTextWidget(
                      text: "Add Appointment".toUpperCase(),
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      textColor: colorAmber,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
