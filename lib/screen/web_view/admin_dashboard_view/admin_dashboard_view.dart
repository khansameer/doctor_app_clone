import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/responsive.dart';
import 'package:doctor_app/provider/admin_dashboard_provider.dart';
import 'package:doctor_app/screen/web_view/admin_dashboard_view/admin_over_all_appointment.dart';
import 'package:doctor_app/screen/web_view/admin_dashboard_view/admin_patient_graph.dart';
import 'package:doctor_app/screen/web_view/admin_dashboard_view/admin_pie_graph.dart';
import 'package:doctor_app/screen/web_view/admin_dashboard_view/admin_upcomming_appointments_view.dart';
import 'package:doctor_app/screen/web_view/admin_dashboard_view/dashboard_patient_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminDashboardView extends StatefulWidget {
  const AdminDashboardView({super.key});

  @override
  State<AdminDashboardView> createState() => _AdminDashboardViewState();
}

class _AdminDashboardViewState extends State<AdminDashboardView> {
  @override
  Widget build(BuildContext context) {
    var isMobile = Responsive.isMobile(context);
    return Container(
      decoration: BoxDecoration(
          color: AppColors.colorBgNew, borderRadius: BorderRadius.circular(10)),
      child:
          Consumer<AdminDashboardProvider>(builder: (context, provider, child) {
        return isMobile ? _mobile(provider) : _webView(provider, context);
      }),
    );
  }

  _webView(AdminDashboardProvider provider, BuildContext context) {
    var isTablet = Responsive.isTablet(context);
    return ListView(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 6,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DashboardPatientView(
                    provider: provider,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 500,
                          child: const AdminPatientGraph(),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 500,
                          child: AdminPieGraph(),
                        ),
                      )
                    ],
                  ),
                  AdminOverAllAppointment(
                    provider: provider,
                  ),
                ],
              ),
            ),
            Expanded(
                flex: isTablet ? 4 : 3,
                child: AdminUpComingAppointmentsView(
                  provider: provider,
                ))
          ],
        ),
      ],
    );
  }

  _mobile(AdminDashboardProvider provider) {
    return ListView(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DashboardPatientView(
              provider: provider,
            ),
            const AdminPatientGraph(), const AdminPieGraph(),
            AdminOverAllAppointment(
              provider: provider,
            ),
            //
          ],
        ),
        AdminUpComingAppointmentsView(
          provider: provider,
        )
      ],
    );
  }
}
