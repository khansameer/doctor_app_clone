import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/app_scaffold.dart';
import 'package:doctor_app/core/common/common_button_widget.dart';
import 'package:doctor_app/core/common/common_drop_down_view.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/image/image_path.dart';
import 'package:doctor_app/core/responsive.dart';
import 'package:doctor_app/provider/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);

    var isMobile = Responsive.isMobile(context);
    return AppScaffold(
      appBar: isMobile
          ? commonAppBar(title: "Edit Profile".toUpperCase())
          : PreferredSize(preferredSize: Size.zero, child: Container()),
      child: SafeArea(
        child: SizedBox(
          width: size.width,
          child: _mobileView(size: size, isMobile: isMobile),
        ),
      ),
    );
  }

  _mobileView({required Size size, required bool isMobile}) {
    return Consumer<ProfileProvider>(builder: (context, provider, child) {
      return Container(
        color: Colors.white,
        padding: EdgeInsets.all(isMobile ? 15 : 25.0),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonTextWidget(
                          text: "Profile photo",
                          fontSize: 12,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 90,
                              height: 90,
                              child: setAssetImage(image: icDummyUsers),
                            ),
                            Flexible(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CommonTextWidget(
                                    text: "Pick a photo from your\ncomputer",
                                    left: 10,
                                    fontSize: 12,
                                  ),
                                  commonInkWell(
                                      child: CommonTextWidget(
                                          text: "Add Photo",
                                          top: 8,
                                          left: 10,
                                          fontWeight: FontWeight.w800,
                                          textColor: AppColors.colorText))
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    )),

                    //  const Expanded(child: Column())
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                        child: commonTextFiled(
                      //   title: "Name",

                      width: size.width,
                      size: size,
                    )),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: commonTextFiled(
                      title: "Phone Number",
                      width: size.width,
                      size: size,
                    )),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                        child: commonTextFiled(
                      title: "Email Address",
                      size: size,
                      width: size.width,
                    )),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: commonDropDown(
                      size: size,
                      items: provider.itemGenderList,
                      onChanged: (String? value) {
                        provider.setGenderValue = value ?? '';
                      },

                      selectedValue: provider.selectedGender ?? 'Male',
                      // selectedValue: provider.selectedGender,
                    ))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                        child: commonTextFiled(
                      title: "Date of birth",
                      width: size.width,
                      size: size,
                      // value:'1976-02-29',
                    )),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: commonDropDown(
                            items: provider.bloodGroupList,
                            onChanged: (String? value) {
                              provider.setBloodValue = value ?? '';
                            },
                            selectedValue: provider.selectBloodGroup,
                            size: size,
                            title: "Blood Group")),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                        child: commonDropDown(
                            items: provider.timeZoneList,
                            onChanged: (String? value) {
                              provider.setTimeZoneValue = value ?? '';
                            },
                            selectedValue: provider.selectTimeZone,
                            size: size,
                            title: "Time Zone")),
                    Expanded(child: Container())
                  ],
                ),
                /*
                  ],
                ),*/
                const SizedBox(
                  height: 20,
                ),
                const Divider(
                  thickness: 0.3,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonTextWidget(
                      text: "Address",
                      fontWeight: FontWeight.w700,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: commonTextFiled(
                            width: size.width,
                            title: "House No./ Street Name*",
                            size: size,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                            child: commonTextFiled(
                          width: size.width,
                          title: "Colony / Street / Locality*",
                          size: size,
                        )),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: commonTextFiled(
                          title: "City",
                          width: size.width,
                          size: size,
                        )),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                            child: commonTextFiled(
                          title: "State",
                          width: size.width,
                          size: size,
                        )),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: commonDropDown(
                                items: provider.countryList,
                                onChanged: (String? value) {
                                  provider.setCountryValue = value ?? '';
                                },
                                selectedValue: provider.selectCountry,
                                size: size,
                                title: "Country")),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                            child: commonTextFiled(
                          title: "Pin code",
                          width: size.width,
                          size: size,
                        )),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Divider(
                  thickness: 0.3,
                ),
                CommonTextWidget(
                  text: "Other information",
                  fontWeight: FontWeight.w700,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                        child: commonTextFiled(
                      width: size.width,
                      title: "Extra phone numbers",
                      size: size,
                    )),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: commonDropDown(
                            items: provider.languageList,
                            onChanged: (String? value) {
                              provider.setLanguageValue = value ?? '';
                            },
                            selectedValue: provider.selectLanguage,
                            size: size,
                            title: "Language")),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: CommonButtonWidget(
                    text: "Save Change",

                    fontSize: 13,
                    radius: 8,
                    //bottom: 45,
                    width: isMobile ? size.width * 0.3 : size.width * 0.1,
                    height: isMobile ? null : 40,
                  ),
                )
              ],
            ),
          ],
        ),
      );
    });
  }

  commonTextFiled({String? title, required Size size, double? width}) {
    return commonTextFiledView(
      textFontSize: 12,
      height: 40,
      radius: 5,
      width: width ?? size.width * 0.1,
      topTextField: 5,
      title: title ?? "Name*",
    );
  }

  commonDropDown(
      {required Size size,
      String? title,
      List<String>? items,
      void Function(String?)? onChanged,
      String? selectedValue}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonTextWidget(
          text: title ?? "Gender",
          fontSize: 12,
        ),
        const SizedBox(
          height: 5,
        ),
        CommonDropDownView(
            height: 39,
            onChanged: onChanged,
            selectedValue: selectedValue,
            horizontal: 5,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                    color: Colors.grey.withValues(alpha: 0.40), width: 1)),
            size: size,
            items: items ?? ["Sa", "dddd", "dd"]),
      ],
    );
  }
}
