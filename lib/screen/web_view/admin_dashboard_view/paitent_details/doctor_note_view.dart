import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/provider/admin_dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DoctorNoteView extends StatelessWidget {
  const DoctorNoteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminDashboardProvider>(
        builder: (context, provider, child) {
      return ListView.builder(
          shrinkWrap: true,
          itemCount: provider.patientDoctorNotes.length,
          itemBuilder: (context, index) {
            var data = provider.patientDoctorNotes[index];
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
                        text: '#${data['noteID']}',
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                  ) /*CachedNetworkImage(
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  imageUrl: provider.patients[index].photo.toString(),
                )*/ /*commonImageNetworkWidget(path: provider.patients[index].photo)*/,
                ),
                title: CommonTextWidget(
                  text: data['doctorName'],
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                subtitle: CommonTextWidget(
                  text: data['note'],
                  top: 5,
                  fontSize: 12,
                ),
                trailing: CommonTextWidget(
                  text: data['date'],
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            );
          });
    });
  }
}
