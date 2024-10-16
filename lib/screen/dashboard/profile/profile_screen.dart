import 'package:doctor_app/core/color_utils.dart';
import 'package:doctor_app/core/common/app_scaffold.dart';
import 'package:doctor_app/core/common/common_button_widget.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/image/image_path.dart';
import 'package:doctor_app/core/route/route.dart';
import 'package:doctor_app/provider/dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return AppScaffold(
      left: 0,
      right: 0,
      appBar: commonAppBar(title: "PROFILE"),
      child: Consumer<DashboardProvider>(builder: (context, provider, child) {
        return Container(
          width: size.width,
          height: size.height,
          color: colorGreen.withOpacity(0.10),
          child: ListView(
            children: [
              _topView(),
              const SizedBox(
                height: 10,
              ),
              _profileView(context),
              const SizedBox(
                height: 10,
              ),
              _addClinic(provider: provider, context: context),
              const SizedBox(
                height: 10,
              ),
              _helpView(),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        );
      }),
    );
  }

  _topView() {
    return Container(
      color: Colors.white,
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: commonBoxDecoration(
            color: Colors.green.withOpacity(0.15),
            borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(
                  Icons.check_circle_outline,
                  color: Colors.green,
                ),
                CommonTextWidget(
                  text: "Your profile is live on Practo!",
                  textColor: Colors.green,
                  fontWeight: FontWeight.w800,
                )
              ],
            ),
            CommonTextWidget(
              top: 10,
              fontSize: 13,
              text:
                  "Congratulations! Welcome to Practo family. Click below to check out your profile live on Practo.com",
            ),
            CommonButtonWidget(
              top: 10,
              text: "View live profile",
              colorButton: Colors.green,
            )
          ],
        ),
      ),
    );
  }

  _profileView(context) {
    return Container(
      color: Colors.white,
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
                width: 60,
                height: 60,
                decoration: commonBoxDecoration(
                    border: Border.all(color: colorGreen, width: 1),
                    shape: BoxShape.circle),
                child: ClipOval(
                  child:
                      setAssetImage(image: icLoginLogo, width: 40, height: 40,fit: BoxFit.scaleDown),
                ),
              ),

              commonInkWell(
                child: CommonTextWidget(
                  text: "Edit Profile",
                  textColor: Colors.amber,
                  fontWeight: FontWeight.w700,
                ),
                onTap: () {
                  pushScreen(
                      context: context, routeName: RouteName.editprofileScreen);
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
      {required DashboardProvider provider, required BuildContext context}) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
                  textColor: Colors.amber,
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          ListView.separated(
            shrinkWrap: true,
            itemCount: provider.clinicList.length,
            itemBuilder: (context, index) {
              return ListTile(
                contentPadding: EdgeInsets.zero,
                dense: true,
                leading: SizedBox(
                  height: 50,
                  width: 50,
                  child: commonImageNetworkWidget(
                      path: provider.clinicList[index].icon,
                      width: 50,
                      height: 50),
                ),
                title: CommonTextWidget(
                  text: provider.clinicList[index].date,
                  fontSize: 13,
                ),
                subtitle: CommonTextWidget(
                  text: provider.clinicList[index].content,
                  fontSize: 10,
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(
                thickness: 0.3,
              );
            },
          )
        ],
      ),
    );
  }

  _helpView() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonTextWidget(
            text: "Need Help?",
            fontWeight: FontWeight.w700,
          ),
          CommonButtonWidget(
            top: 20,
            text: "Report an issue",
            colorText: Colors.black,
            iconShow: true,
            icon: const Icon(
              Icons.flag,
              color: Colors.black,
            ),
            colorButton: Colors.white,
            colorBorder: Colors.black,
            borderWidth: 1,
          )
        ],
      ),
    );
  }
}
