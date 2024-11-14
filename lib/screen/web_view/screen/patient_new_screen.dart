import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/provider/dashboard_provider.dart';
import 'package:doctor_app/provider/patient_provider.dart';
import 'package:doctor_app/screen/web_view/admin_dashboard_view/paitent_view/admin_patient_view.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PatientNewScreen extends StatefulWidget {
  const PatientNewScreen({super.key});

  @override
  State<PatientNewScreen> createState() => _PatientNewScreenState();
}

class _PatientNewScreenState extends State<PatientNewScreen> {
  int? expandedIndex;
  SideMenuController sideMenu = SideMenuController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DashboardProvider>().getUserName();
      context
          .read<PatientProvider>()
          .getPatientDetails(context: context)
          .then((value) {});
    });
    sideMenu.addListener((index) {

    });
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);

    return Consumer<DashboardProvider>(builder: (context, provider, child) {
      return SizedBox(
        width: size.width,
        height: size.height,
        child: ListView(
          children: [
            CommonTextWidget(
              letterSpacing: 1,
              text: "Patients List",
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: size.width,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.all(0),
              height: size.height,
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: AdminPatientView(),
              )
              ,
            ),
          ],
        ),
      );
    });
  }

}
