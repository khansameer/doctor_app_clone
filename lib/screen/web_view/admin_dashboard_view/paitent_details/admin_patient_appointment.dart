import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/provider/admin_dashboard_provider.dart';
import 'package:doctor_app/provider/model/CommonPaitentDetailsModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AdminPatientAppointment extends StatelessWidget {
   const AdminPatientAppointment({super.key,required this.appointment});
  final List<Appointment> appointment;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: appointment.length,
        itemBuilder: (context, index) {
          var data = appointment[index];
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: AppColors.colorListView,
                borderRadius: BorderRadius.circular(8)),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Center(
                    child: CommonTextWidget(
                      text: '#${data.id}',
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              title: CommonTextWidget(
                text: data.doctorName,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  CommonTextWidget(
                    text: data.description,
                    top: 0,
                    fontSize: 12,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CommonTextWidget(
                    text: DateFormat('yyyy-MM-dd hh:mm a').format(data.dateTime),
                    top: 0,
                    fontSize: 12,
                  ),
                ],
              ),
              trailing: CommonTextWidget(
                text: data.status,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              /*  textColor: data['status'] == "Completed"
                    ? Colors.green
                    : Colors.black,*/
              ),
            ),
          );
        });
  }
}
