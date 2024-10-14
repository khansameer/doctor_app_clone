import 'package:doctor_app/core/app_constants.dart';
import 'package:doctor_app/core/color_utils.dart';
import 'package:doctor_app/core/common/common_button_widget.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/common/commons_screen_container.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/image/image_path.dart';
import 'package:doctor_app/core/string/string_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'package:provider/provider.dart';

class ForgotPasswordOptView extends StatelessWidget {
  const ForgotPasswordOptView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: commonAppBar(),
      body: CommonsScreenContainer(
        child: ListView(
          children: [
        
            SizedBox(height: size.height*0.05,),
        

            const SizedBox(height: 20,),
            setAssetImage(image: icLoginLogo,width: 200,height: 180,  fit:BoxFit.scaleDown),
            Align(
              alignment: Alignment.center,
              child: CommonTextWidget(
                top: size.height * zero002,
                textColor: Colors.black,
                fontSize: sixteen,
                fontWeight: FontWeight.w700,
                text: checkYourEmail,
              ),
            ),
            SizedBox(
              height: size.height * zero002,
            ),
            RichText(
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
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: const EdgeInsets.only(top: 40),
                alignment: Alignment.center,
                width: size.width,
                child: PinCodeTextField(
                  length: 5,
                  obscureText: false,
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
              top: size.height * zero004,
              text: verifyCode,
              onPressed: () {
               /* pushScreen(
                    context: context,
                    routeName: RouteName.forgotPasswordResetView);*/
              },
            ),
            SizedBox(
              height: size.height * zero008,
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
