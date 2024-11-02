import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/provider/admin_dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DemographicsView extends StatelessWidget {
  const DemographicsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminDashboardProvider>(
        builder: (context, provider, child) {
      return ListView.builder(
          shrinkWrap: true,
          itemCount: provider.demographicsDetails.length,
          itemBuilder: (context, index) {
            var data = provider.demographicsDetails[index];
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: AppColors.colorListView,
                  borderRadius: BorderRadius.circular(8)),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
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
                  ) /*CachedNetworkImage(
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  imageUrl: provider.patients[index].photo.toString(),
                )*/ /*commonImageNetworkWidget(path: provider.patients[index].photo)*/,
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CommonTextWidget(
                          text: 'Marital Status: ',
                          top: 0,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                        CommonTextWidget(
                          text: '${data['maritalStatus']}',
                          top: 0,
                          fontSize: 12,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CommonTextWidget(
                          text: 'Ethnicity: ',
                          top: 0,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                        CommonTextWidget(
                          text: '${data['ethnicity']}',
                          top: 0,
                          fontSize: 12,
                        ),
                      ],
                    ),
                  ],
                ),
                title: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CommonTextWidget(
                      text: data['name'],
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    CommonTextWidget(
                      text: ' -${data['age']}- ',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    CommonTextWidget(
                      text: '${data['gender']}',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ],
                ),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CommonTextWidget(
                          text: 'Address: ',
                          top: 0,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                        CommonTextWidget(
                          text: '${data['address']}',
                          top: 0,
                          fontSize: 12,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CommonTextWidget(
                          text: 'Mobile No: ',
                          top: 0,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                        CommonTextWidget(
                          text: '${data['contactNumber']}',
                          top: 0,
                          fontSize: 12,
                        ),
                      ],
                    ),
                  ],
                ),
                //  trailing: CommonTextWidget(text: data['date'],fontWeight: FontWeight.w600,fontSize: 14,),
              ),
            );
          });
    });
  }
}
