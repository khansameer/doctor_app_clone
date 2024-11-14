import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/custom_alert_dialog.dart';
import 'package:doctor_app/core/common/legend_item.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/context_extension.dart';
import 'package:doctor_app/core/responsive.dart';
import 'package:doctor_app/provider/appointments_provider.dart';
import 'package:doctor_app/provider/patient_provider.dart';
import 'package:doctor_app/screen/web_view/screen/calender/get_edit_appointments_details_widget.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'add_appointments_widget.dart';

class AdminCalenderScreen extends StatefulWidget {
  const AdminCalenderScreen({super.key});

  @override
  State<AdminCalenderScreen> createState() => _CalenderNewScreenState();
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}

class _CalenderNewScreenState extends State<AdminCalenderScreen> {
  List<bool> isSelected = [false, false, false];
  String? response;
  late CalendarController _calendarController;
  @override
  void initState() {
    isSelected = [false, true, false];
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<AppointmentsProvider>()
          .getAppointments(context: context)
          .then((value) {});
    });
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    var isMobile = Responsive.isMobile(context);
    return Consumer<AppointmentsProvider>(builder: (context, provider, child) {
      List<Appointment>? calendarAppointments =
          provider.appointmentsModel?.data?.appointments?.map((appointment) {
        if (appointment.patient != null) {
          DateTime dateTime =
              DateTime.parse(appointment.dateTime ?? DateTime.now().toString());

          var type = removeSpecialSymbolsAndEnsureSpace(
              '${appointment.appointmentType?.toString().toCapitalize()}');

          return Appointment(
            startTime: dateTime,
            id: appointment.id,

            recurrenceId: appointment.patient?.id,
            notes: appointment.reason,
            endTime: dateTime.add(const Duration(hours: 1)),
            // Assuming 1 hour duration
            subject: '${appointment.patient?.name.toString()}',
            color: type == 'Consultation'
                ? AppColors.colorBlue
                : type == 'Routine checkup'
                    ? AppColors.colorSurgery
                    : type == "Emergency"
                        ? Colors.red
                        : Colors.black,
          );
        } else {
          return Appointment(
              startTime: DateTime.now(), endTime: DateTime.now());
        }
      }).toList();
      return Container(
        height: size.height,
        width: size.width,
        color: AppColors.colorBgNew,
        child: Stack(
          children: [
            ListView(
              shrinkWrap: true,
              children: [
                CommonTextWidget(
                  letterSpacing: 1,
                  text: "Your Appointments",
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      isMobile
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CommonTextWidget(
                                    left: 10,
                                    text: "Daily appointments scheduler",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(
                                  width: size.width,
                                  child: _toggleView(isMobile: isMobile),
                                )
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CommonTextWidget(
                                    left: 10,
                                    text: "Daily appointments scheduler",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                                _toggleView(isMobile: isMobile)
                              ],
                            ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 7,
                            child: SizedBox(
                                height: size.height * 0.7,
                                child: commonSfCalendar(
                                    calendarAppointments: calendarAppointments,

                                    size: size)),
                          ),
                        ],
                      ),
                      const Divider(
                        thickness: 0.3,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: isMobile
                            ? const Wrap(
                                spacing:
                                    10.0, // Adds space between items horizontally
                                runSpacing:
                                    10.0, // Adds space between lines vertically
                                children: [
                                  LegendItem(
                                      color: Colors.red, text: "Emergency"),
                                  LegendItem(
                                      color: AppColors.colorBlue,
                                      text: "Consultation"),
                                  LegendItem(
                                      color: AppColors.colorLineChart2,
                                      text: "Examination"),
                                  LegendItem(
                                      color: AppColors.colorSurgery,
                                      text: "Routine checkup"),
                                  LegendItem(
                                      color: AppColors.colorDrawerLight,
                                      text: "Sick visit"),
                                ],
                              )
                            : SizedBox(
                                width: size.width,
                                height: 50.0, // Adjust the height as needed
                                child: provider
                                            .uniqueAppointmentTypes?.length !=
                                        null
                                    ? ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemCount: provider
                                            .uniqueAppointmentTypes?.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          var type =
                                              removeSpecialSymbolsAndEnsureSpace(
                                                  '${provider.uniqueAppointmentTypes?[index].toString().toCapitalize()}');
                                          return LegendItem(
                                              color: type == 'Consultation'
                                                  ? AppColors.colorBlue
                                                  : type == 'Routine checkup'
                                                      ? AppColors.colorSurgery
                                                      : type == "Emergency"
                                                          ? Colors.red
                                                          : Colors.black,
                                              text: removeSpecialSymbolsAndEnsureSpace(
                                                  '${provider.uniqueAppointmentTypes?[index].toString().toCapitalize()}'));
                                        },
                                      )
                                    : SizedBox.shrink(),
                              ) /*const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  LegendItem(
                                      color: Colors.red, text: "Emergency"),
                                  SizedBox(width: 10),
                                  LegendItem(
                                      color: AppColors.colorBlue,
                                      text: "Consultation"),
                                  SizedBox(width: 10),
                                  LegendItem(
                                      color: AppColors.colorLineChart2,
                                      text: "Examination"),
                                  SizedBox(width: 10),
                                  LegendItem(
                                      color: AppColors.colorSurgery,
                                      text: "Routine checkup"),
                                  SizedBox(width: 10),
                                  LegendItem(
                                      color: AppColors.colorDrawerLight,
                                      text: "Sick visit"),
                                ],
                              )*/
                        ,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            provider.isFetching ? showLoaderList() : const SizedBox.shrink()
          ],
        ),
      );
    });
  }

  _toggleView({required bool isMobile}) {
    return Row(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.center,
      mainAxisAlignment:
          isMobile ? MainAxisAlignment.center : MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          height: 45,
          child: ToggleButtons(
            borderRadius: BorderRadius.circular(8),
            fillColor: AppColors.colorBgNew,
            selectedColor: AppColors.colorActive,
            color: const Color.fromRGBO(250, 251, 253, 1),
            textStyle: commonTextStyle(fontWeight: FontWeight.w600),
            borderColor: AppColors.colorBgNew,
            borderWidth: 1,
            hoverColor: AppColors.colorBgNew,
            selectedBorderColor: AppColors.colorBgNew,
            onPressed: (int index) {
              if (index == 0) {
                setState(() {
                  _calendarController.view = CalendarView.day;
                });
              } else if (index == 1) {
                setState(() {
                  _calendarController.view = CalendarView.week;
                });
              } else if (index == 2) {
                setState(() {
                  _calendarController.view = CalendarView.month;
                });
              }
              /*  if(index==1){
                                        _changeCalendarView(CalendarView.week);
                                      }
                                      if(index==1){
                                        _changeCalendarView(CalendarView.month);
                                      }*/
              setState(() {
                for (int i = 0; i < isSelected.length; i++) {
                  isSelected[i] = i == index;
                }
              });
            },
            isSelected: isSelected,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 35 : 50.0, vertical: 5),
                child: commonText(
                  fontWeight: FontWeight.w400,
                  color: AppColors.colorGreen,
                  text: 'Day',
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 35 : 50.0, vertical: 5),
                child: commonText(
                  fontWeight: FontWeight.w400,
                  color: AppColors.colorGreen,
                  text: 'Week',
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 35 : 50.0, vertical: 5),
                child: commonText(
                  fontWeight: FontWeight.w400,
                  color: AppColors.colorGreen,
                  text: 'Month',
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  commonSfCalendar(
      {List<Appointment>? calendarAppointments,

      required Size size}) {

    var provider=context.read<PatientProvider>();
    return SfCalendar(
      monthViewSettings: MonthViewSettings(showAgenda: true),
      view: CalendarView.week,
      allowedViews: <CalendarView>[
        CalendarView.day,
        CalendarView.workWeek,
        CalendarView.week,
        CalendarView.month,
        CalendarView.timelineDay,
        CalendarView.timelineWeek,
        CalendarView.timelineWorkWeek,
        CalendarView.timelineMonth,
        CalendarView.schedule
      ],
      timeSlotViewSettings:
          TimeSlotViewSettings(

              //dayFormat: 'EEEE', dateFormat: 'dd', timeFormat: 'HH:mm a',
              timelineAppointmentHeight: 200),
      appointmentBuilder: (BuildContext context,
          CalendarAppointmentDetails calendarAppointmentDetails) {
        final Appointment appointment =
            calendarAppointmentDetails.appointments.first;


        return Column(
          children: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              onEnter: (details) {
                if (!provider.isProfileDialogOpen) {
                  String? patientID = '${appointment.recurrenceId}';

                  provider.showProfileOverlay(size: size,context:  context,patientID:patientID );
                }
              },
              onExit: (_) {
                if (provider.isProfileDialogOpen) {
                  provider.hideProfileOverlay();
                }
              },
              child: Container(
                width: calendarAppointmentDetails.bounds.width,
                height: calendarAppointmentDetails.bounds.height,
                color: appointment.color,
                child: Center(
                  child: CommonTextWidget(
                    fontSize: 12,
                    textColor: Colors.white,

                    text: appointment.subject,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            )
          ],
        );
      },
      controller: _calendarController,
      headerHeight: 0,
      onTap: (CalendarTapDetails details) {
        if (details.appointments != null && details.appointments!.isNotEmpty) {
          Appointment tappedAppointment = details.appointments!.first;
          String? appointmentId = '${tappedAppointment.id}';
          if (kDebugMode) {
            print('Appointment ID: $appointmentId');
          }

          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return CustomAlertDialog(
                  content: GetEditAppointmentsDetailsWidget(
                    appointmentsID: appointmentId,
                  ),
                );
              });
        } else {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return CustomAlertDialog(
                content: AddAppointmentsWidget(
                  dateTime: details.date,
                ),
              );
            },
          );
        }
      },
      backgroundColor: Colors.white,
      headerStyle: const CalendarHeaderStyle(backgroundColor: Colors.white),
      dataSource: AppointmentDataSource(calendarAppointments ?? []),
    );
  }
}

class AppointmentDataSource extends CalendarDataSource {
  AppointmentDataSource(List<Appointment> appointments) {
    this.appointments = appointments;
  }
}
