import 'package:doctor_app/core/app_constants.dart';
import 'package:doctor_app/core/common/common_button_widget.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/common/app_scaffold.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/string/string_utils.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class ForgotPasswordResetView extends StatelessWidget {
  const ForgotPasswordResetView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return AppScaffold(

      appBar: commonAppBar(title: forgotPasswordText),
      child: ListView(
        children: [
          CommonTextWidget(
            top: size.height * zero002,
            textColor: Colors.black,
            fontSize: sixteen,
            fontWeight: FontWeight.w700,
            text: setNewPassword,
          ),
          CommonTextWidget(
            lineHeight: 1.5,
            top: size.height * zero002,
            textColor: Colors.black,
            text: passwordTitleDesc,
          ),
          commonTextFiledView(
              //obscureText: !provider.isPasswordVisible,
              title: password,
          /*    suffixIcon: IconButton(
                onPressed: provider.togglePasswordVisibility,
                icon: Icon(
                  color: Colors.grey,
                  provider.isPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
              ),*/
              topText: size.height * zero005,
              hint: enterNewPassword,
              topTextField: ten),
          commonTextFiledView(
              hint: reEnterPassword,
         //     obscureText: !provider.isConfirmPasswordVisible,
              title: confirmPassword,
           /*   suffixIcon: IconButton(
                onPressed: provider.togglePasswordVisibility,
                icon: Icon(
                  color: Colors.grey,
                  provider.isConfirmPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
              ),*/
              topText: fifteen,
              topTextField: ten),
          CommonButtonWidget(
            onPressed: () {
              showCommonDialog(
                  btnNegative: cancel,
                  context: context,
                  title: passwordReset,
                  content: passwordResetMsg,
                  onPressPositive: () {
                   /* pushNamedAndRemoveUntil(
                        context: context, routeName: RouteName.loginScreen);*/
                  });
            },
            top: size.height * zero004,
            text: updatePassword,
          ),
        ],
      ),
    );
  }
}
