import 'package:doctor_app/core/colors.dart';

import 'package:doctor_app/core/common/common_textfield.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/responsive.dart';
import 'package:doctor_app/provider/admin_dashboard_provider.dart';
import 'package:doctor_app/provider/patient_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    var isMobile = Responsive.isMobile(context);
    final tabProvider = Provider.of<AdminDashboardProvider>(context);
    final isSelected = [
      tabProvider.selectedIndex == 0,
      tabProvider.selectedIndex == 1,
      tabProvider.selectedIndex == 2,
      // tabProvider.selectedIndex == 3,
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isMobile
                ? Column(
                    children: [
                      _searchView(context: context),
                      const SizedBox(
                        height: 10,
                      ),
                      _viewToggleButtons(
                          tabProvider: tabProvider,
                          context: context,
                          isSelected: isSelected),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 8,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 20, top: 10),
                          height: 40,
                          child: _viewToggleButtons(
                              tabProvider: tabProvider,
                              context: context,
                              isSelected: isSelected),
                        ),
                      ),
                      Expanded(
                        child: _searchView(context: context),
                      ),
                    ],
                  ),
            Expanded(child: tabProvider.currentPatientPage)
          ],
        ),
      ),
    );
  }

  _searchView({required BuildContext context}) {
    return SizedBox(
      height: 40,
      child: CommonTextField(
        onChange: (query) {
          context.read<PatientProvider>().updateSearchQuery(query);
        },
        hint: "Search Patient Name / ID /Phone number",
        colorFill: Colors.white,
        //  hint: "Search Patient Name/ID/Phone number",
      ),
    );
  }

  _viewToggleButtons(
      {required AdminDashboardProvider tabProvider,
      required BuildContext context,
      required List<bool> isSelected}) {
    var isMobile = Responsive.isMobile(context);
    return ToggleButtons(
      borderRadius: BorderRadius.circular(8),
      fillColor: AppColors.colorBgNew,
      selectedColor: AppColors.colorText,
      color: const Color.fromRGBO(250, 251, 253, 1),
      textStyle: commonTextStyle(fontWeight: FontWeight.w600),
      borderColor: AppColors.colorBgNew,
      borderWidth: 1,
      hoverColor: AppColors.colorBgNew,
      selectedBorderColor: AppColors.colorBgNew,
      isSelected: isSelected,
      onPressed: (index) {
        tabProvider.setTab(index);

        if (index == 0) {
          tabProvider.setPatientDetailsPage(value: "all", context: context);
        } else if (index == 1) {
          tabProvider.setPatientDetailsPage(value: "male", context: context);
        } else if (index == 2) {
          tabProvider.setPatientDetailsPage(value: "female", context: context);
        }
      },
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 30 : 24.0),
          child: commonText(
            text: 'All',
            fontWeight: FontWeight.w400,
            color: AppColors.colorBlue,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 30 : 24.0),
          child: commonText(
              text: 'Men',
              fontWeight: FontWeight.w400,
              color: AppColors.colorBlue),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 30 : 24.0),
          child: commonText(
              text: 'Women',
              fontWeight: FontWeight.w400,
              color: AppColors.colorBlue),
        ),
      ],
    );
  }
}
