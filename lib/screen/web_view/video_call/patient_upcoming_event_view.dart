import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/common/error_page.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/provider/admin_dashboard_provider.dart';
import 'package:doctor_app/provider/patient_provider.dart';
import 'package:doctor_app/service/gloable_status_code.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/colors.dart';
import '../../../core/common/custom_alert_dialog.dart';
import '../../../provider/model/upcoming_appointment_model.dart';
import '../admin_dashboard_view/paitent_view/admin_patient_details_view.dart';

class PatientUpcomingEventView extends StatefulWidget {
  const PatientUpcomingEventView({super.key});

  @override
  State<PatientUpcomingEventView> createState() => _MainVideoCallState();
}

class _MainVideoCallState extends State<PatientUpcomingEventView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<AdminDashboardProvider>()
          .getUpComingAppointment(context: context)
          .then((value) {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    var provider = context.read<AdminDashboardProvider>();
    var providerPatient = context.read<PatientProvider>();
    List<bool> _isHovered = List.generate(
        provider.upComingAppointmentModel?.appointments?.length ?? 0,
        (_) => false);
    return SizedBox(
      height: size.height,
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8)),
            height: size.height,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView(
                children: [
                  CommonTextWidget(
                    text: "Upcoming appointments".toUpperCase(),
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                  globalStatusCode == 200 || globalStatusCode == 201
                      ? GroupedListView<Appointments, String>(
                          elements:
                              provider.upComingAppointmentModel?.appointments ??
                                  [],
                          shrinkWrap: true,
                          groupBy: (patient) => DateFormat('yyyy-MM-dd').format(
                              DateTime.parse(patient.dateTime ??
                                  DateTime.now().toString())),
                          // Group by category
                          groupComparator: (value1, value2) =>
                              value2.compareTo(value1),
                          order: GroupedListOrder.DESC,
                          useStickyGroupSeparators: true,
                          separator: Divider(
                            thickness: 0.3,
                          ),
                          stickyHeaderBackgroundColor: Colors.transparent,
                          groupSeparatorBuilder: (String value) => Padding(
                            padding: const EdgeInsets.only(
                                left: 0.0, right: 0, top: 8, bottom: 8),
                            child: CommonTextWidget(
                              text: value,
                              fontWeight: FontWeight.w600,
                              textColor: Colors.green.shade300,
                            ),
                          ),

                          indexedItemBuilder: (c, element, index) {
                            return SizedBox(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              MouseRegion(
                                                cursor:
                                                    SystemMouseCursors.click,
                                                onEnter: (details) {
                                                  if (!providerPatient
                                                      .isProfileDialogOpen) {
                                                    providerPatient
                                                        .showProfileOverlay(
                                                            size: size,
                                                            patientID: element
                                                                    .patient
                                                                    ?.id ??
                                                                "0",
                                                            context: context);
                                                  }
                                                },
                                                onExit: (_) {
                                                  if (providerPatient
                                                      .isProfileDialogOpen) {
                                                    providerPatient
                                                        .hideProfileOverlay();
                                                  }
                                                },
                                                child: Container(
                                                  child:
                                                      commonImageNetworkWidget(
                                                          width: 40,
                                                          height: 40,
                                                          boxFit: BoxFit.cover,
                                                          path: element
                                                              .patient
                                                              ?.profile
                                                              ?.profilePicture),
                                                ),
                                              ),

                                              const SizedBox(width: 10),
                                              // Patient Name and Email
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CommonTextWidget(
                                                    text:
                                                        '${element.patient?.name}',
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  CommonTextWidget(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    text:
                                                        '${element.patient?.email}',
                                                    fontSize: 10,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),

                                        // Action Buttons (Message, Video Call, etc.)
                                        Row(
                                          children: [
                                            MouseRegion(
                                              onEnter: (_) {
                                                provider.setHoveredChat(index);
                                              },
                                              onExit: (_) {
                                                provider.setHoveredChat(null);
                                              },
                                              child: AnimatedContainer(
                                                duration: const Duration(
                                                    milliseconds: 200),
                                                alignment: Alignment.topLeft,
                                                width: 35,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: provider.hoveredChat ==
                                                          index
                                                      ? AppColors.primary
                                                      : AppColors.colorBgNew,
                                                ),
                                                height: 35,
                                                child: Center(
                                                  child: Icon(
                                                    size: 15,
                                                    Icons.message,
                                                    color:
                                                        provider.hoveredChat ==
                                                                index
                                                            ? Colors.white
                                                            : Colors.grey,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            MouseRegion(
                                              onEnter: (_) {
                                                provider
                                                    .setHoveredVideoCall(index);
                                              },
                                              onExit: (_) {
                                                provider
                                                    .setHoveredVideoCall(null);
                                              },
                                              child: AnimatedContainer(
                                                duration: const Duration(
                                                    milliseconds: 200),
                                                alignment: Alignment.topLeft,
                                                width: 35,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: provider
                                                              .hoveredVideoCall ==
                                                          index
                                                      ? AppColors.primary
                                                      : AppColors.colorBgNew,
                                                ),
                                                height: 35,
                                                child: Center(
                                                  child: IconButton(
                                                      onPressed: () {},
                                                      icon: Icon(
                                                        size: 15,
                                                        Icons.videocam,
                                                        color:
                                                            provider.hoveredVideoCall ==
                                                                    index
                                                                ? Colors.white
                                                                : Colors.grey,
                                                      )),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 5),
                                            Builder(builder: (context) {
                                              return commonInkWell(
                                                onTap: () async {
                                                  showDialog(
                                                      barrierDismissible: false,
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return const CustomAlertDialog(
                                                          content:
                                                              AdminPatientDetailsView(),
                                                        );
                                                      });
                                                },
                                                child: Consumer<
                                                        AdminDashboardProvider>(
                                                    builder: (context, provider,
                                                        child) {
                                                  return MouseRegion(
                                                    onEnter: (_) {
                                                      provider.setHoveredEdit(
                                                          index);
                                                    },
                                                    onExit: (_) {
                                                      provider
                                                          .setHoveredEdit(null);
                                                    },
                                                    child: AnimatedContainer(
                                                      height: 35,
                                                      duration: const Duration(
                                                          milliseconds: 200),
                                                      margin:
                                                          const EdgeInsets.all(
                                                              5),
                                                      decoration: BoxDecoration(
                                                          color: provider
                                                                      .hoveredEdit ==
                                                                  index
                                                              ? AppColors
                                                                  .primary
                                                              : AppColors
                                                                  .colorBgNew,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8)),
                                                      child: Center(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 10.0,
                                                                  right: 10),
                                                          child:
                                                              CommonTextWidget(
                                                            fontSize: 12,
                                                            textColor: provider.hoveredEdit ==
                                                    index
                                                    ? Colors
                                                    .white
                                                    : null,
                                                            text:
                                                                "View Profile",
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                              );
                                            }),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                      : ErrorPage()
                ],
              ),
            ),
          ),
          context.watch<AdminDashboardProvider>().isFetching
              ? showLoaderList()
              : SizedBox.shrink()
        ],
      ),
    );
  }
}
