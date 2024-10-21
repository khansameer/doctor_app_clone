
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/responsive.dart';
import 'package:doctor_app/core/string/string_utils.dart';
import 'package:doctor_app/provider/calender_provider.dart';
import 'package:doctor_app/screen/new_dashboard/calender_view_left_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';


class CalenderNewScreen extends StatefulWidget {
  const CalenderNewScreen({super.key});

  @override
  State<CalenderNewScreen> createState() => _CalenderNewScreenState();
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}

class _CalenderNewScreenState extends State<CalenderNewScreen> {
  List<bool> isSelected = [false, false, false];
  String? response;

  @override
  void initState() {
    isSelected = [false, true, false];
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CalenderProvider>().getAppointments().then((value) {
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    var isMobile=Responsive.isMobile(context);
    return Consumer<CalenderProvider>(builder: (context, provider, child) {
      List<Appointment>? calendarAppointments =
          provider.appointmentsModel?.appointments.map((appointment) {
        DateTime dateTime =
            DateTime.parse(appointment.dateTime ?? DateTime.now().toString());
        return Appointment(
          startTime: dateTime,
          endTime: dateTime.add(Duration(hours: 1)),
          // Assuming 1 hour duration
          subject: appointment.reason.toString(),
          color: Colors.blue, // Set a color for the appointment
        );
      }).toList();
      return Stack(
        children: [
          ListView(
            shrinkWrap: true,
            children: [
              Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    isMobile?Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      text: formatDate(formatDate: dMMYYYY, date:  DateTime.now()),
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
                                    border: Border.all(color: Colors.black, width: 1),
                                    borderRadius: BorderRadius.circular(5)),
                                padding: const EdgeInsets.only(left: 20.0, right: 20),
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
                                  child: ToggleButtons(
                                    borderRadius: BorderRadius.circular(5),
                                    borderColor: Colors.black,
                                    fillColor: Colors.grey,
                                    borderWidth: 1,
                                    selectedBorderColor: Colors.black,
                                    selectedColor: Colors.white,
                                    onPressed: (int index) {
                                      setState(() {
                                        for (int i = 0; i < isSelected.length; i++) {
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
                              Container(
                                height: 35,
                                decoration: commonBoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.black, width: 1),
                                    borderRadius: BorderRadius.circular(5)),
                                padding: const EdgeInsets.only(left: 28.0, right: 28),
                                child: const Center(
                                  child: Icon(Icons.print),
                                ),
                              ),
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
                                    border: Border.all(color: Colors.black, width: 1),
                                    borderRadius: BorderRadius.circular(5)),
                                padding: const EdgeInsets.only(left: 5.0, right: 5),
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
                    ): Row(
                      mainAxisAlignment: MainAxisAlignment.end,
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
                                text: formatDate(formatDate: dMMYYYY, date:  DateTime.now()),
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
                              border: Border.all(color: Colors.black, width: 1),
                              borderRadius: BorderRadius.circular(5)),
                          padding: const EdgeInsets.only(left: 20.0, right: 20),
                          child: Center(
                            child: commonText(
                              text: 'Today',
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(10),
                          height: 35,
                          child: ToggleButtons(
                            borderRadius: BorderRadius.circular(5),
                            borderColor: Colors.black,
                            fillColor: Colors.grey,
                            borderWidth: 1,
                            selectedBorderColor: Colors.black,
                            selectedColor: Colors.white,
                            onPressed: (int index) {
                              setState(() {
                                for (int i = 0; i < isSelected.length; i++) {
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
                        Container(
                          height: 35,
                          decoration: commonBoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black, width: 1),
                              borderRadius: BorderRadius.circular(5)),
                          padding: const EdgeInsets.only(left: 10.0, right: 10),
                          child: const Center(
                            child: Icon(Icons.print),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 35,
                          decoration: commonBoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black, width: 1),
                              borderRadius: BorderRadius.circular(5)),
                          padding: const EdgeInsets.only(left: 10.0, right: 10),
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
                        const SizedBox(
                          width: 10,
                        )
                      ],
                    ),
                    isMobile?Column(
                      children: [
                        SizedBox(
                          
                            child: SfCalendar(
                              headerHeight: 0,
                              backgroundColor: Colors.white,
                              headerStyle: CalendarHeaderStyle(
                                  backgroundColor: Colors.white),
                              view: CalendarView.week,
                              dataSource: AppointmentDataSource(
                                  calendarAppointments ?? []),
                            )),
                        SizedBox(
                          height: size.height,
                          child: const Padding(
                            padding: EdgeInsets.all(0.0),
                            child: CalenderViewLeftScreen(),
                          ),
                        )
                      ],
                    ) :Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 7,
                          child: SizedBox(
                              height: size.height,
                              child: SfCalendar(
                                headerHeight: 0,
                                backgroundColor: Colors.white,
                                headerStyle: CalendarHeaderStyle(
                                    backgroundColor: Colors.white),
                                view: CalendarView.week,
                                dataSource: AppointmentDataSource(
                                    calendarAppointments ?? []),
                              )),
                        ),
                        Expanded(
                            flex: 3,
                            child: SizedBox(
                              height: size.height,
                              child: const Padding(
                                padding: EdgeInsets.all(0.0),
                                child: CalenderViewLeftScreen(),
                              ),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          provider.isFetching ? showLoaderList() : SizedBox.shrink()
        ],
      );
    });
  }
}

class AppointmentDataSource extends CalendarDataSource {
  AppointmentDataSource(List<Appointment> appointments) {
    this.appointments = appointments;
  }
}
