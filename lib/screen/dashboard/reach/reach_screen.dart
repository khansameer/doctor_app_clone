import 'package:doctor_app/core/color_utils.dart';
import 'package:doctor_app/core/common/app_scaffold.dart';
import 'package:doctor_app/core/common/common_button_widget.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/image/image_path.dart';
import 'package:doctor_app/core/responsive.dart';
import 'package:flutter/material.dart';

class ReachScreen extends StatelessWidget {
  const ReachScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    var isMobile = Responsive.isMobile(context);
    var isTablet = Responsive.isTablet(context);
    var isDesktop = Responsive.isDesktop(context);

    return AppScaffold(
      left: 0,
      right: 0,
      appBar: isMobile
          ? PreferredSize(preferredSize: Size.zero, child: Container())
          : commonAppBar(
              leading: commonBackRedirectButton(),
              title: "Reach",
              color: colorBG,
              colorText: colorText),
      // appBar: isMobile?commonAppBar():PreferredSize(preferredSize: Size.zero, child: Container()),
      child: Container(
        width: size.width,
        color: isMobile ? colorGreen : Colors.white,
        height: size.height,
        child: Center(
          child: Container(
            decoration: commonBoxDecoration(
                color: colorBG,
                borderRadius: BorderRadius.circular(isMobile ? 0 : 10)),
            width: isMobile
                ? size.width
                : isTablet
                    ? size.width * 0.7
                    : size.width * 0.4,
            height: isMobile
                ? size.height
                : isDesktop
                    ? size.height * 0.8
                    : size.height * 0.6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                setAssetImage(
                    image: icLoginLogo,
                    width: isMobile ? size.width * 0.4 : size.width * 0.1),
                SizedBox(
                  height: isMobile ? size.height * 0.09 : size.height * 0.15,
                ),
                CommonTextWidget(
                  text: "Practo Reach",
                  textColor: colorText,
                  fontSize: isMobile ? 20 : 23,
                ),
                CommonTextWidget(
                  top: 15,
                  text:
                      "Increase the visibility of your practice amongst\n millions of patients on Practo",
                  textColor: colorText,
                  fontSize: isMobile ? 13 : 16,
                  textAlign: TextAlign.center,
                  lineHeight: 1.5,
                ),
                CommonButtonWidget(
                  colorButton: colorGreen,
                  padding:
                      isMobile ? EdgeInsets.all(10) : const EdgeInsets.all(22),
                  fontSize: isMobile ? 12 : 16,
                  colorText: Colors.white,
                  radius: 2,
                  fontWeight: FontWeight.w600,
                  top: 35,
                  width: isMobile
                      ? size.width * 0.6
                      : isTablet
                          ? size.width * 0.3
                          : size.width * 0.2,
                  text: "Get Practo Reach".toUpperCase(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
