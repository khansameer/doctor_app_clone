import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:flutter/material.dart';

class PatientProfileView extends StatelessWidget {
  const PatientProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 1,
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
          contentPadding: const EdgeInsets.only(left: 20, right: 10),
          title: CommonTextWidget(
            text: 'Primary Mobile',
            textColor: Colors.grey.withOpacity(0.8),
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
          subtitle: CommonTextWidget(
            text: '+1-555-852-5574',
            fontWeight: FontWeight.w400,
            fontSize: 13,
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min, // To fit content
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.chat_outlined,
                  color: Colors.grey,
                  size: 20,
                ),
                onPressed: () {
                  // Edit action
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.phone_outlined,
                  color: Colors.grey,
                  size: 20,
                ),
                onPressed: () {
                  // Delete action
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
