import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/app_scaffold.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/responsive.dart';
import 'package:flutter/material.dart';

class HealthFeedScreen extends StatelessWidget {
  const HealthFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    var isMobile = Responsive.isMobile(context);
    var isDesktop = Responsive.isDesktop(context);
    return AppScaffold(
        left: 0,
        right: 0,
        appBar: commonAppBar(
          title: "Health Feed".toUpperCase(),
        ),
        // appBar: commonAppBar(title: "Health Feed".toUpperCase()),
        child: Container(
          width: size.width,
          height: size.height,
          color: isMobile ? AppColors.colorBG : Colors.white,
          child: ListView(
            children: [
              isMobile
                  ? Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _topView(),
                          _middleView(),
                          _bottomView(size: size)
                        ],
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _topView(),
                        Container(
                          width: size.width,
                          color: AppColors.colorBG,
                          padding: const EdgeInsets.all(20),
                          child: CommonTextWidget(
                            textAlign: TextAlign.center,
                            text:
                                "To post your first article, log on to our web publishing tool at fit.practo.com",
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: CommonTextWidget(
                            text: "YOUR STATS  ",
                            fontWeight: FontWeight.w600,
                            left: 5,
                          ),
                        ),
                        const Divider(
                          thickness: 0.3,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: commonView(
                                    height: isDesktop
                                        ? size.height * 0.15
                                        : size.height * 0.1,
                                    color: AppColors.colorBG,
                                    fontSize: 30,
                                    decoration: commonBoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: AppColors.colorBG)),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: commonView(
                                    height: isDesktop
                                        ? size.height * 0.15
                                        : size.height * 0.1,
                                    color: AppColors.colorBG,
                                    fontSize: 30,
                                    decoration: commonBoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: AppColors.colorBG),
                                    title: "Article Likes"),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: commonView(
                                    height: isDesktop
                                        ? size.height * 0.15
                                        : size.height * 0.1,
                                    color: AppColors.colorBG,
                                    fontSize: 30,
                                    decoration: commonBoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: AppColors.colorBG),
                                    title: "Profile Views (via Health Feed)"),
                              )
                            ],
                          ),
                        )
                        // _bottomView()
                      ],
                    )
            ],
          ),
        ));
  }

  commonView(
      {String? title,
      Color? color,
      Decoration? decoration,
      double? width,
      double? height,
      double? fontSize}) {
    return Container(
      width: width,
      height: height,
      decoration: decoration ??
          BoxDecoration(
            color: color ?? Colors.white,
          ),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonTextWidget(
            text: "0",
            fontSize: fontSize ?? 20,
          ),
          CommonTextWidget(
            text: title ?? "Article Views",
            fontSize: 14,
            top: 5,
            textColor: Colors.grey,
            fontWeight: FontWeight.w600,
          )
        ],
      ),
    );
  }

  _middleView({Color? color}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(
          thickness: 0.3,
        ),
        Container(
          color: color ?? Colors.white,
          padding: const EdgeInsets.all(20.0),
          child: CommonTextWidget(
            text:
                "To post your first article, log on to our web publishing tool at fit.practo.com",
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  _bottomView({required Size size}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            width: size.width,
            padding: const EdgeInsets.all(15.0),
            color: Colors.grey.withOpacity( 0.20),
            child: CommonTextWidget(
              text: "YOUR STATS  ",
              fontWeight: FontWeight.w600,
              left: 5,
            )),
        commonView(width: size.width),
        const SizedBox(
          height: 10,
        ),
        /*  const Divider(
          thickness: 0.3,
        ),*/
        commonView(title: "Article Likes", width: size.width),
        const SizedBox(
          height: 10,
        ),
        /*const Divider(
          thickness: 0.3,
        ),*/
        commonView(title: "Profile Views (via Health Feed)", width: size.width),
      ],
    );
  }

  _topView() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonTextWidget(
            text: "Hello Dr. Bhavesh Gohil",
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
          CommonTextWidget(
            text:
                "Welcome on-board Health Feed 1- a community of doctors, who create exclusive health articles and tips for millions of people.",
            top: 15,
            fontSize: 15,
          ),
          CommonTextWidget(
            text: "1500+ doctors have written articles",
            fontSize: 13,
            top: 20,
          ),
          CommonTextWidget(
            text: "6000+ articles published till date",
            fontSize: 13,
            top: 15,
          ),
          CommonTextWidget(
            text: "1,500,000 lives touched in last 30 days",
            fontSize: 13,
            top: 15,
          ),
        ],
      ),
    );
  }
}
