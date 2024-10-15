import 'package:doctor_app/core/color_utils.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/image/image_path.dart';
import 'package:doctor_app/provider/dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderView extends StatelessWidget {
  const CalenderView({super.key,required this.provider});
 final  DashboardProvider provider;

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      calendarBuilders: CalendarBuilders(
        markerBuilder: (context, date, events) {
          if (events.isNotEmpty) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 0),
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue, // Customize the color of the dot here
              ),
            );
          }
          return null; // No dot if there are no events
        },
        selectedBuilder: (context, date, events) => Container(
            margin: const EdgeInsets.all(4.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(10.0)),
            child: CommonTextWidget(
              text: date.day.toString(),
              textColor: Colors.white,
            )),
        todayBuilder: (context, date, events) => Container(
            margin: const EdgeInsets.all(4.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: colorGreen,
                borderRadius: BorderRadius.circular(10.0)),
            child: CommonTextWidget(
              text: date.day.toString(),
              textColor: Colors.white,
            )),
      ),
      calendarStyle: CalendarStyle(
        selectedTextStyle: const TextStyle(
          color: Colors.white, // Text color for selected date
        ),

        defaultTextStyle: commonTextStyle(color: Colors.black),
        weekNumberTextStyle: commonTextStyle(color: Colors.black),
        weekendTextStyle: commonTextStyle(color: Colors.black),
      ),
      calendarFormat: CalendarFormat.week,
      headerStyle: HeaderStyle(

        titleCentered: true,
        rightChevronVisible: false,
        leftChevronVisible: false,
        formatButtonVisible: false,
        titleTextStyle: commonTextStyle(
            color: Colors.amber,
            fontSize: 16,
            fontWeight: FontWeight.w700),
        formatButtonShowsNext: false,
      ),
      focusedDay: provider.focusedDay,
      firstDay: DateTime.utc(DateTime.now().year,
          DateTime.now().month, DateTime.now().day),
      lastDay: DateTime.utc(2028, 12, 31),
      selectedDayPredicate: (day) =>
          isSameDay(provider.selectedDay, day),
      onDaySelected: (selectedDay, focusedDay) {
        provider.setSelectedDay(selectedDay, focusedDay);
      },
      eventLoader: provider.getEventsForDay,
    );
  }
}
class  MeetingView extends StatelessWidget {
  const  MeetingView({super.key,required this.provider});
  final DashboardProvider provider;

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.sizeOf(context);
    List<String> events = provider
        .getEventsForDay(provider.selectedDay);
    return   Expanded(
      child: events.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            setAssetImage(
                fit: BoxFit.scaleDown,
                image: icNoAppointment,width: size.width*0.5),
            CommonTextWidget(text: "No Appointment",fontWeight: FontWeight.w800,)
          ],
        ),
      )
          : ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: commonBoxDecoration(
          borderRadius: BorderRadius.circular(10),
              border: Border.all(color: colorGreen.withOpacity(0.20),width: 1)
            ),
            margin: const EdgeInsets.all(10),

            child: ListTile(
              leading: Container(
                width: 35,
                height: 35,
                decoration:commonBoxDecoration(
                  color: colorGreen,
                  shape: BoxShape.circle
                ),
                child: Center(child: CommonTextWidget(text: "P",textColor: Colors.white,fontWeight: FontWeight.w700,),),
              ),
              subtitle:Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonTextWidget(text:"9865658525",fontSize: 11,textColor: Colors.grey,top: 5,),
                  CommonTextWidget(text:"Appointment Date & Time",fontSize: 11,textColor: Colors.grey,fontWeight: FontWeight.w500,top: 8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CommonTextWidget(text:"10 October 2024",fontSize: 11,textColor: Colors.black,fontWeight: FontWeight.w700,top: 5,),
                      CommonTextWidget(text:"12:32 PM",fontSize: 11,textColor: Colors.black,fontWeight: FontWeight.w500,top: 5,),
                    ],
                  ),
                ],
              ) ,
              title: CommonTextWidget(text:events[index],fontSize: 13,textColor: Colors.black,fontWeight: FontWeight.w700,),
            ),
          );
        },
      ),
    );
  }
}


