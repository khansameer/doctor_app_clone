import 'package:doctor_app/core/common/common_button_widget.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/app_constants.dart';
import '../../../../core/colors.dart';
import '../../../../core/common/common_text_widget.dart';
import '../../../../core/component/component.dart';
import '../../../../core/responsive.dart';
import '../../../../provider/address_provider.dart';
import '../../../../provider/auth_provider.dart';
import '../../../../provider/model/GetAddressModel.dart';
import '../../../../provider/profile_provider.dart';
import '../../../../service/gloable_status_code.dart';

class EditAddressScreen extends StatefulWidget {
  const EditAddressScreen({
    super.key,
    this.isEdit=false,
    this.address,
  });

  final Addresses? address;
  final bool isEdit;
  @override
  State<EditAddressScreen> createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {


  var tetFullAddress=TextEditingController();
  var tetCity=TextEditingController();
  var tetState=TextEditingController();
  var tetZipCode=TextEditingController();
  var tetCountry=TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(widget.isEdit){
      tetFullAddress.text=widget.address?.address??'';
      tetCity.text=widget.address?.city??'';
      tetState.text=widget.address?.state??'';
      tetZipCode.text=widget.address?.zipCode??'';
    }

  }
  @override
  Widget build(BuildContext context) {
    var isMobile = Responsive.isMobile(context);
    var isDesktop = Responsive.isDesktop(context);
    var isTablet = Responsive.isTablet(context);
    final formEditAddress = GlobalKey<FormState>();
    var width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: isMobile
          ? width * zero9
          : isDesktop
          ? width * 0.3
          : isTablet
          ? width * 0.3
          : width * 0.19,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Form(
          key: formEditAddress,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CommonTextWidget(
                          text:  widget.isEdit?"Edit Address":"Add Address",
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
                    commonTextFiledView(
                      topText: ten,
                      topTextField: 10,
                      title: "Full Address",
                      controller: tetFullAddress,
                      keyboardType: TextInputType.streetAddress,
                      validator: (value) {
                        if (value.toString().trim().isEmpty) {
                          return "Please enter full address";
                        }

                        return null;
                      },

                      hint: "",
                      maxLines: 1,

                    ),
                    commonTextFiledView(
                      title: "City",
                      controller: tetCity,

                      topText: ten,
                      topTextField: 10,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value.toString().trim().isEmpty) {
                          return "Please enter city";
                        }

                        return null;
                      },
                      //text: city,
                    ),
                    commonTextFiledView(
                      hint: "",
                      title: "State",
                      controller: tetState,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value.toString().trim().isEmpty) {
                          return "Please enter state";
                        }

                        return null;
                      },
                      topText: ten,
                      topTextField: 10,

                    ),
                    commonTextFiledView(
                      hint: "",
                      title: "Country",
                      controller: tetCountry,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value.toString().trim().isEmpty) {
                          return "Please enter county";
                        }

                        return null;
                      },
                      topText: ten,
                      topTextField: 10,

                    ),
                    commonTextFiledView(
                      //   text: zipCode,
                      topText: ten,
                      title: "Zip Code",
                      topTextField: 10,
                      controller: tetZipCode,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value.toString().trim().isEmpty) {
                          return "Please enter zip code";
                        }

                        return null;
                      },
                      //keyboardType: TextInputType.number,
                      // decoration: InputDecoration(labelText: 'Zip Code'),

                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CommonButtonWidget(
                          radius: 8,
                          padding: EdgeInsets.only(
                              left: 50, right: 50, top: 15, bottom: 15),
                          height: isMobile ? null : 40,
                          onPressed: () async {

                            final isValid = formEditAddress.currentState?.validate() ?? false;

                            if(isValid){
                              Map<String, dynamic> body = {
                                "address": tetFullAddress.text,
                                "city": tetCity.text,
                                "state": tetState.text,
                                "zipCode": tetZipCode.text,
                                "country": tetCountry.text,

                              };

                              if( widget.isEdit){
                                context
                                    .read<AddressProvider>()
                                    .updateAddress(context: context, body: body,addressID: widget.address?.sId)
                                    .then((value) {
                                  if (globalStatusCode == 200 ||
                                      globalStatusCode == 201) {

                                    Navigator.of(context).pop();
                                  } else {
                                    showCommonDialog(
                                        context: context,
                                        title: "Error",
                                        content: '$errorMessage',
                                        isMessage: true);
                                  }
                                });
                              }
                              else
                              {

                                context
                                    .read<AddressProvider>()
                                    .addAddress(context: context, body: body)
                                    .then((value) {
                                  if (globalStatusCode == 200 ||
                                      globalStatusCode == 201) {

                                    Navigator.of(context).pop();
                                  } else {
                                    showCommonDialog(
                                        context: context,
                                        title: "Error",
                                        content: '$errorMessage',
                                        isMessage: true);
                                  }
                                });
                              }
                              print('==gender====${body.toString()}');
                            }
                            else
                              {
                                formEditAddress.currentState?.save();
                              }




                          },
                          colorButton: AppColors.colorGreen,
                          fontSize: 12,
                          text:  widget.isEdit?"Update":"ADD" ,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        CommonButtonWidget(
                          text: "Cancel",
                          padding: EdgeInsets.only(
                              left: 50, right: 50, top: 15, bottom: 15),
                          radius: 8,
                          height: isMobile ? null : 40,
                          colorBorder: Colors.black,
                          colorButton: Colors.white,
                          colorText: Colors.black,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          fontSize: 12,
                        ),
                      ],
                    )

                    //Divider(),
                  ],
                ),
                context.watch<AddressProvider>().isAdding
                    ? showLoaderList()
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
