import 'package:doctor_app/core/app_constants.dart';
import 'package:doctor_app/core/color_utils.dart';
import 'package:doctor_app/core/common/common_button_widget.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/image/image_path.dart';
import 'package:doctor_app/core/responsive.dart';
import 'package:doctor_app/core/route/route.dart';
import 'package:doctor_app/core/string/string_utils.dart';
import 'package:doctor_app/core/validation/validation.dart';
import 'package:doctor_app/provider/auth_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  const LoginView({required this.isMobile, super.key});
  final bool isMobile;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    var isTablet = Responsive.isTablet(context);
    var isDesktop = Responsive.isDesktop(context);
    final formLoginKey = GlobalKey<FormState>();
    return commonResponsiveLayout(
      isDesktop: isDesktop,
      boxHeight: isDesktop ? size.height * 0.7 : size.height * 0.45,
      size: size,
      isTablet: isTablet,
      isMobile: isMobile,
      child: Consumer<AuthProviders>(builder: (context, provider, child) {
        return Stack(
          children: [
            Container(
              padding: isMobile
                  ? EdgeInsets.zero
                  : const EdgeInsets.only(
                      left: twentyFive,
                      right: twentyFive,
                      bottom: zero,
                      top: zero),
              width: size.width,
              height: size.height,
              child: Form(
                key: formLoginKey,
                child: Padding(
                  padding: const EdgeInsets.all(zero),
                  child: ListView(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: isMobile ? size.height * 0.05 : 0,
                          ),
                          setAssetImage(
                              image: icLoginLogo,
                              width: 200,
                              height: 140,
                              fit: BoxFit.scaleDown),
                          Align(
                              heightFactor: 0.1,
                              alignment: Alignment.center,
                              child: CommonTextWidget(
                                text: login,
                                textStyle: GoogleFonts.inter(
                                  fontWeight: FontWeight.w700,
                                  color: colorGreen,
                                  fontSize: twentyFive,
                                ),
                              )),
                          commonTextFiledView(
                            topText: fifteen,
                            title: yourEmail,
                            keyboardType: TextInputType.emailAddress,
                            controller: provider.tetEmail,
                            validator: (value) {
                              if (value.toString().trim().isEmpty) {
                                return emptyEmail;
                              }
                              if (!Validation.validateEmail(value.toString())) {
                                return emailValidationMsg;
                              }
                              return null;
                            },
                            topTextField: ten,
                          ),
                          commonTextFiledView(
                              keyboardType: TextInputType.visiblePassword,
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
                            padding: isMobile ? null : const EdgeInsets.all(20),
                            onPressed: () {
                              final isValid =
                                  formLoginKey.currentState?.validate() ??
                                      false;
                              if (isValid) {
                                Map<String, dynamic> body = {
                                  "email": provider.tetEmail.text,
                                  "password": provider.tetPassword.text,
                                  "role": "doctor",
                                };

                                provider
                                    .callLoginApi(
                                        context: context,
                                        body: body,
                                        isLogin: true)
                                    .then((value) {
                                  if (provider.loginModel?.token != null) {
                                    pushNamedAndRemoveUntil(
                                        context: context,
                                        routeName: RouteName.dashboardScreen);

                                    formLoginKey.currentState?.save();
                                    provider.resetFields();
                                  }
                                });
                              }
                            },
                            text: continueBtn,
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: isMobile ? size.height * zero003 : 20,
                                left: isMobile ? size.width * zero01 : 10,
                                right: isMobile ? size.width * zero01 : 10),
                            child: Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: commonDivider(),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: eight),
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
                          SizedBox(
                            height: isMobile ? 10 : 20,
                          ),
                          RichText(
                            text: TextSpan(
                              text: 'Don’t have an account? ',
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        pushScreen(
                                            context: context,
                                            routeName: RouteName.signUPScreen);
                                      },
                                    text: 'Sign Up',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    )),
                              ],
                            ),
                          ),
                          /*CommonButtonWidget(
                            top: size.height * zero003,
                            borderWidth: one,
                            padding: isMobile?null:EdgeInsets.all(20),
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
                            padding: isMobile?null:EdgeInsets.all(20),
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
                          ),*/
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            provider.isFetching ? showLoaderList() : const SizedBox.shrink()
          ],
        );
      }),
    );
  }
}
