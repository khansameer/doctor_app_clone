import 'package:doctor_app/core/app_constants.dart';
import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/common_button_widget.dart';
import 'package:doctor_app/core/common/common_drop_down_view.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/common/common_textfield.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/image/image_path.dart';
import 'package:doctor_app/core/responsive.dart';
import 'package:doctor_app/core/route/route.dart';
import 'package:doctor_app/core/string/string_utils.dart';
import 'package:doctor_app/core/validation/validation.dart';
import 'package:doctor_app/provider/auth_provider.dart';
import 'package:doctor_app/screen/authentication/model/specializations_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthProviders>().getSpecializationsList(context: context);
    });
  }

  //var tetExperience = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);

    var isMobile = Responsive.isMobile(context);

    return Scaffold(
      appBar: commonAppBar(color: Colors.white, iconColor: Colors.black),
      backgroundColor: Colors.white,
      body: isMobile
          ? Container(
              alignment: Alignment.topCenter,
              width: size.width,
              height: size.height,
              child: const Form(
                child: SignUpDesign(),
              ),
            )
          : Row(
              children: [
                const Expanded(
                  flex: 5,
                  child: SignUpDesign(),
                ),
                Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                        width: size.width,
                        height: size.height,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover, image: AssetImage(icBg1))),
                      ),
                    )),
              ],
            ),
    );
  }
}

class SignUpDesign extends StatefulWidget {
  const SignUpDesign({super.key});

  @override
  State<SignUpDesign> createState() => _SignUpDesignState();
}

