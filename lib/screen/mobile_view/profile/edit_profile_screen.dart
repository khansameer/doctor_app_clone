import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/app_scaffold.dart';
import 'package:doctor_app/core/common/common_button_widget.dart';
import 'package:doctor_app/core/common/common_drop_down_view.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/context_extension.dart';
import 'package:doctor_app/core/responsive.dart';
import 'package:doctor_app/core/string/string_utils.dart';
import 'package:doctor_app/core/validation/validation.dart';
import 'package:doctor_app/provider/auth_provider.dart';
import 'package:doctor_app/provider/profile_provider.dart';
import 'package:doctor_app/screen/authentication/model/login_model.dart';
import 'package:doctor_app/screen/web_view/screen/patient_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/common/commonprofile_view.dart';
import 'model/user_details_model.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var tetFName = TextEditingController();
  var tetLName = TextEditingController();
  var tetPhoneNO = TextEditingController();
  var tetEmail = TextEditingController();
  var tetDOB = TextEditingController();

  Future<void> selectDate(BuildContext context) async {
    final provider = context.read<AuthProviders>();
    final initialSelectedDate = provider.selectedDate;
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialSelectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != initialSelectedDate) {
      provider.updateDate(pickedDate);
      setState(() {
        tetDOB.text = provider.formattedDate;
      });
    }
  }
  UserDetailsModel ?userDetailsModel;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var provider= context.read<ProfileProvider>();
      provider.getUserDetails(context: context).then((value){
        if(provider.userDetailsModel?.user?.sId!=null){
          var data=provider.userDetailsModel?.user;
          tetFName.text='${data?.firstName.toString()}';
          tetLName.text='${data?.lastName.toString()}';
          tetEmail.text='${data?.email.toString()}';
          tetPhoneNO.text='${data?.phoneNumber.toString()}';
          tetDOB.text='${data?.dateOfBirth.toString()}';
          if (provider.itemGenderList.contains(data?.gender.toString().toCapitalize())) {
            provider.setGenderValue = data!.gender.toString().toCapitalize();
          }
      //    Provider.of<ProfileProvider>(context, listen: false).setGenderValue='${data?.dateOfBirth.toString().toCapitalize()}';
        //  provider.setGenderValue='${data?.gender.toString()}';

        }
      });


    });

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);

    var isMobile = Responsive.isMobile(context);
    var isTablet = Responsive.isTablet(context);
    return AppScaffold(
      appBar: isMobile
          ? commonAppBar(title: "Edit Profile".toUpperCase())
          : PreferredSize(preferredSize: Size.zero, child: Container()),
      child: SafeArea(
        child: SizedBox(
          width: size.width,
          child:
              _mobileView(size: size, isMobile: isMobile, isTablet: isTablet),
        ),
      ),
    );
  }

  _mobileView(
      {required Size size, required bool isMobile, required bool isTablet}) {
    final formProfile = GlobalKey<FormState>();
    var provider=context.read<ProfileProvider>();
    return  Form(
      key: formProfile,
      child: Stack(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(isMobile ? 15 : 20.0),
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
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    CommonProfileView(
                                      width: 90,
                                      urlImage: context.watch<ProfileProvider>().userDetailsModel?.user?.profile?.profilePicture/*'${provider.userDetailsModel?.user?.profile?.profilePicture.toString()}*/,
                                      filePickerResult: provider.pickedFile,
                                      height: 90,
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
                                              onTap: () async {
                                                provider.pickFiles(context: context);
                                              },
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
                              title: "First Name",
                              validator: (value) {
                                if (value.toString().trim().isEmpty) {
                                  return "Please enter First Name";
                                }

                                return null;
                              },
                              controller: tetFName,
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              width: size.width,
                              size: size,
                            )),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                            child: commonTextFiled(
                              //   title: "Name",
                              title: "Last Name",
                              controller: tetLName,
                              validator: (value) {
                                if (value.toString().trim().isEmpty) {
                                  return "Please enter Last Name";
                                }

                                return null;
                              },
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
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
                              controller: tetEmail,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              isReadOnly: true,
                              width: size.width,
                            )),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                            child: commonTextFiled(
                              title: "Phone Number",
                             /* validator: (value) {
                                if (value.toString().trim().isEmpty) {
                                  return emptyPhone;
                                }
                                if (!Validation.validateUSMobile(value.toString())) {
                                  return phoneError;
                                }
                                return null;
                              },*/
                              controller: tetPhoneNO,
                              keyboardType: TextInputType.phone,
                              textInputAction: TextInputAction.next,
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
                              title: "Date of birth",
                              width: size.width,
                              controller: tetDOB,
                              isReadOnly: true,
                              suffixIcon: IconButton(
                                  onPressed: () async {
                                    selectDate(context);
                                  },
                                  icon: const Icon(
                                    Icons.date_range,
                                    color: Colors.grey,
                                  )),
                              size: size,
                              // value:'1976-02-29',
                            )),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                            child: commonDropDown(
                              size: size,
                              hint: "Select Gender",
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
                            child: commonDropDown(
                                hint: "Select Time Zone",
                                items: provider.timeZoneList,
                                onChanged: (String? value) {
                                  provider.setTimeZoneValue = value ?? '';
                                },
                                selectedValue: provider.selectTimeZone,
                                size: size,
                                title: "Time Zone")),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                            child: commonDropDown(
                                hint: "Select Blood Group ",
                                items: provider.bloodGroupList,
                                onChanged: (String? value) {
                                  provider.setBloodValue = value ?? '';
                                },
                                selectedValue: provider.selectBloodGroup,
                                size: size,
                                title: "Blood Group")),
                      ],
                    ),
                    /*
                        ],
                      ),*/
                    const SizedBox(
                      height: 20,
                    ),
                    /*  const Divider(
                        thickness: 0.3,
                      ),*/
                    /* Column(
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
                      ),*/
                    /* const SizedBox(
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
                      ),*/
                    /*   Row(
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
                      ),*/
                    Align(
                      alignment: Alignment.topRight,
                      child: CommonButtonWidget(
                        text: "Save Change",

                        fontSize: 13,
                        onPressed: () {
                          final isValid =
                              formProfile.currentState?.validate() ?? false;
                          if (isValid) {
                            if (tetDOB.text.isEmpty) {
                              showCommonDialog(
                                  context: context,
                                  title: "Error",
                                  content: "Please pick date of birth",
                                  isMessage: true);
                            } else if (provider.selectedGender == null) {
                              showCommonDialog(
                                  context: context,
                                  title: "Error",
                                  content: "Please pick select gender",
                                  isMessage: true);
                            } else {
                              Map<String, String> body = {
                                "firstName": tetFName.text,
                                "lastName": tetLName.text,
                                "email": tetEmail.text,
                                "phoneNumber": tetPhoneNO.text,
                                "dateOfBirth": tetDOB.text,
                                "gender": provider.selectedGender.toString(),
                                "role": "doctor",
                              };

                              print(
                                  '=============================b${body.toString()}');

                              provider.uploadProfile(
                                  frontImage: null, context: context, body: body);
                            }
                          } else {
                            formProfile.currentState?.save();
                          }
                        },
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
          ),
          context.watch<ProfileProvider>().isFetching
              ? showLoaderList()
              : const SizedBox.shrink()
        ],
      ),
    );
  }

  commonTextFiled(
      {Widget? suffixIcon,
      String? title,
      String? Function(String?)? validator,
      required Size size,
      double? width,
      bool? isReadOnly,
      TextEditingController? controller,
      TextInputType? keyboardType,
      TextInputAction? textInputAction}) {
    return commonTextFiledView(
      textFontSize: 12,
      height: 40,
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      isReadOnly: isReadOnly,
      validator: validator,
      borderColor: Colors.grey.withOpacity(0.40),
      radius: 5,
      suffixIcon: suffixIcon,
      width: width ?? size.width * 0.1,
      topTextField: 5,
      title: title ?? "Name*",
    );
  }

  commonDropDown(
      {required Size size,
      String? title,
      String? hint,
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
            hint: hint,
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
