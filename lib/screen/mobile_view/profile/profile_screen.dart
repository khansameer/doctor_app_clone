import 'package:doctor_app/core/colors.dart';
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

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    var isMobile = Responsive.isMobile(context);
    var isTablet = Responsive.isTablet(context);
    return AppScaffold(
      left: 0,
      right: 0,
      appBar: commonAppBar(
        title: "PROFILE",
      ),
      child: Consumer<DashboardProvider>(builder: (context, provider, child) {
        return Container(
          width: size.width,
          height: size.height,
          color: isMobile ? AppColors.colorBG : Colors.white,
          //  color: colorGreen.withOpacity(0.10),
          child: ListView(
            children: [
              isMobile
                  ? _isMobileView(
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
                                    isMobile: isMobile,
                                    size: size,
                                    isTablet: isTablet),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: _profileView(
                                    size: size, isMobile: isMobile),
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
                                    isMobile: isMobile,
                                    size: size),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: _topView(
                                    isTablet: isTablet,
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
                                              : size.width * 0.1,
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
                isMobile: isMobile,
                size: size,
              ),
              const SizedBox(
                height: 10,
              ),
              _profileView(size: size, isMobile: isMobile),
              const SizedBox(
                height: 10,
              ),
              _addClinic(
                  provider: provider,
                  context: context,
                  isMobile: isMobile,
                  size: size),
              const SizedBox(
                height: 10,
              ),
              _topView(
                  size: size,
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
      required bool isTablet,
      required Size size,
      String? title,
      Widget? btn}) {
    return Container(
      decoration: BoxDecoration(
          color: isMobile ? Colors.white : Colors.white,
          borderRadius: BorderRadius.circular(8)),
      height: isMobile ? null : size.height * 0.28,
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        margin: const EdgeInsets.all(0),
        decoration: commonBoxDecoration(
            color: Colors.white,
            border: Border.all(
                color: Colors.grey.withValues(alpha: 0.50), width: 1),
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
                    color: AppColors.colorText,
                  ),
                  CommonTextWidget(
                    left: 5,
                    text: title ?? "Your profile is live on Practo!",
                    textColor: AppColors.colorText,
                    fontSize: isMobile ? 12 : 14,
                    fontWeight: FontWeight.w700,
                  )
                ],
              ),
            ),
            Container(
                width: size.width,
                height: isMobile ? null : size.height * 0.20,
                color: Colors.grey.withValues(alpha: 0.10),
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
                                      : size.width * 0.1,
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

  _profileView({required bool isMobile, required Size size}) {
    return Container(
      decoration: BoxDecoration(
          border:
              Border.all(color: Colors.grey.withValues(alpha: 0.50), width: 1),
          color: isMobile ? Colors.white : AppColors.colorBG,
          borderRadius: BorderRadius.circular(8)),
      height: isMobile ? null : size.height * 0.28,
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
                    border: Border.all(color: AppColors.colorGreen, width: 1),
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
                  textColor: AppColors.colorText,
                  fontWeight: FontWeight.w700,
                ),
                onTap: () {
                  /*  final dashboardProvider = Provider.of<DashboardProvider>(
                      navigatorKey.currentState!.context,
                      listen: false);
                  dashboardProvider.getPageSelected = "edit_profile";*/
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
          CommonTextWidget(
            text: "790 W. Chestnut Avenue, Monrovia, CA 91016",
            textColor: Colors.grey,
            top: 10,
            fontSize: 12,
          ),
        ],
      ),
    );
  }

  _addClinic(
      {required DashboardProvider provider,
      required BuildContext context,
      required bool isMobile,
      required Size size}) {
    return Container(
      height: isMobile ? null : size.height * 0.28,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
          border:
              Border.all(color: Colors.grey.withValues(alpha: 0.50), width: 1),
          color: isMobile ? Colors.white : AppColors.colorBG,
          borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.all(0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
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
                    textColor: AppColors.colorText,
                    textDecoration: TextDecoration.underline,
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            ),
          ),
          ListView(
            shrinkWrap: true,
            children: [
              ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                primary: false,
                itemCount: provider.clinicList.length,
                itemBuilder: (context, index) {
                  return Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: commonBoxDecoration(
                      color: Colors.white,
                    ),
                    margin: const EdgeInsets.only(top: 5, bottom: 5),
                    child: ListTile(
                      titleAlignment: ListTileTitleAlignment.center,
                      contentPadding:
                          const EdgeInsets.only(left: 10, right: 10),
                      dense: true,
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
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
