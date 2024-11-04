import 'package:doctor_app/core/app_constants.dart';

import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/common_button_widget.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/image/image_path.dart';
import 'package:doctor_app/core/responsive.dart';
import 'package:doctor_app/core/route/route.dart';
import 'package:doctor_app/core/string/string_utils.dart';
import 'package:doctor_app/core/validation/validation.dart';
import 'package:doctor_app/provider/auth_provider.dart';
import 'package:flutter/foundation.dart';
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
    var isMobile = Responsive.isMobile(context);
    final formLoginKey = GlobalKey<FormState>();

    return isMobile
        ? Center(
            child: ListView(
              shrinkWrap: true,
              children: [
                Form(
                  key: formLoginKey,
                  child: MobileView(
                    formLoginKey: formLoginKey,
                  ),
                )
              ],
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                flex: 5,
                child: Form(
                  key: formLoginKey,
                  child: MobileView(
                    formLoginKey: formLoginKey,
                  ),
                ),
              ),
              isMobile
                  ? const SizedBox.shrink()
                  : Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Container(
                          width: size.width,
                          height: size.height,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover, image: AssetImage(icBg1))),
                          child: Container(
                            color: AppColors.colorBG.withOpacity( 0.60),
                          ),
                        ),
                      )),
            ],
          );
  }
}

class MobileView extends StatelessWidget {
  const MobileView({super.key, required this.formLoginKey});
  final GlobalKey<FormState> formLoginKey;
  @override
  Widget build(BuildContext context) {
    var provider = context.read<AuthProviders>();
    var size = MediaQuery.sizeOf(context);
    var isMobile = Responsive.isMobile(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(
                  left: isMobile ? size.width * 0.05 : size.width * 0.1,
                  right: isMobile ? size.width * 0.05 : size.width * 0.1),
              padding: EdgeInsets.all(isMobile ? 0 : 70.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: isMobile ? size.height * 0.05 : 0,
                  ),
                  Container(
                    alignment: isMobile ? Alignment.center : Alignment.topLeft,
                    child: setAssetImage(
                        image: icLogoApps,
                        width: 120,
                        height: 120,
                        fit: BoxFit.scaleDown),
                  ),
                  CommonTextWidget(
                    width: size.width,
                    textAlign: isMobile ? TextAlign.start : TextAlign.start,
                    text: "Login to your Juno Health Pro Account",
                    textStyle: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  commonTextFiledView(
                    topText: 30,
                    radius: 8,
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
                      radius: 8,
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
                        textColor: AppColors.colorActive,
                        text: forgotPassword,
                      ),
                    ),
                  ),
                  CommonButtonWidget(
                    top: twenty,
                    radius: 8,
                    padding: isMobile
                        ? const EdgeInsets.all(13)
                        : const EdgeInsets.all(20),
                    onPressed: () {
                      final isValid =
                          formLoginKey.currentState?.validate() ?? false;
                      if (isValid) {
                        Map<String, dynamic> body = {
                          "email": provider.tetEmail.text,
                          "password": provider.tetPassword.text,
                          "role": "doctor",
                        };

                        provider
                            .callLoginApi(
                                context: context, body: body, isLogin: true)
                            .then((value) {
                          if (provider.loginModel?.token != null) {
                            if (kIsWeb) {
                              pushNamedAndRemoveUntil(
                                  context: context,
                                  routeName: RouteName.adminDashboardScreen);
                            } else {
                              pushNamedAndRemoveUntil(
                                  context: context,
                                  routeName: RouteName.dashboardScreen);
                            }

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
                        top: isMobile ? size.height * 0.03 : 20,
                        left: isMobile ? size.width * zero01 : 10,
                        right: isMobile ? size.width * zero01 : 10),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  SizedBox(
                    height: isMobile ? 10 : 20,
                  ),
                  Center(
                    child: RichText(
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
                  ),
                ],
              ),
            ),
            context.watch<AuthProviders>().isFetching
                ? showLoaderList()
                : const SizedBox.shrink()
          ],
        ),
      ],
    );
  }
}
