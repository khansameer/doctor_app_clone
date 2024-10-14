import 'package:doctor_app/core/app_constants.dart';
import 'package:doctor_app/core/common/common_button_widget.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/image/image_path.dart';
import 'package:doctor_app/core/route/route.dart';
import 'package:doctor_app/core/string/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/common/app_scaffold.dart';


class ForgotScreen extends StatelessWidget {
  const ForgotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return AppScaffold(

      appBar: commonAppBar(title: forgotPasswordText),
      child: ListView(
        children: [
          SizedBox(height: size.height*0.05,),

          Align(
              alignment: Alignment.center,
              child: CommonTextWidget(
                text: "Forgot Password",
                textStyle: GoogleFonts.agbalumo(
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  fontSize: 25,
                ),

                top: 15,

              )),
          const SizedBox(height: 20,),
          setAssetImage(image: icLoginLogo,width: 200,height: 180,  fit:BoxFit.scaleDown),


          Align(
            alignment: Alignment.center,
            child: CommonTextWidget(
              top: size.height * zero002,
              textColor: Colors.black,
              text: forgotPasswordTextDesc,
            ),
          ),
          commonTextFiledView(
              title: yourEmail,
              hint: enterYourEmail,
              topText: size.height * 0.04,
              topTextField: ten),
          CommonButtonWidget(
            onPressed: () {
              pushScreen(
                  context: context,
                  routeName: RouteName.forgotPasswordOptView);

            },
            top: size.height * zero004,
            text: resetPassword,
          ),
        ],
      ),
    );
  }
}
