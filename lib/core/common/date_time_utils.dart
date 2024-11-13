import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeUtils {
 static String yyyyMMdd="yyyy-MM-dd";
 static String hhmmss="hh:mm";
 //static String hhmmssa="hh:mma";
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
      {required BuildContext context, required Function getDate}) async {
   var date = await showDatePicker(
     context: context,
     initialDate: selected,
     firstDate: initial,
     lastDate: last,
   );

   if (date != null) {
     getDate(date.toLocal().toString().split(" ")[0]);
     /*setState(() {
       _dateC.text = date.toLocal().toString().split(" ")[0];
     });*/
   }
 }
 static TimeOfDay timeOfDay = TimeOfDay.now();
 static Future displayTimePicker(
      {required BuildContext context, required Function getTime}) async {
   var time = await showTimePicker(
       context: context,
       initialTime: timeOfDay);

   if (time != null) {
     print('=======${time}');

     final int hour = time.hour > 12 ? time.hour - 12 : (time.hour == 0 ? 12 : time.hour);

     final String period = time.hour >= 12 ? 'PM' : 'AM';
     final String minute = time.minute.toString().padLeft(2, '0');
      getTime("$hour:$minute $period");
     /*setState(() {
       _timeC.text = "${time.hour}:${time.minute}";
     });*/
   }
 }
}
