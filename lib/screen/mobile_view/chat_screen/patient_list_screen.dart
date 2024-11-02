import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/route/route.dart';

import 'package:doctor_app/provider/chat_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PatientListScreen extends StatelessWidget {
  const PatientListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final patients = Provider.of<ChatProvider>(context).patients;

    return ListView.separated(
      itemCount: patients.length,
      itemBuilder: (context, index) {
        final patient = patients[index];
        return ListTile(
          dense: true,
          trailing: IconButton(
              onPressed: () {
                pushScreen(context: context, routeName: RouteName.chatScreen);
              },
              icon: const Icon(
                Icons.chat,
                color: Colors.grey,
              )),
          leading: Container(
            width: 40,
            height: 40,
            decoration: commonBoxDecoration(
                shape: BoxShape.circle, color: AppColors.colorGreen),
            child: Center(
              child: CommonTextWidget(
                text: patient.name[0],
                textColor: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          title: CommonTextWidget(
            text: patient.name,
            fontWeight: FontWeight.w600,
          ),
          subtitle: CommonTextWidget(
            text: 'Age: ${patient.age} | Condition: ${patient.condition}',
            textColor: Colors.black.withValues(alpha: 0.80),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(
          thickness: 0.3,
        );
      },
    );
  }
}
