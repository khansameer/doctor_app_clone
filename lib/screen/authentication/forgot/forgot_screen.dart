import 'package:doctor_app/core/app_constants.dart';
import 'package:doctor_app/core/color_utils.dart';
import 'package:doctor_app/core/common/common_button_widget.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/image/image_path.dart';
import 'package:doctor_app/core/responsive.dart';
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
    var isMobile = Responsive.isMobile(context);
    return AppScaffold(

      appBar: commonAppBar(

          color: Colors.white,
          iconColor: Colors.black
      ),
      left:isMobile?null: 0,
    right: isMobile?null: 0,

      child: commonResponsiveLayout(
        size: size,

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
                  text: "Forgot Password",
                  textStyle: GoogleFonts.inter(
                    fontWeight: FontWeight.w700,
                    color: colorGreen,
                    fontSize: 25,
                  ),

                )),


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
              padding: isMobile?null:EdgeInsets.all(20),
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
      ),
    );
  }
}
