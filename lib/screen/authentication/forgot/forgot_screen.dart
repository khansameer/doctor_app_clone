import 'package:doctor_app/core/app_constants.dart';
import 'package:doctor_app/core/common/common_button_widget.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/image/image_path.dart';
import 'package:doctor_app/core/responsive.dart';
import 'package:doctor_app/core/route/route.dart';
import 'package:doctor_app/core/string/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotScreen extends StatelessWidget {
  const ForgotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    final fromForgot = GlobalKey<FormState>();
    var isMobile = Responsive.isMobile(context);
    return Scaffold(
      appBar: commonAppBar(color: Colors.white, iconColor: Colors.black),
      backgroundColor: Colors.white,
      body: isMobile
          ? Container(
              alignment: Alignment.topCenter,
              width: size.width,
              height: size.height,
              child: Form(
                key: fromForgot,
                child: const ForgotPasswordView(),
              ),
            )
          : Row(
              children: [
                const Expanded(flex: 5, child: ForgotPasswordView()),
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

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

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
                text: "Forgot Password",
                textStyle: GoogleFonts.inter(
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  fontSize: 18,
                ),
              )),
          Align(
            alignment: Alignment.topLeft,
            child: CommonTextWidget(
              textAlign: TextAlign.start,
              top: size.height * 0.02,
              textColor: Colors.black,
              fontSize: 16,
              text: forgotPasswordTextDesc,
            ),
          ),
          commonTextFiledView(
              title: yourEmail,
              hint: enterYourEmail,
              topText: size.height * 0.03,
              topTextField: ten),
          CommonButtonWidget(
            padding: isMobile ? null : EdgeInsets.all(twenty),
            onPressed: () {
              pushScreen(
                  context: context, routeName: RouteName.forgotPasswordOptView);
            },
            top: size.height * 0.04,
            text: resetPassword,
          ),
        ],
      ),
    );
  }
}
