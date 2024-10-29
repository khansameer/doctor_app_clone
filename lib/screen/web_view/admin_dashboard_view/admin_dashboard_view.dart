import 'package:doctor_app/core/responsive.dart';
import 'package:doctor_app/provider/admin_dashboard_provider.dart';
import 'package:doctor_app/screen/web_view/admin_dashboard_view/admin_over_all_appointment.dart';
import 'package:doctor_app/screen/web_view/admin_dashboard_view/admin_patient_graph.dart';
import 'package:doctor_app/screen/web_view/admin_dashboard_view/admin_upcomming_appointments_view.dart';
import 'package:doctor_app/screen/web_view/admin_dashboard_view/dashboard_patient_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminDashboardView extends StatelessWidget {
  const AdminDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    var isMobile = Responsive.isMobile(context);
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child:
          Consumer<AdminDashboardProvider>(builder: (context, provider, child) {
        return isMobile?_mobile(provider):_webView(provider);
      }),
    );
  }

  _webView(AdminDashboardProvider provider){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DashboardPatientView(provider: provider,),
              const AdminPatientGraph(),
              AdminOverAllAppointment(provider: provider,),
            ],
          ),
        ),
        Expanded(
            child: AdminUpComingAppointmentsView(provider: provider,))
      ],
    );
  }

  _mobile(AdminDashboardProvider provider){
    return ListView(

      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DashboardPatientView(provider: provider,),
            const AdminPatientGraph(),
            AdminOverAllAppointment(provider: provider,),
           //
          ],
        ),
        AdminUpComingAppointmentsView(provider: provider,)
      ],
    );
  }
}
