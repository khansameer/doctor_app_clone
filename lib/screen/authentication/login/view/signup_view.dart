import 'package:doctor_app/core/app_constants.dart';
import 'package:doctor_app/core/color_utils.dart';
import 'package:doctor_app/core/common/app_scaffold.dart';
import 'package:doctor_app/core/common/common_button_widget.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
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
      context.read<AuthProviders>().getSpecializationsList();
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    var isTablet = Responsive.isTablet(context);
    var isMobile = Responsive.isMobile(context);
    var isDesktop = Responsive.isDesktop(context);
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

    final formSignKey = GlobalKey<FormState>();
    return AppScaffold(
      left: isMobile ? null : 0,
      right: isMobile ? null : 0,
      appBar: isMobile
          ? commonAppBar(color: Colors.white, iconColor: Colors.black)
          : PreferredSize(preferredSize: Size.zero, child: Container()),
      child: commonResponsiveLayout(
        isMobile: isMobile,
        isTablet: isTablet,
        boxHeight: isDesktop ? size.height * 0.9 : size.height * 0.85,
        //    boxHeight: size.height * 0.85,
        size: size,
        child: Consumer<AuthProviders>(builder: (context, provider, child) {
          return Form(
            key: formSignKey,
            child: ListView(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: isMobile ? size.height * 0.00 : 0,
                    ),
                    setAssetImage(
                        image: icLoginLogo,
                        width: 200,
                        height: 120,
                        fit: BoxFit.scaleDown),
                    Align(
                        heightFactor: 0.05,
                        alignment: Alignment.center,
                        child: CommonTextWidget(
                          text: "Sign Up",
                          textStyle: GoogleFonts.inter(
                            fontWeight: FontWeight.w700,
                            color: colorGreen,
                            fontSize: 25,
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
                        topText: fifteen,
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
                          if (!Validation.validateMobile(value.toString())) {
                            return phoneError;
                          }
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
                        text: "Specialty",
                        fontWeight: FontWeight.w500,
                        fontSize: sixteen,
                      ),
                    ),
                    const SizedBox(
                      height: ten,
                    ),
                    MultiSelectDialogField<SpecializationsModel>(
                      dialogHeight: size.height * zero3, // 30% of screen height
                      backgroundColor: Colors.white,
                      checkColor: colorGreen,
                      dialogWidth: twoHundred,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey, width: 1),
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
                    genderView(provider: provider),
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

                          if (provider.tetPassword.text != value.toString()) {
                            return "Password not match";
                          }
                          return null;
                        },
                        suffixIcon: IconButton(
                          onPressed: provider.toggleConfirmPasswordVisibility,
                          icon: Icon(
                            color: Colors.grey,
                            provider.isConfirmPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                        topText: fifteen,
                        topTextField: ten),
                    CommonButtonWidget(
                      top: twenty,
                      bottom: 0,
                      padding: isMobile ? null : EdgeInsets.all(20),
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
                                content: "Please pick  date of birth",
                                isMessage: true);
                          } else {
                            Map<String, dynamic> body = {
                              "firstName": provider.tetFName.text,
                              "lastName": provider.tetLName.text,
                              "email": provider.tetEmail.text,
                              "password": provider.tetPassword.text,
                              "dateOfBirth": provider.formattedDate,
                              "phoneNumber": provider.tetPhoneNO.text,
                              "role": "doctor",
                              "gender": provider.selectedGender.name,
                              "specializations": provider.selectedItems,
                              // "clinicAddresses": addressesJson
                            };

                            provider
                                .signupAPI(body: body, context: context)
                                .then((value) {
                              if (provider.signupModel?.doctor?.sId != null) {
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
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
