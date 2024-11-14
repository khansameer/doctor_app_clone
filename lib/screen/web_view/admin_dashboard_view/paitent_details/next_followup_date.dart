import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/provider/admin_dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NextFollowupDate extends StatelessWidget {
  const NextFollowupDate({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminDashboardProvider>(
        builder: (context, provider, child) {
      return provider.followUpDetails==[]?ListView.builder(
          shrinkWrap: true,
          itemCount: provider.followUpDetails.length,
          itemBuilder: (context, index) {
            var data = provider.followUpDetails[index];
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
                        text: '#${data['patientID']}',
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                title: CommonTextWidget(
                  text: data['doctorName'],
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                subtitle: CommonTextWidget(
                  text: data['reason'],
                  top: 0,
                  fontSize: 12,
                ),
                trailing: CommonTextWidget(
                  text: data['nextFollowUpDate'],
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            );
          }):Center(
        child: CommonTextWidget(
          text: "No Data Found",
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      );
    });
  }
}
