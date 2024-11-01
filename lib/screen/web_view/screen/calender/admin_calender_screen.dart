import 'package:doctor_app/core/color_utils.dart';
import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/CustomAlertDialog.dart';
import 'package:doctor_app/core/common/LegendItem.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/responsive.dart';
import 'package:doctor_app/provider/appointments_provider.dart';
import 'package:doctor_app/screen/web_view/screen/calender/get_edit_appointments_details_widget.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'add_appointments_widget.dart';
import 'calender_view_left_screen.dart';

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
          provider.appointmentsModel?.appointments?.map((appointment) {
        if (appointment.patient != null) {
          DateTime dateTime =
              DateTime.parse(appointment.dateTime ?? DateTime.now().toString());

          return Appointment(
            startTime: dateTime,
            id: appointment.sId,
            notes: appointment.reason,
            endTime: dateTime.add(const Duration(hours: 1)),
            // Assuming 1 hour duration
            subject: appointment.patientName.toString(),
            color: Colors.blue, // Set a color for the appointment
          );
        } else {
          return Appointment(
              startTime: DateTime.now(), endTime: DateTime.now());
        }
      }).toList();
      return Stack(
        children: [
          ListView(
            shrinkWrap: true,
            children: [
              CommonTextWidget(
                letterSpacing: 1,
                text: "Your appointments",
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /*  isMobile?SizedBox.shrink():  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CommonTextWidget(
                          left: 0,
                          text: "Daily appointments scheduler",fontWeight: FontWeight.w600,

                        fontSize: 16,),
                      ),
                    ),*/
                    /*  isMobile
                        ? Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.arrow_back_ios,
                                          size: 15,
                                        ),
                                        commonText(
                                            left: 5,
                                            right: 5,
                                            text: formatDate(
                                                formatDate: dMMYYYY,
                                                date: DateTime.now()),
                                            fontWeight: FontWeight.w700),
                                        const Icon(
                                          Icons.arrow_forward_ios,
                                          size: 15,
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Container(
                                      height: 35,
                                      decoration: commonBoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Colors.black, width: 1),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      padding: const EdgeInsets.only(
                                          left: 20.0, right: 20),
                                      child: Center(
                                        child: commonText(
                                          text: 'Today',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        margin: const EdgeInsets.all(0),
                                        height: 35,
                                        child: Expanded(
                                          child: ToggleButtons(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            borderColor: Colors.black,
                                            fillColor: Colors.grey,
                                            borderWidth: 1,
                                            selectedBorderColor: Colors.black,
                                            selectedColor: Colors.white,
                                            onPressed: (int index) {
                                              setState(() {
                                                for (int i = 0;
                                                    i < isSelected.length;
                                                    i++) {
                                                  isSelected[i] = i == index;
                                                }
                                              });
                                            },
                                            isSelected: isSelected,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 30.0, right: 30),
                                                child: commonText(
                                                  text: 'Day',
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 30.0, right: 30),
                                                child: commonText(
                                                  text: 'Week',
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 30.0, right: 30),
                                                child: commonText(
                                                  text: 'Month',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    */ /*Container(
                                      height: 35,
                                      decoration: commonBoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Colors.black, width: 1),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      padding: const EdgeInsets.only(
                                          left: 28.0, right: 28),
                                      child: const Center(
                                        child: Icon(Icons.print),
                                      ),
                                    ),*/ /*
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      height: 35,
                                      decoration: commonBoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Colors.black, width: 1),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      padding: const EdgeInsets.only(
                                          left: 5.0, right: 5),
                                      child: Center(
                                        child: Row(
                                          children: [
                                            commonText(
                                              fontSize: 12,
                                              text: 'Settings',
                                            ),
                                            const Icon(Icons.arrow_drop_down)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : */
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /* Row(
                                children: [
                                  const Icon(
                                    Icons.arrow_back_ios,
                                    size: 15,
                                  ),
                                  commonText(
                                      left: 5,
                                      right: 5,
                                      text: formatDate(
                                          formatDate: dMMYYYY,
                                          date: DateTime.now()),
                                      fontWeight: FontWeight.w700),
                                  const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 15,
                                  )
                                ],
                              ),
                              const SizedBox(
                                width: 20,
                              ),*/
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CommonTextWidget(
                            left: 10,
                            text: "Daily appointments scheduler",
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        Row(
                          children: [
                            /* Container(
                                  height: 35,
                                  decoration: commonBoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: AppColors.colorActive, width: 1),
                                      borderRadius: BorderRadius.circular(5)),
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 20),
                                  child: Center(
                                    child: commonText(
                                      text: 'Today',
                                    ),
                                  ),
                                ),*/
                            Container(
                              margin: const EdgeInsets.all(10),
                              height: 45,
                              child: ToggleButtons(
                                borderRadius: BorderRadius.circular(8),
                                fillColor: AppColors.colorBgNew,
                                selectedColor: AppColors.colorText,
                                color: const Color.fromRGBO(250, 251, 253, 1),
                                textStyle: commonTextStyle(
                                    fontWeight: FontWeight.w600),
                                borderColor: AppColors.colorBgNew,
                                borderWidth: 1,
                                hoverColor: AppColors.colorBgNew,
                                selectedBorderColor: AppColors.colorBgNew,
                                onPressed: (int index) {
                                  if (index == 0) {
                                    setState(() {
                                      _calendarController.view =
                                          CalendarView.day;
                                    });
                                  } else if (index == 1) {
                                    setState(() {
                                      _calendarController.view =
                                          CalendarView.week;
                                    });
                                  } else if (index == 2) {
                                    setState(() {
                                      _calendarController.view =
                                          CalendarView.month;
                                    });
                                  }
                                  /*  if(index==1){
                                        _changeCalendarView(CalendarView.week);
                                      }
                                      if(index==1){
                                        _changeCalendarView(CalendarView.month);
                                      }*/
                                  setState(() {
                                    for (int i = 0;
                                        i < isSelected.length;
                                        i++) {
                                      isSelected[i] = i == index;
                                    }
                                  });
                                },
                                isSelected: isSelected,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 50.0, vertical: 5),
                                    child: commonText(
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.colorBlue,
                                      text: 'Day',
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 50.0, vertical: 5),
                                    child: commonText(
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.colorBlue,
                                      text: 'Week',
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 50.0, vertical: 5),
                                    child: commonText(
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.colorBlue,
                                      text: 'Month',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                        /* Container(
                                height: 35,
                                decoration: commonBoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.black, width: 1),
                                    borderRadius: BorderRadius.circular(5)),
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10),
                                child: const Center(
                                  child: Icon(Icons.print),
                                ),
                              ),*/
                      ],
                    ),
                    isMobile
                        ? Column(
                            children: [
                              SizedBox(
                                  child:
                                      commonSfCalendar(calendarAppointments)),
                              SizedBox(
                                height: size.height,
                                child: const Padding(
                                  padding: EdgeInsets.all(0.0),
                                  child: CalenderViewLeftScreen(),
                                ),
                              )
                            ],
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 7,
                                child: SizedBox(
                                    height: size.height * 0.7,
                                    child:
                                        commonSfCalendar(calendarAppointments)),
                              ),
                              /* Expanded(
                                  flex: 3,
                                  child: SizedBox(
                                    height: size.height,
                                    child: const Padding(
                                      padding: EdgeInsets.all(0.0),
                                      child: CalenderViewLeftScreen(),
                                    ),
                                  ))*/
                            ],
                          ),
                    const Divider(
                      thickness: 0.3,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          LegendItem(color: Colors.red, text: "Emergency"),
                          SizedBox(width: 10),
                          LegendItem(
                              color: AppColors.colorBlue, text: "Consultation"),
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
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          provider.isFetching ? showLoaderList() : const SizedBox.shrink()
        ],
      );
    });
  }

  commonSfCalendar(List<Appointment>? calendarAppointments) {
    return SfCalendar(
      controller: _calendarController,
      headerHeight: 0,
      onTap: (CalendarTapDetails details) {
        if (details.appointments != null && details.appointments!.isNotEmpty) {
          Appointment tappedAppointment = details.appointments!.first;
          String? appointmentId = tappedAppointment.id as String?;
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
      view: CalendarView.week,
      dataSource: AppointmentDataSource(calendarAppointments ?? []),
    );
  }
}

class AppointmentDataSource extends CalendarDataSource {
  AppointmentDataSource(List<Appointment> appointments) {
    this.appointments = appointments;
  }
}
