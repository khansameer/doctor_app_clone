import 'package:doctor_app/core/common/app_scaffold.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:flutter/material.dart';

class AddClinicScreen extends StatelessWidget {
  const AddClinicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(title: 'EDIT PROFILE'),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              width: 100,
              height: 100,
              color: Colors.green,
            )
          ],
        ),
      ),
    );
  }
}
