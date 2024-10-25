import 'package:doctor_app/core/common/CustomAlertDialog.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/provider/calender_provider.dart';
import 'package:doctor_app/screen/web_view/screen/calender/add_appointments_widget.dart';
import 'package:doctor_app/screen/web_view/screen/calender/get_edit_appointments_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalenderView extends StatefulWidget {
  const CalenderView({super.key});

  @override
  State<CalenderView> createState() => _CalenderViewState();
}

class _CalenderViewState extends State<CalenderView> {
  final CalendarController _calendarController = CalendarController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CalenderProvider>().getAppointments().then((value) {
        setState(() {});
      });
    });
    _calendarController.view =
        CalendarView.workWeek; // Set the initial view as required
  }

  @override
  Widget build(BuildContext context) {
    var provider = context.read<CalenderProvider>();
    var providerWatch = context.watch<CalenderProvider>();
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
        return Appointment(startTime: DateTime.now(), endTime: DateTime.now());
      }
    }).toList();
    var size = MediaQuery.sizeOf(context);
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: SizedBox(child: commonSfCalendar(calendarAppointments)),
        ),
        providerWatch.isFetching ? showLoaderList() : const SizedBox.shrink()
      ],
    );
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  commonSfCalendar(List<Appointment>? calendarAppointments) {
    return SfCalendar(
      controller: _calendarController,
      headerHeight: 0,

      onTap: (CalendarTapDetails details) {

        if (details.targetElement == CalendarElement.appointment) {
          Appointment tappedAppointment = details.appointments!.first;
          String? appointmentId = tappedAppointment.id as String?;
          print('Appointment ID: $appointmentId');
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
        } else if (details.targetElement == CalendarElement.calendarCell &&
            details.date != null) {
          _calendarController.displayDate = details.date;
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return CustomAlertDialog(
                content: AddAppointmentsWidget(
                  dateTime: details.date!,
                ),
              );
            },
          );
        } else {}
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
