import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/common/error_page.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/responsive.dart';
import 'package:doctor_app/provider/dashboard_provider.dart';
import 'package:doctor_app/screen/web_view/admin_dashboard_view/my_address/my_address_screen.dart';
import 'package:doctor_app/screen/web_view/admin_dashboard_view/notification/notification_setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../mobile_view/profile/edit_profile_screen.dart';
import '../../admin_dashboard_view/prescription/setting_prescription_screen.dart';
import '../../billing/setting_billing_view.dart';

class AdminSettingScreen extends StatefulWidget {
  const AdminSettingScreen({super.key});

  @override
  State<AdminSettingScreen> createState() => _AdminSettingScreenState();
}

class _AdminSettingScreenState extends State<AdminSettingScreen> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DashboardProvider>().getUserName();
      context.read<DashboardProvider>().getEmail();
    });
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);

    return Consumer<DashboardProvider>(builder: (context, provider, child) {
      return Container(
        color: Colors.white,
        width: size.width,
        padding: const EdgeInsets.all(0),
        height: size.height,
        child: DefaultTabController(
          length: 9,
          child: Column(
            children: [
              Container(
                height: 80,
                padding: const EdgeInsets.all(10.0),
                child: Container(


                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      10,
                    ),

                    color: const Color.fromRGBO(250, 251, 253, 1),
                  ),
                  child: TabBar(
                    unselectedLabelStyle: commonTextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                    isScrollable: false,
                    dividerColor: Colors.white,
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabAlignment: TabAlignment.fill,

                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.colorBgNew),
                    labelStyle: commonTextStyle(
                        fontSize: 13, fontWeight: FontWeight.w700),
                    labelColor: AppColors.primary,
                    // indicatorColor: AppColors.colorTextNew,
                    unselectedLabelColor: AppColors.primary.withOpacity(0.50),

                    tabs: const [
                      Tab(text: 'Clinic Address'),
                      Tab(text: 'Notification'),
                      Tab(text: 'Consent Forms'),
                      Tab(text: 'Billing'),
                      Tab(text: 'Prescriptions'),
                      Tab(text: 'Calender'),
                      Tab(text: 'Communications'),
                      Tab(text: 'Contacts'),
                      Tab(text: 'My Profile'),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    const MyAddressScreen(),
                    const NotificationSettingScreen(),
                    const ErrorPage(),
                        Container(
                        color: AppColors.colorBgNew,
                        child: const SettingBillingView()),
                    const SettingPrescriptionScreen(),
                    const ErrorPage(),
                    const ErrorPage(),
                    const ErrorPage(),
                    const EditProfileScreen()
                  ],
                ),
              ),

            ],
          ),
        ),
      );
    });
  }
}
