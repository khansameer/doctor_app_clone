
import 'package:doctor_app/core/color_utils.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/image/image_path.dart';
import 'package:doctor_app/provider/auth_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthProviders>().redirectToLogin(context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.white,
        body: Container(
          width: size.width,
          height: size.height,

          decoration: commonBoxDecoration(
            image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(icLogo))
          ),
          child: Container(
            width: size.width,
            height: size.height,
            color: Colors.white.withOpacity(0.40),
            child: Center(child:CommonTextWidget(text: "Doctor App",fontWeight: FontWeight.w700,
fontSize: 30,
            textColor: colorGreen,
            ),),
          ),
        ));
  }
}
