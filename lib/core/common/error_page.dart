
import 'package:doctor_app/core/image/image_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app_constants.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.sizeOf(context);
    return  SizedBox(
      width: size.width,
      height: size.height*zero5,
      child: Image.asset(
        width: twoHundred,
          height: twoHundred,
          fit: BoxFit.scaleDown,
          icPageError),
    );
  }
}
