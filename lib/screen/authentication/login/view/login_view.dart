import 'package:doctor_app/core/color_utils.dart';
import 'package:doctor_app/core/common/common_button_widget.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../../core/app_constants.dart';
import '../../../../core/component/component.dart';
import '../../../../core/string/string_utils.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    final formLoginKey = GlobalKey<FormState>();
    return Form(
      key: formLoginKey,
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Stack(
          children: [
            ListView(
              children: [
                commonTextFiledView(

                    title: yourEmail,
                    validator: (value) {
                      if (value.toString().trim().isEmpty) {
                        return emptyEmail;
                      }
                      /*if (!Validation.validateEmail(value.toString())) {
                        return emailValidationMsg;
                      }*/
                      return null;
                    },
                    topText: size.height * zero01,
                    topTextField: ten),
                commonTextFiledView(
                    validator: (value) {
                      if (value.toString().trim().isEmpty) {
                        return emptyPassword;
                      }

                      return null;
                    },
                    title: password,
                 /*   suffixIcon: IconButton(
                      onPressed: provider.togglePasswordVisibility,
                      icon: Icon(
                        color: Colors.grey,
                        provider.isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),*/
                    topText: fifteen,
                    topTextField: ten),
                Align(
                  alignment: Alignment.topRight,
                  child: commonInkWell(
                    onTap: () {
                    /*  pushScreen(
                          context: context,
                          routeName: RouteName.forgotPasswordScreen);*/
                    },
                    child: CommonTextWidget(
                      top: ten,
                      fontWeight: FontWeight.w600,
                      textColor: colorBlueLight,
                      text: forgotPassword,
                    ),
                  ),
                ),
                CommonButtonWidget(
                  top: twenty,
                  onPressed: () {
                   // provider.login(context);
                  },
                  text: continueBtn,
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: size.height * zero003,
                      left: size.width * zero01,
                      right: size.width * zero01),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: commonDivider(),
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: eight),
                          child: CommonTextWidget(
                            text: or,
                            left: ten,
                            right: ten,
                            textColor: Colors.grey,
                          ),
                        ),
                        Expanded(
                          child: commonDivider(),
                        ),
                      ],
                    ),
                  ),
                ),
             /*   CommonButtonWidget(
                  top: size.height * zero003,
                  borderWidth: one,
                  onPressed: () {},
                  colorButton: Colors.white,
                  colorBorder: colorGray,
                  text: loginWithApple,
                  colorText: Colors.black,
                  iconShow: true,
                  textLeft: ten,
                  icon: setAssetImage(
                      image: icApple,
                      fit: BoxFit.scaleDown,
                      width: twentyFour,
                      height: twentyFour),
                ),*/
               /* CommonButtonWidget(
                  top: size.height * zero002,
                  borderWidth: one,
                  onPressed: () {},
                  colorButton: Colors.white,
                  colorBorder: colorGray,
                  text: loginWithGoogle,
                  colorText: Colors.black,
                  iconShow: true,
                  textLeft: ten,
                  icon: setAssetImage(
                      image: icGoogle,
                      fit: BoxFit.scaleDown,
                      width: twentyFour,
                      height: twentyFour),
                )*/
              ],
            ),
          ],
        ),
      ),
    );
  }
}
