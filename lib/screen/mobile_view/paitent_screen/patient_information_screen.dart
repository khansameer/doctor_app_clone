import 'package:doctor_app/core/color_utils.dart';
import 'package:doctor_app/core/common/app_scaffold.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/screen/mobile_view/paitent_screen/charting_view.dart';
import 'package:doctor_app/screen/mobile_view/paitent_screen/patient_profile_view.dart';
import 'package:flutter/material.dart';

class PatientInformationScreen extends StatelessWidget {
  const PatientInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);

    return AppScaffold(
        right: 0,
        left: 0,
        appBar:
            commonAppBar(title: 'Patient information'.toUpperCase(), actions: [
          commonInkWell(
            onTap: () {},
            child: CommonTextWidget(
              text: 'EDIT',
              right: 16,
              textColor: colorWhite,
              fontWeight: FontWeight.w700,
            ),
          )
        ]),
        child: Column(
          children: [
            Container(
              color: const Color.fromRGBO(244, 245, 252, 1),
              width: screenSize.width,
              child: Row(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    margin: const EdgeInsets.all(16),
                    decoration: commonBoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.withOpacity(0.10),
                      border: Border.all(color: Colors.grey, width: 0.5),
                    ),
                    child: const Icon(
                      Icons.person,
                      color: colorGray,
                      size: 36,
                    ),
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonTextWidget(
                        text: 'Dr. Karen Remley',
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CommonTextWidget(
                        text: '6037',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      )
                    ],
                  ))
                ],
              ),
            ),
            Expanded(
              child: DefaultTabController(
                length: 2,
                child: Scaffold(
                  backgroundColor: const Color.fromRGBO(244, 245, 252, 1),
                  appBar: AppBar(
                    toolbarHeight: 0,
                    bottom: PreferredSize(
                        preferredSize: const Size.fromHeight(48),
                        child: Container(
                          color: const Color.fromRGBO(244, 245, 252, 1),
                          child: const TabBar(
                              unselectedLabelColor: Colors.grey,
                              labelColor: Colors.orange,
                              indicatorColor: Colors.orange,
                              tabs: [
                                Tab(
                                  child: Text(
                                    'CHARTING',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Tab(
                                  child: Text(
                                    'PROFILE',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                )
                              ]),
                        )),
                  ),
                  body: const TabBarView(
                    children: [
                      ChartingView(),
                      PatientProfileView(),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
