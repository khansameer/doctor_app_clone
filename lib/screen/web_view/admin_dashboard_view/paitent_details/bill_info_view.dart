import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/provider/admin_dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BillInfoView extends StatelessWidget {
  const BillInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminDashboardProvider>(
        builder: (context, provider, child) {
      return provider.billingInfo==[]?ListView.builder(
          shrinkWrap: true,
          itemCount: provider.billingInfo.length,
          itemBuilder: (context, index) {
            var data = provider.billingInfo[index];
            return Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: AppColors.colorListView,
                  borderRadius: BorderRadius.circular(8)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  commonRow(title: "Bill ID", value: '#${data['billID']}'),
                  commonRow(
                      title: "Appointment Date",
                      value: '${data['appointmentDate']}'),
                  commonRow(title: "Amount Due", value: '${data['amountDue']}'),
                  commonRow(
                      title: "Amount Paid", value: '${data['amountPaid']}'),
                  commonRow(
                      title: "Payment Status",
                      value: '${data['paymentStatus']}'),
                  commonRow(
                      title: "Billing Date", value: '${data['billingDate']}'),
                  commonRow(
                      title: "Payment Method",
                      value: '${data['paymentMethod']}'),
                ],
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

  commonRow({String? title, String? value}) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: CommonTextWidget(
              text: title ?? 'Bill ID',
              fontWeight: FontWeight.w700,
              textColor: Colors.grey,
              fontSize: 12,
            ),
          ),
          Expanded(
            flex: 8,
            child: CommonTextWidget(
              text: value,
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }
}
