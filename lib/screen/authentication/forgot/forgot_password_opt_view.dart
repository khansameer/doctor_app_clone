import 'package:doctor_app/core/app_constants.dart';
import 'package:doctor_app/core/color_utils.dart';
import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/common_button_widget.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/image/image_path.dart';
import 'package:doctor_app/core/responsive.dart';
import 'package:doctor_app/core/route/route.dart';
import 'package:doctor_app/core/string/string_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ForgotPasswordOptView extends StatelessWidget {
  const ForgotPasswordOptView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    var isMobile = Responsive.isMobile(context);

    return Scaffold(
      appBar: commonAppBar(color: Colors.white, iconColor: Colors.black),
      backgroundColor: Colors.white,
      body: isMobile
          ? Container(
              alignment: Alignment.topCenter,
              width: size.width,
              height: size.height,
              child: const Form(
                child: ForgotPasswordOtpView(),
              ),
            )
          : Row(
              children: [
                const Expanded(flex: 5, child: ForgotPasswordOtpView()),
                Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                        width: size.width,
                        height: size.height,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover, image: AssetImage(icBg2))),
                      ),
                    )),
              ],
            ),
    );
  }
}

class ForgotPasswordOtpView extends StatelessWidget {
  const ForgotPasswordOtpView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    var isMobile = Responsive.isMobile(context);
    return Container(
      margin: EdgeInsets.only(
          left: isMobile ? size.width * 0.05 : size.width * 0.1,
          right: isMobile ? size.width * 0.05 : size.width * 0.1),
      padding: EdgeInsets.all(isMobile ? 0 : 70.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: isMobile ? size.height * 0.0 : 0,
          ),
          Align(
            alignment: isMobile ? Alignment.center : Alignment.topLeft,
            child: setAssetImage(
                image: icLogoApps,
                width: 120,
                height: 120,
                fit: BoxFit.scaleDown),
          ),
          Align(
              alignment: Alignment.topLeft,
              child: CommonTextWidget(
                text: checkYourEmail,
                textStyle: GoogleFonts.inter(
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  fontSize: 18,
                ),
              )),

          /* SizedBox(
                height: size.height * zero002,
                            ),*/
          const SizedBox(
            height: 15,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: RichText(
              text: TextSpan(
                  text: weSent,
                  style: commonTextStyle(color: Colors.grey),
                  children: <TextSpan>[
                    TextSpan(
                      text: ' contact@dscode...com',
                      style: commonTextStyle(
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: ' $enterText',
                      style: commonTextStyle(
                        color: Colors.grey,
                      ),
                    )
                  ]),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: const EdgeInsets.only(top: 30),
              // /   alignment: Alignment.center,
              //   width: size.width,
              child: PinCodeTextField(
                length: 5,
                obscureText: false,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                animationType: AnimationType.fade,
                cursorColor: AppColors.primary,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(twelve),
                  fieldHeight: fifty,
                  fieldWidth: fifty,
                  borderWidth: four,
                  selectedColor: AppColors.primary,
                  activeBorderWidth: 1,
                  disabledBorderWidth: 1,
                  inactiveBorderWidth: 1,
                  activeColor: AppColors.primary,
                  inactiveColor: AppColors.primary.withOpacity(0.40),
                  activeFillColor: Colors.white,
                ),
                animationDuration: const Duration(milliseconds: 300),
                backgroundColor: Colors.transparent,
                textStyle: commonTextStyle(
                    //textColor: Colors.white,
                    fontSize: fourteen,
                    fontWeight: FontWeight.w600),
                enableActiveFill: false,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                // controller: tetOTP,
                onCompleted: (v) {
                  //   provider.updatePin(v);
                },
                onChanged: (value) {
                  if (kDebugMode) {
                    print(value);
                  }
                },
                beforeTextPaste: (text) {
                  if (kDebugMode) {
                    print("Allowing to paste $text");
                  }
                  return true;
                },
                appContext: context,
              ),
            ),
          ),
          CommonButtonWidget(
            // left: isMobile ? null : 50,
            // right: isMobile ? null : 50,
            top: isMobile ? size.height * 0.04 : 20,
            text: verifyCode,
            padding: isMobile ? null : const EdgeInsets.all(20),
            onPressed: () {
              if (kIsWeb) {
                pushNamedAndRemoveUntil(
                    context: context, routeName: RouteName.loginScreen);
              } else {
                pushNamedAndRemoveUntil(
                    context: context, routeName: RouteName.loginScreen);
              }
            },
          ),
          SizedBox(
            height: isMobile ? size.height * 0.08 : 30,
          ),
          Center(
            child: RichText(
              text: TextSpan(
                  text: haveCode,
                  style: commonTextStyle(color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                        text: ' $resendEmil',
                        style: commonTextStyle(
                            color: colorGreen, fontWeight: FontWeight.w700),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // navigate to desired screen
                          })
                  ]),
            ),
          )
        ],
      ),
    );
  }
}
