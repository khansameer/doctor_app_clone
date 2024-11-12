import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/image/image_path.dart';
import 'package:doctor_app/core/string/string_utils.dart';
import 'package:doctor_app/provider/admin_dashboard_provider.dart';
import 'package:doctor_app/provider/report_provier.dart';
import 'package:doctor_app/screen/web_view/admin_dashboard_view/patient_profile_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../provider/model/upcoming_appointment_model.dart';

class AdminUpComingAppointmentsView extends StatefulWidget {
  const AdminUpComingAppointmentsView({super.key, required this.provider});
  final AdminDashboardProvider provider;

  @override
  State<AdminUpComingAppointmentsView> createState() =>
      _AdminUpComingAppointmentsViewState();
}

class _AdminUpComingAppointmentsViewState
    extends State<AdminUpComingAppointmentsView> {
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

  Map<String, List<Appointments>> groupAppointmentsByDate(
      List<Appointments> appointments) {
    Map<String, List<Appointments>> groupedAppointments = {};

    for (var appointment in appointments) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(
          DateTime.parse(appointment.dateTime ?? DateTime.now.toString()));
      if (groupedAppointments.containsKey(formattedDate)) {
        groupedAppointments[formattedDate]?.add(appointment);
      } else {
        groupedAppointments[formattedDate] = [appointment];
      }
    }

    return groupedAppointments;
  }

  @override
  Widget build(BuildContext context) {
    var provider = context.read<AdminDashboardProvider>();
    var size = MediaQuery.sizeOf(context);

    final appointments = provider.upComingAppointmentModel?.appointments ?? [];
    Map<String, List> groupedAppointments = {};

    for (var appointment in appointments) {
      var dateKey = DateFormat('yyyy-MM-dd').format(
          DateTime.parse(appointment.dateTime ?? DateTime.now().toString()));
      if (!groupedAppointments.containsKey(dateKey)) {
        groupedAppointments[dateKey] = [];
      }
      groupedAppointments[dateKey]?.add(appointment);
    }

    return Container(
      height: size.height,
      margin: const EdgeInsets.all(20),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            ListView(
              shrinkWrap: true,
              children: [
                CommonTextWidget(
                  text: "Upcoming appointments".toUpperCase(),
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),

                SizedBox(
                  height: size.height,
                  child: appointments.isNotEmpty
                      ? ListView.separated(
                          shrinkWrap: true,
                          itemCount: groupedAppointments.keys.length,
                          itemBuilder: (context, dateIndex) {
                            String dateKey =
                                groupedAppointments.keys.elementAt(dateIndex);


                            var appointmentsForDate =
                                groupedAppointments[dateKey];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CommonTextWidget(
                                    fontWeight: FontWeight.w600,
                                    textColor: AppColors.primary,
                                    text: DateFormat('d MMMM, yyyy')
                                        .format(DateTime.parse(dateKey)),
                                  ),
                                ),
                                ListView.separated(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: appointmentsForDate?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    var aptData = appointmentsForDate?[index];
                                    return Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      commonImageNetworkWidget(
                                                          width: 40,
                                                          boxFit:
                                                              BoxFit.cover,
                                                          height: 40,
                                                          path: aptData
                                                              .patient
                                                              .profilePicture),

                                                      const SizedBox(width: 10),
                                                      // Patient Name and Email
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          CommonTextWidget(
                                                            text:
                                                                '${aptData.patient.name}',
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                          CommonTextWidget(
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            text:
                                                                '${aptData.patient.email}',
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
                                                        //  widget.provider.setHoveredChat(index);
                                                      },
                                                      onExit: (_) {
                                                        // widget.provider.setHoveredChat(null);
                                                      },
                                                      child: AnimatedContainer(
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    200),
                                                        alignment:
                                                            Alignment.topLeft,
                                                        width: 35,
                                                        decoration: BoxDecoration(
                                                            color: widget
                                                                        .provider
                                                                        .hoveredChat ==
                                                                    index
                                                                ? AppColors
                                                                    .primary
                                                                : AppColors
                                                                    .colorBgNew,
                                                            shape: BoxShape
                                                                .circle),
                                                        height: 35,
                                                        child: Center(
                                                          child: Icon(
                                                            size: 15,
                                                            Icons.message,
                                                            color: widget
                                                                        .provider
                                                                        .hoveredChat ==
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
                                                        widget.provider
                                                            .setHoveredVideoCall(
                                                                dateIndex);
                                                      },
                                                      onExit: (_) {
                                                        widget.provider
                                                            .setHoveredVideoCall(
                                                                null);
                                                      },
                                                      child: AnimatedContainer(
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    200),
                                                        alignment:
                                                            Alignment.topLeft,
                                                        width: 35,
                                                        decoration: BoxDecoration(
                                                            color: widget
                                                                        .provider
                                                                        .hoveredVideoCall ==
                                                                    index
                                                                ? AppColors
                                                                    .primary
                                                                : AppColors
                                                                    .colorBgNew,
                                                            shape: BoxShape
                                                                .circle),
                                                        height: 35,
                                                        child: Center(
                                                          child: Icon(
                                                            size: 15,
                                                            Icons.videocam,
                                                            color: widget
                                                                        .provider
                                                                        .hoveredVideoCall ==
                                                                    index
                                                                ? Colors.white
                                                                : Colors.grey,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 5),
                                                    Builder(builder: (context) {
                                                      return commonInkWell(
                                                        onTap: () async {


                                                          var data=appointments[dateIndex];
                                                          await showAlignedDialog(
                                                          context: context,
                                                          isGlobal: false,

                                                          barrierColor: Colors.transparent,
                                                          avoidOverflow: false,


                                                          targetAnchor: AlignmentDirectional(1, 1.0)
                                                              .resolve(Directionality.of(context)),
                                                          followerAnchor: AlignmentDirectional(1, -1.0)
                                                              .resolve(Directionality.of(context)),
                                                          builder: (dialogContext) {
                                                            return Material(
                                                              color: Colors.transparent,
                                                              child: GestureDetector(
                                                                onTap: () =>
                                                                    FocusScope.of(dialogContext).unfocus(),
                                                                child:
                                                                SizedBox(
                                                                    width:
                                                                    size.width *
                                                                        0.2,
                                                                    child: PatientProfileDialog(
                                                                appointment: appointments[dateIndex],
                                                                      aptData: aptData,)),
                                                              ),
                                                            );
                                                          },
                                                          );


                                                        },
                                                        child: Consumer<
                                                                AdminDashboardProvider>(
                                                            builder: (context,
                                                                provider,
                                                                child) {
                                                          return MouseRegion(
                                                            onEnter: (_) {
                                                              provider
                                                                  .setHoveredEdit(
                                                                      index);
                                                            },
                                                            onExit: (_) {
                                                              provider
                                                                  .setHoveredEdit(
                                                                      null);
                                                            },
                                                            child:
                                                                AnimatedContainer(
                                                              height: 35,
                                                              duration:
                                                                  const Duration(
                                                                      milliseconds:
                                                                          200),
                                                              margin:
                                                                  const EdgeInsets
                                                                      .all(5),
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
                                                                          .circular(
                                                                              8)),
                                                              child: Center(
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                      .only(
                                                                      left:
                                                                          10.0,
                                                                      right:
                                                                          10),
                                                                  child:
                                                                      CommonTextWidget(
                                                                    fontSize:
                                                                        12,
                                                                    textColor: provider.hoveredEdit ==
                                                                            index
                                                                        ? Colors
                                                                            .white
                                                                        : null,
                                                                    text:
                                                                        "View Profile",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
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
                                          Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Row(
                                              children: [
                                                Icon(Icons.access_time,
                                                    color: Colors.grey),
                                                SizedBox(width: 10),
                                                Text(
                                                  DateFormat('h:mm a').format(
                                                      DateTime.parse(
                                                          aptData.dateTime)),
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return Divider(thickness: 0.3);
                                  },
                                ),
                              ],
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const Divider(
                              thickness: 0.3,
                            );
                          },
                        )
                      : Center(
                          child: CommonTextWidget(
                            text: "",
                          ),
                        ),
                )
              ],
            ),
            context.watch<AdminDashboardProvider>().isFetching
                ? showLoaderList()
                : SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}



