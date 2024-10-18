import 'package:doctor_app/core/app_constants.dart';
import 'package:doctor_app/core/color_utils.dart';
import 'package:doctor_app/core/common/app_scaffold.dart';
import 'package:doctor_app/core/common/common_button_widget.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/image/image_path.dart';
import 'package:doctor_app/core/responsive.dart';
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
    var isTablet=Responsive.isTablet(context);
    return AppScaffold(

      appBar: isMobile?commonAppBar(

          color: Colors.white,
          iconColor: Colors.black
      ):PreferredSize(preferredSize: Size.zero, child: Container()),
      left:isMobile?null: 0,
      right: isMobile?null: 0,

      child: commonResponsiveLayout(
        size: size,
        isTablet: isTablet,
        isMobile: isMobile,
        child: ListView(
          children: [
            SizedBox(
              height: isMobile?size.height * 0.0:0,
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
                  text: checkYourEmail,
                  textStyle: GoogleFonts.inter(
                    fontWeight: FontWeight.w700,
                    color: colorGreen,
                    fontSize: 25,
                  ),

                )),


           /* SizedBox(
              height: size.height * zero002,
            ),*/
            const SizedBox(height: 40,),
            Align(
              alignment: Alignment.center,
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
                  cursorColor: Colors.black,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(twelve),
                    fieldHeight: fifty,
                    fieldWidth: fifty,
                    borderWidth: four,
                    selectedColor: colorGreen,
                    activeBorderWidth: zero05,
                    disabledBorderWidth: zero05,
                    inactiveBorderWidth: zero05,
                    activeColor: colorGreen,
                    inactiveColor: Colors.grey,
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
              left: isMobile?null:50,
              right: isMobile?null:50,
              top: isMobile?size.height * zero004:20,
              text: verifyCode,
              padding: isMobile?null:const EdgeInsets.all(20),
              onPressed: () {
                /* pushScreen(
                    context: context,
                    routeName: RouteName.forgotPasswordResetView);*/
              },
            ),
            SizedBox(
              height: isMobile?size.height * zero008:30,
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
      ),
    );
  }
}
