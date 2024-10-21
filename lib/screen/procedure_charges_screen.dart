import 'package:doctor_app/core/app_constants.dart';
import 'package:doctor_app/core/common/common_button_widget.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProcedureChargesScreen extends StatelessWidget {
  const ProcedureChargesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: commonAppBar(title: "procedure charges".toUpperCase()),
      body: Consumer<AuthProviders>(
        builder: (context,provider,child) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [

                CommonTextWidget(text: "Add Procedure Charges",fontSize: 16,fontWeight: FontWeight.w800,),
                commonTextFiledView(
                  title: "Name",
                    keyboardType: TextInputType.name,
                    topTextField: 5
                ),
                commonTextFiledView(
                  topText: 10,
                    keyboardType: TextInputType.number,
                    title: "Cost",

                  topTextField: 5
                ),
                commonTextFiledView(
                    topText: 20,
                  keyboardType: TextInputType.multiline,
                    maxLines: 4,
                    title: "description",
                    topTextField: 5
                ),
                CommonButtonWidget(
                  top: twenty,

                  onPressed: () async {
                    String? userID = await getUserID();
                    Map<String, dynamic> body = {
                      "doctorId":userID,
                      "name": "Consultation",
                      "cost": 400,
                      "description": "Doctor fee fixed",

                    };

                    print('====${body.toString()}');
                  provider
                        .addProcedureCharges(body,)
                        .then((value) {

                    });

                 /*   final isValid =
                        formLoginKey.currentState?.validate() ??
                            false;
                    if (isValid) {
                      Map<String, dynamic> body = {
                        "email": provider.tetEmail.text,
                        "password": provider.tetPassword.text,
                        "role": "doctor",
                      };

                      provider
                          .callLoginApi(
                          context: context,
                          body: body,
                          isLogin: true)
                          .then((value) {
                        if (provider.loginModel?.token != null) {
                          pushNamedAndRemoveUntil(
                              context: context,
                              routeName:
                              RouteName.dashboardScreen);

                          formLoginKey.currentState?.save();
                          provider.resetFields();
                        }
                      });
                    }*/
                  },
                  text: "Add",
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}
