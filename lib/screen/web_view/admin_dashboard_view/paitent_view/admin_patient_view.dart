import 'package:doctor_app/core/color_utils.dart';
import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/provider/admin_dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../screen/patient_profile_page.dart';

class AdminPatientView extends StatelessWidget {
  const AdminPatientView({super.key});

  @override
  Widget build(BuildContext context) {
    return const TabView();
  }
}

class TabView extends StatelessWidget {
  const TabView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    final tabProvider = Provider.of<AdminDashboardProvider>(context);
    final isSelected = [
      tabProvider.selectedIndex == 0,
      tabProvider.selectedIndex == 1,
      tabProvider.selectedIndex == 2,
      tabProvider.selectedIndex == 3,
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ToggleButtons(
              borderRadius: BorderRadius.circular(8),
              fillColor: Colors.blue.shade50,
              selectedColor: AppColors.colorText,
              color: AppColors.colorText,
              textStyle: commonTextStyle(fontWeight: FontWeight.w600),
              borderColor: colorBGWithOpacity,
              borderWidth: 2,
              selectedBorderColor: Colors.transparent,
              isSelected: isSelected,
              onPressed: (index) {
                tabProvider.setTab(index);

                print('=========index=====$index==');
                // Navigate to the respective page based on the selected index
                if (index == 0) {
                  tabProvider.setPatientDetailsPage(
                      value: "all", context: context);
                  //    Navigator.push(context, MaterialPageRoute(builder: (context) => AllPage()));
                } else if (index == 1) {
                  tabProvider.setPatientDetailsPage(
                      value: "male", context: context);
                  //  Navigator.push(context, MaterialPageRoute(builder: (context) => MenPage()));
                } else if (index == 2) {
                  tabProvider.setPatientDetailsPage(
                      value: "female", context: context);
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => WomenPage()));
                } else if (index == 3) {
                  tabProvider.setPatientDetailsPage(
                      value: "All List", context: context);
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => WomenPage()));
                }
              },
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text('All'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text('Men'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text('Women'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text('All List'),
                ),
              ],
            ),
            Expanded(child: tabProvider.currentPatientPage)
          ],
        ),
      ),
    );
  }
}
