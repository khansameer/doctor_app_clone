import 'package:doctor_app/core/image/image_path.dart';
import 'package:flutter/material.dart';

import '../app_constants.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      width: size.width,
      padding: const EdgeInsets.all(16),
      height: size.height,
      child: Image.asset(
          width: twoHundred,
          height: twoHundred,
          fit: BoxFit.scaleDown,
          icPageError),
    );
  }
}
