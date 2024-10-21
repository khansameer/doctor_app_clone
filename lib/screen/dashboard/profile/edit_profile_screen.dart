import 'package:doctor_app/core/color_utils.dart';
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
    var isTablet = Responsive.isTablet(context);
    return AppScaffold(
      appBar: commonAppBar(
          color: colorBG,
          colorText: Colors.black,
          title: 'EDIT PROFILE',
          leading: commonBackRedirectButton(page: "Profile")),
      child: Container(
        child: isMobile
            ? SizedBox(
                width: size.width,
                height: size.height,
                child: _mobileView(size: size),
              )
            : Center(
                child: Container(
                  decoration: commonBoxDecoration(
                      color: colorBG, borderRadius: BorderRadius.circular(8)),
                  width: isTablet ? size.width * 0.9 : size.width * 0.33,
                  height: size.height * 0.7,
                  /*child: _webView(size: size)*/
                ),
              ),
      ),
    );
  }

  _mobileView({required Size size}) {
    return Consumer<ProfileProvider>(builder: (context, provider, child) {
      return Container(
        width: size.width,
        height: size.height,
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
                                          textColor: colorText))
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
                      title: "Name",
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
                      selectedValue: provider.selectedGender,
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
                SizedBox(
                  height: 20,
                ),
                CommonButtonWidget(
                  text: "Save Change",
                  bottom: 45,
                  height: 45,
                )
              ],
            ),
          ],
        ),
      );
    });
  }

/*  _webView({required Size size}) {
    return Consumer<ProfileProvider>(builder: (context, provider, child) {
      return ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonTextWidget(
                      text: "Account",
                      fontWeight: FontWeight.w600,
                    ),
                    CommonButtonWidget(
                        radius: 8, fontSize: 12, text: "Save Change")
                  ],
                ),
              ),
              const Divider(
                thickness: 0.3,
              ),
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CommonTextWidget(
                                          text:
                                              "Pick a photo from your\ncomputer",
                                          left: 10,
                                          fontSize: 12,
                                        ),
                                        commonInkWell(
                                            child: CommonTextWidget(
                                                text: "Add Photo",
                                                top: 8,
                                                left: 10,
                                                fontWeight: FontWeight.w800,
                                                textColor: colorText))
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          )),

                          Expanded(
                              child: Flexible(
                                  child: commonTextFiled(
                                      size: size, title: "Name*"))),
                          //  const Expanded(child: Column())
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: commonTextFiled(
                                title: "Phone Number",
                                size: size,
                              )),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                  child: commonTextFiled(
                                title: "Email Address",
                                size: size,
                              )),
                              const SizedBox(
                                width: 20,
                              ),
                              */ /* Expanded(
                                  child:
                                  commonTextFiled( title: "Gender",size: size,)),*/ /*
                              Expanded(
                                  child: commonDropDown(
                                size: size,
                                items: provider.itemGenderList,
                                onChanged: (String? value) {
                                  provider.setGenderValue = value ?? '';
                                },
                                selectedValue: provider.selectedGender,
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
                                size: size,
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
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                  child: commonDropDown(
                                      items: provider.timeZoneList,
                                      onChanged: (String? value) {
                                        provider.setTimeZoneValue = value ?? '';
                                      },
                                      selectedValue: provider.selectTimeZone,
                                      size: size,
                                      title: "Time Zone")),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Divider(
                      thickness: 0.3,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
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
                                title: "House No./ Street Name/ Area*",
                                size: size,
                              )),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                  child: commonTextFiled(
                                title: "Colony / Street / Locality*",
                                size: size,
                              )),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                  child: commonTextFiled(
                                title: "City",
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
                                title: "State",
                                size: size,
                              )),
                              const SizedBox(
                                width: 20,
                              ),
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
                                size: size,
                              )),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: 0.3,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(child: Container()),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      );
    });
  }*/

  commonTextFiled({String? title, required Size size, double? width}) {
    return commonTextFiledView(
        textFontSize: 12,
        height: 40,
        radius: 5,
        width: width ?? size.width * 0.1,
        topTextField: 5,
        title: title ?? "Name*");
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
                border:
                    Border.all(color: Colors.grey.withOpacity(0.40), width: 1)),
            size: size,
            items: items ?? ["Sa", "dddd", "dd"]),
      ],
    );
  }
}
