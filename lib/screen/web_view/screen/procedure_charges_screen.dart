import 'package:doctor_app/core/app_constants.dart';
import 'package:doctor_app/core/common/common_button_widget.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/responsive.dart';
import 'package:doctor_app/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProcedureChargesScreen extends StatefulWidget {
  const ProcedureChargesScreen({super.key});

  @override
  State<ProcedureChargesScreen> createState() => _ProcedureChargesScreenState();
}

class _ProcedureChargesScreenState extends State<ProcedureChargesScreen> {
  var tetName = TextEditingController();
  var tetCost = TextEditingController();
  var tetDescription = TextEditingController();
  final formProcedureKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var isMobile = Responsive.isMobile(context);
    return Consumer<AuthProviders>(builder: (context, provider, child) {
      return Form(
        key: formProcedureKey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CommonTextWidget(
                    text: "Add Procedure Charges",
                    fontSize: 16,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w700,
                    // top: 20,
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.close,
                        size: 18,
                        color: Colors.black,
                      ))
                ],
              ),
              /*  CommonTextWidget(
                text: "Add Procedure Charges",
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),*/
              commonTextFiledView(
                  title: "Name",
                  validator: (value) {
                    if (value.toString().trim().isEmpty) {
                      return "Please enter name";
                    }

                    return null;
                  },
                  controller: tetName,
                  keyboardType: TextInputType.name,
                  topTextField: 5),
              commonTextFiledView(
                  topText: 10,
                  validator: (value) {
                    if (value.toString().trim().isEmpty) {
                      return "Please enter cost";
                    }

                    return null;
                  },
                  controller: tetCost,
                  keyboardType: TextInputType.number,
                  title: "Cost",
                  topTextField: 5),
              commonTextFiledView(
                  topText: 20,
                  keyboardType: TextInputType.multiline,
                  maxLines: 4,
                  validator: (value) {
                    if (value.toString().trim().isEmpty) {
                      return "Please enter description";
                    }

                    return null;
                  },
                  controller: tetDescription,
                  title: "Description",
                  topTextField: 5),
              CommonButtonWidget(
                top: twenty,
                height: 40,
                // padding: isMobile ? null : EdgeInsets.all(25),
                onPressed: () async {
                  final isValid =
                      formProcedureKey.currentState?.validate() ?? false;
                  if (isValid) {
                    String? userID = await getUserID();
                    Map<String, dynamic> body = {
                      "doctorId": userID,
                      "name": tetName.text,
                      "cost": tetCost.text,
                      "description": tetDescription.text,
                    };
                    print('====${body.toString()}');
                    provider
                        .addProcedureCharges(
                      body,
                    )
                        .then((value) {
                      Navigator.of(context).pop();
                    });
                  }

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
        ),
      );
    });
  }
}
