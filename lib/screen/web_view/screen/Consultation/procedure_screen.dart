import 'package:doctor_app/provider/appointments_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../../core/component/component.dart';

class ConsultationScreen extends StatefulWidget {
  const ConsultationScreen({super.key});

  @override
  State<ConsultationScreen> createState() => _ConsultationScreenState();
}

class _ConsultationScreenState extends State<ConsultationScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);

    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        width: size.width,
        height: size.height,
        child:
            Consumer<AppointmentsProvider>(builder: (context, provider, child) {
          if (provider.todayAppointments == null) {
            return Center(child: showLoaderList()); // Loading indicator
          }

          final appointments = provider.todayAppointments;
          return ListView.separated(
            itemCount: appointments?.length ?? 0,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final data = appointments?[index];
              final dateTime = DateTime.parse(
                  data?.dateTime.toString() ?? DateTime.now().toString());

              final hour = dateTime.hour;
              final minute = dateTime.minute;
              final amPm = hour >= 12 ? 'PM' : 'AM';

              return ListTile(
                leading: commonText(
                  text: '$hour:$minute $amPm',
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                ),
                title: commonText(
                  text: data?.patientName.toString() ?? '',
                  color: Colors.black,
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    commonText(
                      text: data?.reason.toString() ?? '',
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(thickness: 0.3);
            },
          );
        }),
      ),
    );
  }
}
