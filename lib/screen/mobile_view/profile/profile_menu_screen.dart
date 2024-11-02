import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/image/image_path.dart';
import 'package:doctor_app/core/responsive.dart';
import 'package:doctor_app/core/route/route.dart';
import 'package:flutter/material.dart';

class ProfileMenuScreen extends StatelessWidget {
  const ProfileMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);

    var isDesktop = Responsive.isDesktop(context);

    return Container(
      width: size.width,
      height: size.height,
      color: Colors.white,
      child: ListView(
        children: [
          const SizedBox(
            height: 40,
          ),
          Container(
            width: 120,
            height: 120,
            decoration: commonBoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 3)),
            child: CircleAvatar(
              child: ClipOval(
                child: setAssetImage(image: icDummyUser),
              ),
            ),
          ),
          CommonTextWidget(
            text: "Sameer Khan",
            fontSize: 16,
            top: 10,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w700,
          ),
          CommonTextWidget(
            text: "sameer@gmail.com",
            fontSize: 12,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w400,
          ),
          const SizedBox(
            height: 40,
          ),
          commonList(
            onTap: () {
              pushScreen(
                  context: context, routeName: RouteName.editprofileScreen);
            },
            title: "Edit Profile",
          ),
          commonList(
            onTap: () {
              pushScreen(context: context, routeName: RouteName.settingScreen);
            },
            icon: Icons.settings_outlined,
            title: "Setting",
          ),
          commonList(
            onTap: () {
              commonLogoutDialog(
                  contextAd: context,
                  isDesktop: isDesktop,
                  isMobile: isDesktop);
            },
            icon: Icons.exit_to_app_outlined,
            title: "Logout",
          ),
        ],
      ),
    );
  }

  commonList(
      {String? title, double? top, VoidCallback? onTap, IconData? icon}) {
    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      decoration: commonBoxDecoration(
          color: Colors.white,
          border:
              Border.all(color: Colors.grey.withValues(alpha: 0.50), width: 0)),
      margin: EdgeInsets.only(left: 0, right: 0, top: top ?? 0),
      child: ListTile(
        onTap: onTap,
        dense: true,
        titleAlignment: ListTileTitleAlignment.center,
        trailing: const Icon(
          Icons.arrow_forward_ios_outlined,
          color: Colors.grey,
          size: 20,
        ),

        leading: Container(
          width: 45,
          height: 45,
          decoration: const BoxDecoration(
              color: AppColors.colorBG, shape: BoxShape.circle),
          child: Icon(
            icon ?? Icons.edit,
            size: 20,
            color: Colors.grey,
          ),
        ),
        title: CommonTextWidget(
          text: title ?? "Sync Now",
          fontWeight: FontWeight.w600,
        ),
        //subtitle: subTitle,
      ),
    );
  }
}
