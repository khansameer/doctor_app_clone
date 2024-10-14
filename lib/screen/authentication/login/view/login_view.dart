import 'package:doctor_app/core/app_constants.dart';
import 'package:doctor_app/core/color_utils.dart';
import 'package:doctor_app/core/common/common_button_widget.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/image/image_path.dart';
import 'package:doctor_app/core/route/route.dart';
import 'package:doctor_app/core/string/string_utils.dart';
import 'package:doctor_app/core/validation/validation.dart';
import 'package:doctor_app/provider/auth_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    final formLoginKey = GlobalKey<FormState>();
    return Consumer<AuthProviders>(builder: (context, provider, child) {
      return SizedBox(

        width: size.width,
        height: size.height,
        child: Form(
          key: formLoginKey,
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: ListView(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: size.height*0.05,),
                    Align(
                        alignment: Alignment.center,
                        child: CommonTextWidget(
                          text: "Welcome Back",
                          fontWeight: FontWeight.w700,
                          textColor: Colors.black,
                          fontSize: 16,
                        )),
                    Align(
                        alignment: Alignment.center,
                        child: CommonTextWidget(
                          text: "Login",
                          textStyle: GoogleFonts.agbalumo(
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            fontSize: 25,
                          ),

                          top: 15,

                        )),
                    const SizedBox(height: 20,),
                    setAssetImage(image: icLoginLogo,width: 200,height: 160,  fit:BoxFit.scaleDown),

                    commonTextFiledView(
                        title: yourEmail,
                        validator: (value) {
                          if (value.toString().trim().isEmpty) {
                            return emptyEmail;
                          }
                          if (!Validation.validateEmail(value.toString())) {
                            return emailValidationMsg;
                          }
                          return null;
                        },
                        topTextField: ten),
                    commonTextFiledView(
                        controller: provider.tetPassword,
                        obscureText: !provider.isPasswordVisible,
                        validator: (value) {
                          if (value.toString().trim().isEmpty) {
                            return emptyPassword;
                          }

                          return null;
                        },
                        title: password,
                        suffixIcon: IconButton(
                          onPressed: provider.togglePasswordVisibility,
                          icon: Icon(
                            color: Colors.grey,
                            provider.isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                        topText: fifteen,
                        topTextField: ten),
                    Align(
                      alignment: Alignment.topRight,
                      child: commonInkWell(
                        onTap: () {
                          pushScreen(
                              context: context,
                              routeName: RouteName.forgotPasswordScreen);
                        },
                        child: CommonTextWidget(
                          top: ten,
                          fontWeight: FontWeight.w600,
                          textColor: colorGreen,
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
                    RichText(
                      text: TextSpan(
                        text: 'Don’t have an account? ',
                        style: DefaultTextStyle.of(context).style,
                        children:  <TextSpan>[
                          TextSpan(
                              recognizer: TapGestureRecognizer()..onTap  = () {
                                pushScreen(
                                    context: context,
                                    routeName: RouteName.signUPScreen);
                              },
                              text: 'Sign Up', style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    CommonButtonWidget(
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
                      ),
                    CommonButtonWidget(
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
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
