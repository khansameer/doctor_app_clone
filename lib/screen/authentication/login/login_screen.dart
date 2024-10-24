import 'package:doctor_app/core/responsive.dart';
import 'package:doctor_app/screen/authentication/login/view/login_view.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    var isMobile = Responsive.isMobile(context);
    return Scaffold(
      backgroundColor: Colors.white,

      body: SizedBox(
        width: size.width,
        height: size.height,
        child: LoginView(
          isMobile: isMobile,
        ),
      ),
    );
  }
}
