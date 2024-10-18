import 'package:doctor_app/core/common/app_scaffold.dart';
import 'package:doctor_app/core/responsive.dart';
import 'package:doctor_app/screen/authentication/login/view/login_view.dart';
import 'package:flutter/material.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    var isMobile = Responsive.isMobile(context);
    return AppScaffold(
      left: isMobile?null:0,
      right: isMobile?null:0,

      child: Container(
        alignment: Alignment.center,
        width: size.width,
        height: size.height,

        child: LoginView(isMobile: isMobile,),
      ),
    );
  }
}
