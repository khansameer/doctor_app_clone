import 'dart:convert';

import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/common_button_widget.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/responsive.dart';
import 'package:doctor_app/provider/address_provider.dart';
import 'package:doctor_app/provider/auth_provider.dart';
import 'package:doctor_app/service/gloable_status_code.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/app_constants.dart';
import '../../../../provider/profile_provider.dart';

class AddMyAddressScreen extends StatefulWidget {
  const AddMyAddressScreen({
    super.key,
    required this.isEdit,
  });
  final bool isEdit;
  //final Address? address;

  @override
  State<AddMyAddressScreen> createState() => _AddMyAddressScreenState();
}

class _AddMyAddressScreenState extends State<AddMyAddressScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var provider = context.read<ProfileProvider>();
      provider.getDoctorDetails(context: context).then((value) {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var isMobile = Responsive.isMobile(context);
    var isDesktop = Responsive.isDesktop(context);
    var isTablet = Responsive.isTablet(context);
    final formAddAddress = GlobalKey<FormState>();
    var width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: isMobile
          ? width * zero9
          : isDesktop
              ? width * 0.3
              : isTablet
                  ? width * 0.3
                  : width * 0.19,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Form(
                key: formAddAddress,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CommonTextWidget(
                          text: widget.isEdit ? "Edit Address" : "Add Address",
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
                     Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Consumer<AuthProviders>(
                            builder: (context, provider, child) {
                          return CommonButtonWidget(
                              radius: 8,
                              fontSize: 12,
                              padding: EdgeInsets.only(
                                  left: 40, right: 40, top: 20, bottom: 20),
                              text: "Add More".toUpperCase(),
                              onPressed: () {
                                provider.addAddress();
                              },
                              iconShow: true,
                              icon: const Icon(
                                Icons.add,
                                color: Colors.white,
                              ));
                        })
                      ],
                    ),
                    Consumer<AuthProviders>(builder: (context, provider, child) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: provider.addresses.length,
                        itemBuilder: (context, index) {
                          return AddressInputField(index: index,key: formAddAddress,);
                        },
                      );
                    }),
                
                    //
                    const SizedBox(height: 20),
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


                            var providerProfile =
                                context.read<ProfileProvider>().doctorDetailsModel;
                            List<Map<String, dynamic>> addressesJson =
                                context.read<AuthProviders>().getAddressesInJson();
                            print('${providerProfile?.firstName.toString()}');

                            context.read<AuthProviders>().setSelectedItems(
                                providerProfile!.specializations!
                                    .map((e) => e.sId as String)
                                    .toList());
                            print(
                                "=========${context.read<AuthProviders>().selectedItems}");

                            Map<String, dynamic> body = {
                              "firstName": '${providerProfile.firstName}',
                              "lastName": '${providerProfile.lastName}',
                              "email": '${providerProfile.email}',
                              //"password": provider.tetPassword.text,
                              "dateOfBirth": '${providerProfile.dateOfBirth}',
                              "phoneNumber": '${providerProfile.phoneNumber}',
                              "role": "doctor",
                              "licenseNumber": '${providerProfile.licenseNumber}',
                              "profile": {
                                "qualification": {
                                  "degree":
                                      '${providerProfile.profile?.qualification?[0].degree}',
                                  "year":
                                      '${providerProfile.profile?.qualification?[0].year}',
                                  "institution":
                                      '${providerProfile.profile?.qualification?[0].institution}'
                                },
                                "experience": int.parse(
                                    '${providerProfile.profile?.experience}')
                              },
                              "clinicAddresses": addressesJson,
                              "gender": '${providerProfile.gender}',
                              "specializations":
                                  context.read<AuthProviders>().selectedItems
                            };

                            context
                                .read<AddressProvider>()
                                .addAddress(context: context, body: body)
                                .then((value) {
                              if (globalStatusCode == 200 ||
                                  globalStatusCode == 201) {
                                showCommonDialog(
                                    context: context,
                                    title: "Success",
                                    content: 'Doctor updated successfully',
                                    isMessage: true);
                              } else {
                                showCommonDialog(
                                    context: context,
                                    title: "Error",
                                    content: '$errorMessage',
                                    isMessage: true);
                              }
                            });
                            print('==gender====${body.toString()}');
                          },
                          colorButton: AppColors.colorGreen,
                          fontSize: 12,
                          text: widget.isEdit ? "Update" : "Add",
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
                  ],
                ),
              ),
            ),
          ),
          context.watch<AddressProvider>().isAdding
              ? showLoaderList()
              : const SizedBox.shrink(),
        ],
      ),
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
      child: Form(
        key: key,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            commonTextFiledView(
              topText: ten,
              topTextField: 10,
              title: "Full Address",
              keyboardType: TextInputType.streetAddress,
              validator: (value) {
                if (value.toString().trim().isEmpty) {
                  return "Please enter full address";
                }

                return null;
              },

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
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value.toString().trim().isEmpty) {
                  return "Please enter city";
                }

                return null;
              },
              //text: city,
              onChange: (value) {
                addressProvider.updateAddress(index, 'city', value);
              },
            ),
            commonTextFiledView(
              hint: "",
              title: "State",
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value.toString().trim().isEmpty) {
                  return "Please enter state";
                }

                return null;
              },
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
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value.toString().trim().isEmpty) {
                  return "Please enter zip code";
                }

                return null;
              },
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
      ),
    );
  }
}
