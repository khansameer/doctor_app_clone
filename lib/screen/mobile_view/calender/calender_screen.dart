import 'package:doctor_app/core/common/app_scaffold.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:flutter/material.dart';

import 'calender_view.dart';

class CalenderScreen extends StatelessWidget {
  const CalenderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return AppScaffold(
      left: 0,
      right: 0,
      appBar: commonAppBar(
        title: "Calender".toUpperCase(),
      ),
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: const CalenderView(),
      ),
    );
  }
}