class _SignUpDesignState extends State<SignUpDesign> {
  var tetLicenseNo = TextEditingController();
  var tetDegree = TextEditingController();
  var tetYear = TextEditingController();
  var tetInstitution = TextEditingController();
  var tetExperience = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
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
        provider.tetDob.text = provider.formattedDate;
      }
    }

    var isMobile = Responsive.isMobile(context);
    var isTablet = Responsive.isTablet(context);
    final formSignKey = GlobalKey<FormState>();
    return SingleChildScrollView(
      child: Consumer<AuthProviders>(builder: (context, provider, child) {
        return Form(
          key: formSignKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    color: Colors.white,
                    margin: EdgeInsets.only(
                        left: isMobile ? size.width * 0.05 : isTablet? size.width * 0.05:size.width * 0.1,
                        right: isMobile ? size.width * 0.05 : isTablet? size.width * 0.05:size.width * 0.1),
                    padding: EdgeInsets.all(isMobile ? 0 : 70.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                          alignment:
                              isMobile ? Alignment.center : Alignment.topLeft,
                          child: setAssetImage(
                              image: icLogoApps,
                              width: 120,
                              height: 120,
                              fit: BoxFit.scaleDown),
                        ),

                        Align(
                            alignment: Alignment.topLeft,
                            child: CommonTextWidget(
                              text: "Welcome to $appName!",
                              textStyle: GoogleFonts.inter(
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            )),
                        commonTextFiledView(
                            controller: provider.tetFName,
                            title: "First Name",
                            validator: (value) {
                              if (value.toString().trim().isEmpty) {
                                return "Please enter First Name";
                              }

                              return null;
                            },
                            keyboardType: TextInputType.name,
                            topText: twentyFive,
                            topTextField: ten),
                        commonTextFiledView(
                            controller: provider.tetLName,
                            title: "Last Name",
                            validator: (value) {
                              if (value.toString().trim().isEmpty) {
                                return "Please enter Last Name";
                              }

                              return null;
                            },
                            keyboardType: TextInputType.name,
                            topText: fifteen,
                            topTextField: ten),
                        commonTextFiledView(
                            title: yourEmail,
                            keyboardType: TextInputType.emailAddress,
                            hint: enterYourEmail,
                            validator: (value) {
                              if (value.toString().trim().isEmpty) {
                                return emptyEmail;
                              }
                              if (!Validation.validateEmail(value.toString())) {
                                return emailValidationMsg;
                              }
                              return null;
                            },
                            controller: provider.tetEmail,
                            topText: fifteen,
                            topTextField: ten),
                        commonTextFiledView(
                            title: "Phone Number",
                            keyboardType: TextInputType.phone,
                            controller: provider.tetPhoneNO,
                            validator: (value) {
                              if (value.toString().trim().isEmpty) {
                                return emptyPhone;
                              }
                              /* if (!Validation.validateUSMobile(
                                  value.toString())) {
                                return phoneError;
                              }*/
                              return null;
                            },
                            topText: fifteen,
                            topTextField: ten),

                        commonTextFiledView(
                            title: "Date of Birth",
                            isReadOnly: true,
                            suffixIcon: IconButton(
                                onPressed: () async {
                                  selectDate(context);
                                },
                                icon: const Icon(
                                  Icons.date_range,
                                  color: Colors.grey,
                                )),
                            controller: provider.tetDob,
                            onTap: () {
                              selectDate(context);
                            },
                            topText: fifteen,
                            topTextField: ten),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: CommonTextWidget(
                            top: ten,
                            text: "Gender",
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                          height: ten,
                        ),

                        CommonDropDownView(
                          hint: "Select Gender",
                          horizontal: 5,
                          height: 48,
                          items: provider.itemGenderList,
                          onChanged: (String? value) {
                            provider.setGenderValue = value ?? '';
                          },
                          selectedValue: provider.selectedGender,
                          size: size,
                        ),
                        commonTextFiledView(
                            title: "License Number",
                            keyboardType: TextInputType.number,
                            controller: tetLicenseNo,
                            topText: fifteen,
                            topTextField: ten),
                        commonTextFiledView(
                            controller: tetDegree,
                            title: "Qualification Degree",
                            keyboardType: TextInputType.number,
                            //  controller: provider.tetPhoneNO,

                            topText: fifteen,
                            topTextField: ten),
                        commonTextFiledView(
                            title: "Qualification Year",
                            controller: tetYear,
                            keyboardType: TextInputType.number,
                            //  controller: provider.tetPhoneNO,

                            topText: fifteen,
                            topTextField: ten),
                        commonTextFiledView(
                            title: "Institution",
                            controller: tetInstitution,
                            keyboardType: TextInputType.number,
                            //  controller: provider.tetPhoneNO,

                            topText: fifteen,
                            topTextField: ten),

                        commonTextFiledView(
                            title: "Experience",
                            controller: tetExperience,
                            keyboardType: TextInputType.number,
                            //  controller: provider.tetPhoneNO,

                            topText: fifteen,
                            topTextField: ten),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: CommonTextWidget(
                            top: ten,
                            text: "Specialty",
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                          height: ten,
                        ),

                        MultiSelectDialogField<SpecializationsModel>(
                          selectedColor: AppColors.primary,
                          title: CommonTextWidget(
                            text: "Select Specialty",
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),

                          searchTextStyle: commonTextStyle(fontSize: 12),
                          selectedItemsTextStyle: commonTextStyle(
                              color: Colors.green, fontSize: 12),

                          itemsTextStyle: commonTextStyle(fontSize: 12),

                          dialogHeight: size.height * zero3,
                          // 30% of screen height
                          backgroundColor: Colors.white,
                          checkColor: Colors.white,
                          dialogWidth: twoHundred,
                          buttonIcon: const Icon(
                            Icons.keyboard_arrow_down_sharp,
                            color: Colors.grey,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: AppColors.primary.withOpacity(0.20),
                                width: 1),
                          ),
                          items: provider.specializationsList
                              .map((e) => MultiSelectItem(e, e.name ?? ''))
                              .toList(),
                          listType: MultiSelectListType.LIST,
                          onConfirm: (selected) {
                            provider.setSelectedItems(
                              selected.map((e) => e.sId as String).toList(),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        // genderView(provider: provider),
                        commonTextFiledView(
                            keyboardType: TextInputType.visiblePassword,
                            controller: provider.tetPassword,
                            obscureText: !provider.isPasswordVisible,
                            title: password,
                            validator: (value) {
                              if (value.toString().trim().isEmpty) {
                                return "Please enter Password";
                              }

                              return null;
                            },
                            suffixIcon: IconButton(
                              onPressed: provider.togglePasswordVisibility,
                              icon: Icon(
                                color: Colors.grey,
                                provider.isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                            topText: ten,
                            topTextField: ten),
                        commonTextFiledView(
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: !provider.isConfirmPasswordVisible,
                            title: confirmPassword,
                            validator: (value) {
                              if (value.toString().trim().isEmpty) {
                                return "Please enter Confirm Password";
                              }

                              if (provider.tetPassword.text !=
                                  value.toString()) {
                                return "Password not match";
                              }
                              return null;
                            },
                            suffixIcon: IconButton(
                              onPressed:
                                  provider.toggleConfirmPasswordVisibility,
                              icon: Icon(
                                color: Colors.grey,
                                provider.isConfirmPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                            topText: fifteen,
                            topTextField: ten),

                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: commonText(
                                fontSize: twenty,
                                text: "Clinic Address",
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  provider.addAddress();
                                },
                                icon: const Icon(
                                  Icons.add_circle,
                                  color: Colors.green,
                                ))
                          ],
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: provider.addresses.length,
                          itemBuilder: (context, index) {
                            return AddressInputField(index: index);
                          },
                        ),
                        CommonButtonWidget(
                          top: thirtyFive,
                          bottom: 0,
                          radius: 8,
                          padding:
                              isMobile ? null : const EdgeInsets.all(twenty),
                          height: isMobile ? null : 40,

                          //padding: isMobile ? null : EdgeInsets.all(20),
                          onPressed: () {
                            final isValid =
                                formSignKey.currentState?.validate() ?? false;
                            if (isValid) {
                              if (provider.selectedItems.isEmpty) {
                                showCommonDialog(
                                    context: context,
                                    title: "Error",
                                    content: "Please select specialty",
                                    isMessage: true);
                              } else if (provider.tetDob.text.isEmpty) {
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
                                List<Map<String, dynamic>> addressesJson =
                                    provider.getAddressesInJson();
                                Map<String, dynamic> body = {
                                  "firstName": provider.tetFName.text,
                                  "lastName": provider.tetLName.text,
                                  "email": provider.tetEmail.text,
                                  "password": provider.tetPassword.text,
                                  "dateOfBirth": provider.formattedDate,
                                  "phoneNumber": provider.tetPhoneNO.text,
                                  "role": "doctor",
                                  "licenseNumber": tetLicenseNo.text,
                                  "profile": {
                                    "qualification": {
                                      "degree": tetDegree.text,
                                      "year": tetYear.text,
                                      "institution": tetInstitution.text
                                    },
                                    "experience": int.parse(tetExperience.text)
                                  },
                                  "clinicAddresses": addressesJson,
                                  "gender": provider.selectedGender,
                                  "specializations": provider.selectedItems,
                                  // "clinicAddresses": addressesJson
                                };

                                print('========bosu====${body.toString()}');
                                provider
                                    .signupAPI(body: body, context: context)
                                    .then((value) {
                                  if (provider.signupModel?.doctor?.sId !=
                                      null) {
                                    pushNamedAndRemoveUntil(
                                        context: context,
                                        routeName: RouteName.loginScreen);
                                    provider.resetFields();
                                  }
                                });
                              }
                            } else {
                              formSignKey.currentState?.save();
                            }
                          },
                          text: signup,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'Already have an account? ',
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      pushNamedAndRemoveUntil(
                                          context: context,
                                          routeName: RouteName.loginScreen);
                                    },
                                  text: 'Sign In',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  provider.isAdding ? showLoaderList() : const SizedBox.shrink()
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}

class AddressInputField extends StatelessWidget {
  final int index;

  const AddressInputField({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    var addressProvider = Provider.of<AuthProviders>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.all(eight),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          commonTextFiledView(
            topText: ten,
            topTextField: 10,
            title: "Full Address",
            //  keyboardType: TextInputType.streetAddress,
            hint: "",
            maxLines: 1,

            //   decoration: InputDecoration(labelText: 'Address'),
            onChange: (value) {
              addressProvider.updateAddress(index, 'address', value);
            },
          ),
          commonTextFiledView(
            title: "City",
            topText: ten,
            topTextField: 10,
            //text: city,
            onChange: (value) {
              addressProvider.updateAddress(index, 'city', value);
            },
          ),
          commonTextFiledView(
            hint: "",
            title: "State",
            topText: ten,
            topTextField: 10,
            onChange: (value) {
              addressProvider.updateAddress(index, 'state', value);
            },
          ),
          commonTextFiledView(
            //   text: zipCode,
            topText: ten,
            title: "Zip Code",
            topTextField: 10,

            //keyboardType: TextInputType.number,
            // decoration: InputDecoration(labelText: 'Zip Code'),
            onChange: (value) {
              addressProvider.updateAddress(index, 'zipCode', value);
            },
          ),
          if (index >
              0) // Only show the delete button for dynamically added addresses
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  addressProvider.removeAddress(index);
                },
              ),
            ),
          //Divider(),
        ],
      ),
    );
  }
}
