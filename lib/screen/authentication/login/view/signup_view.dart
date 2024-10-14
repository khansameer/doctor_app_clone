
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/string/string_utils.dart';
import 'package:flutter/material.dart';


import '../../../../core/app_constants.dart';
import '../../../../core/common/common_button_widget.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Stack(
        children: [
          ListView(
            children: [
              commonTextFiledView(

                  title: name, topText: fifteen, topTextField: ten),
              commonTextFiledView(
                 // controller: provider.tetUserName,
                  title: "Username", topText: fifteen, topTextField: ten),


              commonTextFiledView(
                  title: yourEmail,
                  hint: enterYourEmail,
                //  controller: provider.tetEmail,
                  topText: fifteen,
                  topTextField: ten),
              commonTextFiledView(
                  //controller: provider.tetPassword,
                  //obscureText: !provider.isPasswordVisible,
                  title: password,
                  /*suffixIcon: IconButton(
                    onPressed: provider.togglePasswordVisibility,
                    icon: Icon(
                      color: Colors.grey,
                      provider.isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  ),*/
                  topText: fifteen,
                  topTextField: ten),
              commonTextFiledView(
                 // obscureText: !provider.isConfirmPasswordVisible,
                  title: confirmPassword,
                 /* suffixIcon: IconButton(
                    //onPressed: provider.togglePasswordVisibility,
                    icon: Icon(
                      color: Colors.grey,
                      provider.isConfirmPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  ),*/
                  topText: fifteen,
                  topTextField: ten),

              CommonButtonWidget(
                top: twenty,
                onPressed: ()  {

                  //  provider.singupWithFirebase(context);
                //  provider.addNewUsers(context);
                },
                text: signup,
              ),
            ],
          ),
        //  provider.isFetching?showLoaderList():const SizedBox.shrink()
        ],
      ),
    );
  }
}
