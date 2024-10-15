import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:flutter/material.dart';

class ChartingView extends StatelessWidget {
  const ChartingView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (ctx, index) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              color: Colors.grey.withOpacity(0.40),
              width: 0.5,
            ),
          ),
        ),
        child: ListTile(
          title: CommonTextWidget(
            text: 'Appointment',
            fontWeight: FontWeight.w400,
            fontSize: 13,
            textColor: Colors.grey,
            marginBottom: 8,
          ),
          subtitle: Row(
            children: [
              const Icon(
                Icons.circle_rounded,
                color: Colors.green,
                size: 12,
              ),
              CommonTextWidget(
                text: 'Dr Bhavesh Gohil, 07:00 PM - 07:15 PM',
                left: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
