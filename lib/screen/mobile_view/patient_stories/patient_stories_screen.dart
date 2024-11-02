import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/app_scaffold.dart';
import 'package:doctor_app/core/common/common_button_widget.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/image/image_path.dart';
import 'package:doctor_app/core/responsive.dart';
import 'package:flutter/material.dart';

class PatientStoriesScreen extends StatelessWidget {
  const PatientStoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    var isMobile = Responsive.isMobile(context);
    var isTablet = Responsive.isTablet(context);
    var isDesktop = Responsive.isDesktop(context);
    return AppScaffold(
      left: 0,
      right: 0,
      appBar: commonAppBar(
        title: "Patient Stories".toUpperCase(),
      ),
      child: Container(
        width: size.width,
        color: isMobile ? AppColors.colorGreen : Colors.white,
        height: size.height,
        child: Center(
          child: Container(
            decoration: commonBoxDecoration(
                color: AppColors.colorBG,
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
            child: Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30),
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
                    text: "Patient Stories",
                    textColor: AppColors.colorText,
                    fontSize: isMobile ? 20 : 23,
                  ),
                  CommonTextWidget(
                    top: 15,
                    text:
                        "Know what your patients say about you\nand responds to them instantly",
                    textColor: AppColors.colorText,
                    fontSize: isMobile ? 13 : 16,
                    textAlign: TextAlign.center,
                    lineHeight: 1.5,
                  ),
                  CommonButtonWidget(
                    colorButton: AppColors.colorGreen,
                    colorText: Colors.white,
                    radius: 2,
                    fontSize: isMobile ? 12 : 16,
                    padding: isMobile
                        ? const EdgeInsets.all(10)
                        : const EdgeInsets.all(22),
                    fontWeight: FontWeight.w600,
                    top: 35,
                    width: isMobile
                        ? size.width * 0.6
                        : isTablet
                            ? size.width * 0.3
                            : size.width * 0.2,
                    text: "View Patient Stories".toUpperCase(),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
