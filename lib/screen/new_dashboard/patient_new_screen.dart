
import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/provider/dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PatientNewScreen extends StatefulWidget {
  const PatientNewScreen({super.key});

  @override
  State<PatientNewScreen> createState() => _PatientNewScreenState();
}

class _PatientNewScreenState extends State<PatientNewScreen> {
  final bool _isExpanded = false;

  int? expandedIndex;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Consumer<DashboardProvider>(builder: (context, provider, child) {
      return ListView(
        children: [
          Container(
            color: Colors.white,
            width: size.width,
            padding: const EdgeInsets.all(0),
            height: size.height,
            child: ListView(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(7),
                      color: Colors.grey.withOpacity(0.10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    commonText(
                                        text: "Patient",
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                    commonText(
                                      left: 10,
                                      color: Colors.grey,
                                      text: "Clear Vision Eye Clinic",
                                      fontSize: 12,
                                    ),
                                    const Icon(
                                      Icons.keyboard_arrow_down_sharp,
                                      color: Colors.grey,
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    commonWithIconButton(
                                      icon: Icons.settings_outlined,
                                      btnText: "Settings",
                                      onPressed: () {},
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.person,
                            color: AppColors.colorMenuProfile,
                          ),
                          commonText(
                              left: 5,
                              text: "All Patients",
                              color: AppColors.colorMenuProfile,
                              fontWeight: FontWeight.w600),
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: 0.3,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 2,
                            child: Container(
                              height: size.height,
                              color: Colors.white,
                              child: ListView(
                                shrinkWrap: true,
                                children: [
                                  commonText(
                                      text: "Patients",
                                      left: 15,
                                      color: AppColors.colorMenuProfile,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14),
                                  // Parent expandable menu
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  commonMenu(
                                      backgroundColor: expandedIndex == 0
                                          ? Colors.blue
                                          : Colors.transparent,
                                      index: 0,
                                      onExpansionChanged: (isExpanded) {
                                        setState(() {
                                          expandedIndex = isExpanded ? 0 : null;
                                        });
                                        if (isExpanded) {
                                          provider.updateProfilePage =
                                              "Profile";
                                        }
                                      },
                                      headerText: "Profile",
                                      leading: Icon(
                                        Icons.person,
                                        color: expandedIndex == 0
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                      headerTextColor: expandedIndex == 0
                                          ? Colors.white
                                          : Colors.black,
                                      headerLeadingIconColor: Colors.black,
                                      children: []),
                                  commonMenu(
                                    headerTextColor: Colors.black,
                                    headerLeadingIconColor: Colors.black,
                                    headerText: "Appointment",
                                    leading: const Icon(
                                      Icons.calendar_month_sharp,
                                      color: Colors.black,
                                    ),
                                    children: [],
                                    onExpansionChanged: (isExpanded) {
                                      if (isExpanded) {
                                        //   provider.updatePage = "Patients";
                                        // provider.setSelectedMenu("Patients");
                                        // Optionally, update the index if necessary
                                        /*provider.setSelectedIndex(
                                      0); */ // Assuming 0 corresponds to the Profile screen
                                      }
                                    },
                                  ),
                                  commonMenu(
                                      headerTextColor: Colors.black,
                                      headerLeadingIconColor: Colors.black,
                                      headerText: "Communications",
                                      leading: const Icon(
                                        Icons.cell_tower,
                                        color: Colors.black,
                                      ),
                                      children: []),

                                  commonText(
                                      text: "EMR",
                                      left: 15,
                                      top: 10,
                                      bottom: 10,
                                      color: AppColors.colorMenuProfile,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14),
                                  commonMenu(
                                      index: 3,
                                      backgroundColor: expandedIndex == 3
                                          ? Colors.blue
                                          : Colors.transparent,
                                      headerTextColor: expandedIndex == 3
                                          ? Colors.white
                                          : Colors.black,
                                      leading: Icon(
                                        Icons.note_add_outlined,
                                        color: expandedIndex == 3
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                      onExpansionChanged: (isExpanded) {
                                        setState(() {
                                          expandedIndex = isExpanded ? 3 : null;
                                        });
                                        if (isExpanded) {
                                          provider.updateProfilePage =
                                              "client_note";
                                        }
                                      },
                                      headerLeadingIconColor: Colors.black,
                                      headerText: "Clinical Notes",
                                      children: []),
                                  commonMenu(
                                      headerTextColor: Colors.black,
                                      leading: const Icon(
                                        Icons.next_plan,
                                        color: Colors.black,
                                      ),
                                      headerLeadingIconColor: Colors.black,
                                      headerText: "Treatments Plan",
                                      children: []),
                                  commonMenu(
                                      headerTextColor: Colors.black,
                                      headerLeadingIconColor: Colors.black,
                                      leading: const Icon(
                                        Icons.check_circle,
                                        color: Colors.black,
                                      ),
                                      headerText: "Completed Procedures",
                                      children: []),
                                  commonMenu(
                                      headerTextColor: Colors.black,
                                      headerLeadingIconColor: Colors.black,
                                      leading: const Icon(
                                        Icons.file_copy_outlined,
                                        color: Colors.black,
                                      ),
                                      headerText: "Files",
                                      children: []),
                                  commonMenu(
                                      headerTextColor: Colors.black,
                                      leading: const Icon(
                                        Icons.precision_manufacturing,
                                        color: Colors.black,
                                      ),
                                      headerLeadingIconColor: Colors.black,
                                      headerText: "Prescriptions",
                                      showIcon: true),
                                  commonMenu(
                                      headerTextColor: Colors.black,
                                      headerLeadingIconColor: Colors.black,
                                      leading: const Icon(
                                        Icons.timeline,
                                        color: Colors.black,
                                      ),
                                      headerText: "Timeline",
                                      showIcon: true),
                                  commonText(
                                      text: "Billing",
                                      left: 15,
                                      top: 10,
                                      bottom: 10,
                                      color: AppColors.colorMenuProfile,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14),

                                  commonMenu(
                                      headerTextColor: Colors.black,
                                      headerLeadingIconColor: Colors.black,
                                      headerText: "Invoices",
                                      leading: const Icon(
                                        Icons.file_copy_sharp,
                                        color: Colors.black,
                                      ),
                                      children: []),
                                  commonMenu(
                                      headerTextColor: Colors.black,
                                      headerLeadingIconColor: Colors.black,
                                      headerText: "Payments",
                                      leading: const Icon(
                                        Icons.payment,
                                        color: Colors.black,
                                      ),
                                      children: []),
                                  commonMenu(
                                      headerTextColor: Colors.black,
                                      headerLeadingIconColor: Colors.black,
                                      headerText: "Ledger",
                                      leading: const Icon(
                                        Icons.leaderboard,
                                        color: Colors.black,
                                      ),
                                      children: []),
                                ],
                              ),
                            )),
                        // const Expanded(flex: 8, child: PatientProfilePage())
                        Expanded(
                          flex: 8,
                          child: provider.currentPageProfile,
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
