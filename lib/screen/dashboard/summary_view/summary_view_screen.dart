import 'package:doctor_app/core/color_utils.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/image/image_path.dart';
import 'package:doctor_app/core/responsive.dart';
import 'package:flutter/material.dart';

class SummaryViewScreen extends StatelessWidget {
  const SummaryViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    var isMobile = Responsive.isMobile(context);
    var isDesktop = Responsive.isDesktop(context);
    return Container(
      color: colorGreen.withOpacity(0.10),
      child: ListView(
        children: [
          isMobile
              ? Column(
                  children: [
                    commonView(
                        isMobile: isMobile,
                        size: size,
                        isShowLogo: false,
                        isDesktop: isDesktop),
                    commonView(
                        isDesktop: isDesktop,
                        size: size,
                        isMobile: isMobile,
                        image: icCongrats,
                        title: "Congrats",
                        desc:
                            "Congrats! You have successfully published your profile on Practo.com",
                        isShowButton: false),
                    commonView(
                        isDesktop: isDesktop,
                        hideButton: true,
                        image: icReach,
                        btnText: "GET PRACTO REACH",
                        size: size,
                        isMobile: isMobile,
                        isShowLogo: true,
                        title: "Reach",
                        desc:
                            "Increase the visibility of your practice amongst millions of patients on Practo. "),
                    commonView(
                        isDesktop: isDesktop,
                        hideButton: true,
                        isShowButton: false,
                        image: icConsult,
                        btnText: "GET PRACTO REACH",
                        size: size,
                        isMobile: isMobile,
                        isShowLogo: true,
                        title: "Consult",
                        desc:
                            "You have deactivated consult. No questions will be assigned to you till you activate it again"),
                    commonView(
                        size: size,
                        isDesktop: isDesktop,
                        isMobile: isMobile,
                        title: "Health Feed",
                        desc: "No Article data yet.",
                        isShowButton: false,
                        isShowLogo: false)
                  ],
                )
              : Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: commonView(
                              isDesktop: isDesktop,
                              size: size,
                              isMobile: isMobile,
                              isShowLogo: false),
                        ),
                        Expanded(
                          child: commonView(
                              isDesktop: isDesktop,
                              image: icCongrats,
                              size: size,
                              isMobile: isMobile,
                              title: "Congrats",
                              desc:
                                  "Congrats! You have successfully published your profile on Practo.com",
                              isShowButton: false),
                        ),
                        Expanded(
                          child: commonView(
                              hideButton: true,
                              image: icReach,
                              isDesktop: isDesktop,
                              btnText: "GET PRACTO REACH",
                              size: size,
                              isMobile: isMobile,
                              isShowLogo: true,
                              title: "Reach",
                              desc:
                                  "Increase the visibility of your practice amongst millions of patients on Practo. "),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: commonView(
                              hideButton: true,
                              isDesktop: isDesktop,
                              isShowButton: false,
                              image: icConsult,
                              btnText: "GET PRACTO REACH",
                              size: size,
                              isMobile: isMobile,
                              isShowLogo: true,
                              title: "Consult",
                              desc:
                                  "You have deactivated consult. No questions will be assigned to you till you activate it again"),
                        ),
                        Expanded(
                          child: commonView(
                              size: size,
                              isDesktop: isDesktop,
                              isMobile: isMobile,
                              title: "Health Feed",
                              desc: "No Article data yet.",
                              isShowButton: false,
                              isShowLogo: false),
                        ),
                        Expanded(child: Container()),
                      ],
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  commonBox({Widget? child}) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: const EdgeInsets.all(10),
      decoration: commonBoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: child,
    );
  }

  commonView(
      {required bool isMobile,
      required bool isDesktop,
      required Size size,
      String? title,
      String? desc,
      bool isShowButton = true,
      bool isShowLogo = true,
      bool hideButton = false,
      String? btnText,
      String? image}) {
    return commonBox(
        child: Container(
      height: isMobile
          ? null
          : isDesktop
              ? size.height * 0.3
              : size.height * 0.25,
      padding: EdgeInsets.all(isMobile ? 0 : 0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(12.0),
            child: CommonTextWidget(
              text: title ?? "Calender".toUpperCase(),
              fontSize: 13,
              fontWeight: isMobile ? null : FontWeight.w600,
            ),
          ),
          Container(
              width: size.width,
              height: isMobile
                  ? null
                  : isDesktop
                      ? size.height * 0.20
                      : size.height * 0.16,
              color: Colors.grey.withOpacity(0.10),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      isShowLogo
                          ? setAssetImage(
                              fit: BoxFit.scaleDown,
                              image: image ?? icLoginLogo,
                              width: isDesktop ? 60 : 90,
                              height: isDesktop ? 60 : 90)
                          : const SizedBox.shrink(),
                      CommonTextWidget(
                        top: 15,
                        textAlign: TextAlign.center,
                        fontSize: isMobile
                            ? 12
                            : isDesktop
                                ? 12
                                : 14,
                        text: desc ?? "No upcoming appointment or events today",
                      ),
                    ],
                  ),
                ),
              )),
          Container(
            width: size.width,
            padding: EdgeInsets.all(isMobile
                ? 12.0
                : isDesktop
                    ? 5
                    : 20),
            child: isShowButton
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      hideButton
                          ? const SizedBox.shrink()
                          : Flexible(
                              child: commonInkWell(
                                  child: CommonTextWidget(
                                fontWeight: FontWeight.w800,
                                text: "View All".toUpperCase(),
                                fontSize: 12,
                                textColor: colorAmber,
                              )),
                            ),
                      hideButton
                          ? const SizedBox.shrink()
                          : const SizedBox(
                              width: 10,
                            ),
                      commonInkWell(
                          child: CommonTextWidget(
                        fontWeight: FontWeight.w800,
                        textColor: colorAmber,
                        text: btnText ?? "Add Appointment".toUpperCase(),
                        fontSize: 12,
                      ))
                    ],
                  )
                : const SizedBox.shrink(),
          )
        ],
      ),
    ));
  }
}
