import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeUtils {
 static String yyyyMMdd="yyyy-MM-dd";
 static String hhmmss="hh:mm";
 static String hhmmssa="hh:mm a";
  // A static method to format the date
  static String formatDate(String dateStr, {String format = 'yyyy-MM-dd HH:mm'}) {
    try {
      // Parse the string into a DateTime object
      DateTime dateTime = DateTime.parse(dateStr);
      // Format the DateTime object based on the provided or default format
      return DateFormat(format).format(dateTime);
    } catch (e) {
      // In case of an invalid date string, return a fallback or error message
      return 'Invalid date';
    }
  }

 static int calculateAge({required String date}) {
   DateTime birthDate = DateTime.parse(date);
   DateTime currentDate = DateTime.now();

   int age = currentDate.year - birthDate.year;

   // Adjust age if the birthday hasn't occurred yet this year
   if (currentDate.month < birthDate.month ||
       (currentDate.month == birthDate.month && currentDate.day < birthDate.day)) {
     age--;
   }

   return age;
 }
 static  DateTime selected = DateTime.now();
 static DateTime initial =  DateTime.now();
 static DateTime last = DateTime(3000);
 static Future  displayDatePicker(
      {required BuildContext context, required Function getDate,
        required TextEditingController tetDate,
      }) async {
   DateTime initialDate;

   if (tetDate.text.isNotEmpty) {
     // Parse tetDate.text assuming format "yyyy-MM-dd"
     initialDate = DateTime.parse(tetDate.text);

     // Ensure initialDate is not before firstDate
     if (initialDate.isBefore(initial)) {
       initialDate = initial;
     }
   } else {
     initialDate = selected; // Default to currently selected date

     // Ensure initialDate is not before firstDate
     if (initialDate.isBefore(initial)) {
       initialDate = initial;
     }
   }

   var date = await showDatePicker(
     context: context,
     initialDate: initialDate,
     firstDate: initial,
     lastDate: last,
   );

   if (date != null) {
     getDate(date.toLocal().toString().split(" ")[0]);
   }
 }
 //static TimeOfDay timeOfDay = TimeOfDay.now();
 static Future displayTimePicker(
      {required BuildContext context, required Function getTime,required TextEditingController tetTime,}) async {
  /* var time = await showTimePicker(
       context: context,
       initialTime: timeOfDay);*/
   TimeOfDay initialTime;

   if (tetTime.text.isNotEmpty) {
     // Assuming tetTime.text is in format "10:00 AM" or "10:00 PM"
     final timeParts = tetTime.text.split(' ');
     final hourMinute = timeParts[0].split(':');
     int hour = int.parse(hourMinute[0]);
     int minute = int.parse(hourMinute[1]);

     // Adjust hour based on AM/PM
     if (timeParts[1] == 'PM' && hour < 12) {
       hour += 12;
     } else if (timeParts[1] == 'AM' && hour == 12) {
       hour = 0;
     }

     initialTime = TimeOfDay(hour: hour, minute: minute);
   } else {
     initialTime = TimeOfDay.now();
   }

   var time = await showTimePicker(
     context: context,
     initialTime: initialTime,
   );
   if (time != null) {
     print('Selected Time: ${time}');

     final int hour = time.hour > 12 ? time.hour - 12 : (time.hour == 0 ? 12 : time.hour);
     final String period = time.hour >= 12 ? 'PM' : 'AM';
     final String minute = time.minute.toString().padLeft(2, '0');

     // Update the controller with formatted time
     getTime("$hour:$minute $period");
   }
/*   if (time != null) {
     print('=======${time}');

     final int hour = time.hour > 12 ? time.hour - 12 : (time.hour == 0 ? 12 : time.hour);

     final String period = time.hour >= 12 ? 'PM' : 'AM';
     final String minute = time.minute.toString().padLeft(2, '0');
      getTime("$hour:$minute $period");
     *//*setState(() {
       _timeC.text = "${time.hour}:${time.minute}";
     });*//*
   }*/
 }
}
