import 'package:doctor_app/core/common/app_scaffold.dart';
import 'package:doctor_app/screen/authentication/login/view/login_view.dart';
import 'package:flutter/material.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return AppScaffold(

      child: Container(
        alignment: Alignment.center,
        width: size.width,
        height: size.height,
        color: Colors.white,
        child:const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LoginView(),
          ],
        ),
      ),
    );
  }
}
