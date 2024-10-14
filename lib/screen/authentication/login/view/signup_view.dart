import 'package:doctor_app/core/app_constants.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/common/app_scaffold.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/image/image_path.dart';
import 'package:doctor_app/core/route/route.dart';
import 'package:doctor_app/core/string/string_utils.dart';
import 'package:doctor_app/provider/auth_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../core/common/common_button_widget.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return AppScaffold(
      appBar: commonAppBar(),
      child: Consumer<AuthProviders>(builder: (context, provider, child) {
        return ListView(

          clipBehavior: Clip.antiAliasWithSaveLayer,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Align(
                    alignment: Alignment.center,
                    child: CommonTextWidget(
                      text: "Hello Beautiful",
                      fontWeight: FontWeight.w700,
                      textColor: Colors.black,
                      fontSize: 16,
                    )),
                Align(
                    alignment: Alignment.center,
                    child: CommonTextWidget(
                      text: "Sign Up",
                      textStyle: GoogleFonts.agbalumo(
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        fontSize: 25,
                      ),

                      top: 10,

                    )),
                const SizedBox(height: 20,),
                setAssetImage(
                    fit:BoxFit.scaleDown
                    ,image: icLoginLogo,width: 200,height: 160),

                commonTextFiledView(
                    title: name, topText: fifteen, topTextField: ten),
                commonTextFiledView(
                    controller: provider.tetUserName,
                    title: "Username",
                    topText: fifteen,
                    topTextField: ten),
                commonTextFiledView(
                    title: yourEmail,
                    hint: enterYourEmail,
                    controller: provider.tetEmail,
                    topText: fifteen,
                    topTextField: ten),
                commonTextFiledView(
                    controller: provider.tetPassword,
                    obscureText: !provider.isPasswordVisible,
                    title: password,
                    suffixIcon: IconButton(
                      onPressed: provider.togglePasswordVisibility,
                      icon: Icon(
                        color: Colors.grey,
                        provider.isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                    topText: fifteen,
                    topTextField: ten),
                commonTextFiledView(
                    obscureText: !provider.isConfirmPasswordVisible,
                    title: confirmPassword,
                    suffixIcon: IconButton(
                      onPressed: provider.togglePasswordVisibility,
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
                  onPressed: () {
                    pushNamedAndRemoveUntil(
                        context: context,
                        routeName: RouteName.loginScreen);

                    //  provider.singupWithFirebase(context);
                    //  provider.addNewUsers(context);
                  },
                  text: signup,
                ),
                const SizedBox(height: 10,),
                RichText(
                  text: TextSpan(
                    text: 'Already have an account? ',
                    style: DefaultTextStyle.of(context).style,
                    children:  <TextSpan>[
                      TextSpan(
                          recognizer: TapGestureRecognizer()..onTap  = () {
                            pushNamedAndRemoveUntil(
                                context: context,
                                routeName: RouteName.loginScreen);
                          },
                          text: 'Sign Up', style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
              ],
            ),
          ],
        );
      }),
    );
  }
}
