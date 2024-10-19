import 'package:doctor_app/core/color_utils.dart';
import 'package:doctor_app/core/common/app_scaffold.dart';
import 'package:doctor_app/core/common/common_button_widget.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/image/image_path.dart';
import 'package:doctor_app/core/responsive.dart';
import 'package:doctor_app/core/route/route.dart';
import 'package:doctor_app/provider/dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    var isMobile = Responsive.isMobile(context);
    var isTablet = Responsive.isTablet(context);
    var isDesktop = Responsive.isDesktop(context);
    return AppScaffold(
      left: 0,
      right: 0,
      color: Colors.white,
      /* appBar: isMobile
          ? commonAppBar(title: "PROFILE")
          : PreferredSize(preferredSize: Size.zero, child: Container()),*/
      appBar: isMobile
          ? PreferredSize(preferredSize: Size.zero, child: Container())
          : commonAppBar(
              title: "PROFILE",
              color: colorBG,
              leading: commonBackRedirectButton(),
              colorText: colorText,
            ),
      child: Consumer<DashboardProvider>(builder: (context, provider, child) {
        return Container(
          width: size.width,
          height: size.height,
          color: isMobile
              ? colorBG
              : isDesktop
                  ? Colors.white
                  : Colors.white,
          //  color: colorGreen.withOpacity(0.10),
          child: ListView(
            children: [
              isMobile
                  ? _isMobileView(
                      isDesktop: isDesktop,
                      isTablet: isTablet,
                      provider: provider,
                      isMobile: isMobile,
                      size: size,
                      context: context)
                  : Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: _topView(
                                    isDesktop: isDesktop,
                                    isMobile: isMobile,
                                    size: size,
                                    isTablet: isTablet),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: _profileView(
                                    isDesktop: isDesktop,
                                    size: size,
                                    isMobile: isMobile),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: _addClinic(
                                    provider: provider,
                                    context: context,
                                    isDesktop: isDesktop,
                                    isMobile: isMobile,
                                    size: size),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: _topView(
                                    isTablet: isTablet,
                                    isDesktop: isDesktop,
                                    size: size,
                                    isMobile: isMobile,
                                    title: "Need Help?",
                                    btn: CommonButtonWidget(
                                      top: 20,
                                      text: "Report an issue",
                                      colorText: Colors.black,
                                      iconShow: true,
                                      padding: isMobile
                                          ? null
                                          : const EdgeInsets.all(18),
                                      width: isMobile
                                          ? size.width * 0.8
                                          : isTablet
                                              ? size.width * 0.3
                                              : size.width * 0.19,
                                      icon: const Icon(
                                        Icons.flag,
                                        color: Colors.black,
                                      ),
                                      colorButton: Colors.white,
                                      colorBorder: Colors.black,
                                      borderWidth: 1,
                                    )),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
            ],
          ),
        );
      }),
    );
  }

  _isMobileView(
      {required DashboardProvider provider,
      required bool isMobile,
      required bool isTablet,
      required bool isDesktop,
      required Size size,
      required BuildContext context}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              _topView(
                isTablet: isTablet,
                isDesktop: isDesktop,
                isMobile: isMobile,
                size: size,
              ),
              const SizedBox(
                height: 10,
              ),
              _profileView(
                  isDesktop: isDesktop, size: size, isMobile: isMobile),
              const SizedBox(
                height: 10,
              ),
              _addClinic(
                  isDesktop: isDesktop,
                  provider: provider,
                  context: context,
                  isMobile: isMobile,
                  size: size),
              const SizedBox(
                height: 10,
              ),
              _topView(
                  size: size,
                  isDesktop: isDesktop,
                  isTablet: isTablet,
                  isMobile: isMobile,
                  title: "Need Help?",
                  btn: CommonButtonWidget(
                    top: 20,
                    text: "Report an issue",
                    colorText: Colors.black,
                    iconShow: true,
                    bottom: 10,
                    height: isMobile ? 35 : null,
                    padding:
                        isMobile ? EdgeInsets.zero : const EdgeInsets.all(18),
                    width: isMobile ? size.width * 0.8 : size.width * 0.1,
                    icon: const Icon(
                      Icons.flag,
                      color: Colors.black,
                    ),
                    colorButton: Colors.white,
                    colorBorder: Colors.black,
                    borderWidth: 1,
                  )),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        )
      ],
    );
  }

  _topView(
      {required bool isMobile,
      required bool isDesktop,
      required bool isTablet,
      required Size size,
      String? title,
      Widget? btn}) {
    return Container(
      decoration: BoxDecoration(
          color: isMobile ? Colors.white : Colors.white,
          borderRadius: BorderRadius.circular(8)),
      height: isMobile
          ? null
          : isDesktop
              ? size.height * 0.39
              : size.height * 0.3,
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        margin: const EdgeInsets.all(0),
        decoration: commonBoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.withOpacity(0.50), width: 1),
            borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.check_circle_outline,
                    color: colorText,
                  ),
                  CommonTextWidget(
                    left: 5,
                    text: title ?? "Your profile is live on Practo!",
                    textColor: colorText,
                    fontSize: isMobile ? 12 : 14,
                    fontWeight: FontWeight.w700,
                  )
                ],
              ),
            ),
            Container(
                width: size.width,
                height: isMobile
                    ? null
                    : isDesktop
                        ? size.height * 0.25
                        : size.height * 0.20,
                color: Colors.grey.withOpacity(0.10),
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CommonTextWidget(
                          top: 10,
                          textAlign: TextAlign.center,
                          fontSize: isMobile ? 12 : 15,
                          text:
                              "Congratulations! Welcome to Practo family. Click below to check out your profile live on Practo.com",
                        ),
                        btn ??
                            CommonButtonWidget(
                              top: isMobile ? 10 : 30,
                              height: isMobile ? 35 : null,
                              bottom: isMobile ? 10 : null,
                              padding: isMobile
                                  ? EdgeInsets.zero
                                  : const EdgeInsets.all(18),
                              width: isMobile
                                  ? size.width * 0.8
                                  : isTablet
                                      ? size.width * 0.3
                                      : size.width * 0.2,
                              text: "View live profile",
                              colorButton: Colors.green,
                            )
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  _profileView(
      {required bool isMobile, required bool isDesktop, required Size size}) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.withOpacity(0.50), width: 1),
          color: isMobile ? Colors.white : colorBG,
          borderRadius: BorderRadius.circular(8)),
      height: isMobile
          ? size.height * 0.35
          : isDesktop
              ? size.height * 0.39
              : size.height * 0.3,
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: commonBoxDecoration(
                    border: Border.all(color: colorGreen, width: 1),
                    shape: BoxShape.circle),
                child: ClipOval(
                  child: setAssetImage(
                      image: icMen, width: 40, height: 40, fit: BoxFit.cover),
                ),
              ),
              commonInkWell(
                child: CommonTextWidget(
                  text: "Edit Profile",
                  textDecoration: TextDecoration.underline,
                  textColor: colorText,
                  fontWeight: FontWeight.w700,
                ),
                onTap: () {
                  final dashboardProvider = Provider.of<DashboardProvider>(
                      navigatorKey.currentState!.context,
                      listen: false);
                  dashboardProvider.getPageSelected = "edit_profile";
                  // context.read<DashboardProvider().getPageSelected("");
                  //context.read<DashboardProvider>().updatePage(EditProfileScreen());
                  /* pushScreen(
                      context: context, routeName: RouteName.editprofileScreen);*/
                },
              ),
            ],
          ),
          CommonTextWidget(
            text: "Dr. Richard Besser",
            fontWeight: FontWeight.w600,
            top: 20,
            fontSize: 14,
          ),
          CommonTextWidget(
            textColor: Colors.grey,
            fontSize: 12,
            text:
                "MS-Ophthalmology, DNB - Ophthalmology, DOMS, MBBSOphthalmologist/ Eye Surgeon",
            top: 10,
          ),
          CommonTextWidget(
            text: "24 years experience",
            top: 10,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider(
            thickness: 0.3,
          ),
          const SizedBox(
            height: 5,
          ),
          CommonTextWidget(
            text: "2000/12/3569",
          ),
          Flexible(
            child: CommonTextWidget(
              text: "790 W. Chestnut Avenue, Monrovia, CA 91016",
              textColor: Colors.grey,
              top: 10,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  _addClinic(
      {required DashboardProvider provider,
      required BuildContext context,
      required bool isMobile,
      required bool isDesktop,
      required Size size}) {
    return Container(
      height: isMobile
          ? null
          : isDesktop
              ? size.height * 0.39
              : size.height * 0.3,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.withOpacity(0.50), width: 1),
          color: isMobile ? Colors.white : colorBG,
          borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.all(0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            clipBehavior: Clip.none,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8))),
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonTextWidget(
                  text: "Clinics",
                  fontWeight: FontWeight.w700,
                ),
                commonInkWell(
                  onTap: () {
                    pushScreen(
                        context: context, routeName: RouteName.addClinicScreen);
                  },
                  child: CommonTextWidget(
                    text: "Add Clinic",
                    textColor: colorText,
                    textDecoration: TextDecoration.underline,
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            ),
          ),
          /*  ListView.builder(
              primary: false,
              itemCount: provider.clinicList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(top: 5, bottom: 5),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: commonBoxDecoration(
                    color: Colors.white,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Container(
                          height: 80,
                          width: 80,
                          decoration: commonBoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: Colors.red),
                          child: commonImageNetworkWidget(
                              path: provider.clinicList[index].icon,
                              width: 80,
                              height: 80)),
                    ),
                    title: CommonTextWidget(
                      text: provider.clinicList[index].date,
                      fontSize: 13,
                    ),
                    subtitle: CommonTextWidget(
                      text: provider.clinicList[index].content,
                      fontSize: 10,
                    ),
                  ),
                );
              })*/
        ],
      ),
    );
  }
}
