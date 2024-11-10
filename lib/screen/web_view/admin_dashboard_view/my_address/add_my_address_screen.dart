import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/common_button_widget.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/responsive.dart';
import 'package:doctor_app/provider/address_provider.dart';
import 'package:doctor_app/provider/auth_provider.dart';

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
  var tetLine1 = TextEditingController();
  var tetLine2 = TextEditingController();
  var tetPhone = TextEditingController();
  var tetCity = TextEditingController();
  var tetState = TextEditingController();
  var tetZipCode = TextEditingController();
  var tetCountry = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var provider = context.read<ProfileProvider>();
      provider.getUserDetails(context: context).then((value) {
        if (provider.userDetailsModel?.user?.sId != null) {
          var data = provider.userDetailsModel?.user;
        }
        /*if (widget.isEdit) {
          tetLine1.text = '${widget.address?.address1.toString()}';
          tetLine2.text = '${widget.address?.address2.toString()}';
          tetPhone.text = '${widget.address?.phoneNumber.toString()}';
          tetCity.text = '${widget.address?.city.toString()}';
          tetState.text = '${widget.address?.state.toString()}';
          tetZipCode.text = '${widget.address?.zipcode.toString()}';
          tetCountry.text = '${widget.address?.country.toString()}';
        }*/
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var isMobile = Responsive.isMobile(context);
    var isDesktop = Responsive.isDesktop(context);
    var isTablet = Responsive.isTablet(context);

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
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CommonTextWidget(
                              text: widget.isEdit
                                  ? "Edit Address"
                                  : "Add Address",
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
                        Consumer<AuthProviders>(
                            builder: (context, provider, child) {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: provider.addresses.length,
                            itemBuilder: (context, index) {
                              return AddressInputField(index: index);
                            },
                          );
                        }),
                        const SizedBox(height: 20),
                        /*commonTextFiledView(
                            radius: 8,
                            topText: 10,
                            maxLines: 3,
                            keyboardType: TextInputType.multiline,
                            fontSize: 14,
                            controller: tetLine1,
                            topTextField: 10,
                            title: "Address Line 1"),
                        commonTextFiledView(
                            topText: 10,
                            maxLines: 3,
                            fontSize: 14,
                            keyboardType: TextInputType.multiline,
                            controller: tetLine2,
                            topTextField: 10,
                            radius: 8,
                            title: "Address Line 1"),
                        commonTextFiledView(
                          title: "Phone Number",
                          topText: 10,
                          maxLines: 3,
                          keyboardType: TextInputType.phone,
                          controller: tetPhone,
                          topTextField: 10,
                          height: 45,
                          radius: 8,
                        ),
                        commonTextFiledView(
                          title: "City",
                          topText: 10,
                          maxLines: 3,
                          keyboardType: TextInputType.text,
                          controller: tetCity,
                          topTextField: 10,
                          height: 45,
                          radius: 8,
                        ),
                        commonTextFiledView(
                          title: "State",
                          topText: 10,
                          maxLines: 3,
                          keyboardType: TextInputType.text,
                          controller: tetState,
                          topTextField: 10,
                          height: 45,
                          radius: 8,
                        ),
                        commonTextFiledView(
                          title: "Country",
                          topText: 10,
                          maxLines: 3,
                          keyboardType: TextInputType.text,
                          controller: tetCountry,
                          topTextField: 10,
                          height: 45,
                          radius: 8,
                        ),
                        commonTextFiledView(
                          title: "Zip Code",
                          topText: 10,
                          maxLines: 3,
                          keyboardType: TextInputType.number,
                          controller: tetZipCode,
                          topTextField: 10,
                          height: 45,
                          radius: 8,
                        ),*/
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
                                var providerProfile = context
                                    .read<ProfileProvider>()
                                    .userDetailsModel;
                                List<Map<String, dynamic>> addressesJson =
                                    context
                                        .read<AuthProviders>()
                                        .getAddressesInJson();
                                print('${providerProfile?.user?.firstName}');
                                Map<String, dynamic> body = {
                                  "firstName":
                                      '${providerProfile?.user?.firstName}',
                                  "lastName":
                                      '${providerProfile?.user?.lastName}',
                                  "email": '${providerProfile?.user?.email}',
                                  //"password": provider.tetPassword.text,
                                  "dateOfBirth":
                                      '${providerProfile?.user?.dateOfBirth}',
                                  "phoneNumber":
                                      '${providerProfile?.user?.phoneNumber}',
                                  "role": "doctor",
                                  // "licenseNumber": '${providerProfile?.user?.firstName}',
                                  /*"profile": {
                                    "qualification": {
                                      "degree": tetDegree.text,
                                      "year": tetYear.text,
                                      "institution": tetInstitution.text
                                    },
                                    "experience": int.parse(tetExperience.text)
                                  },*/
                                  "clinicAddresses": addressesJson,
                                  "gender": '${providerProfile?.user?.gender}',
                                  // "specializations": provider.selectedItems,
                                  // "clinicAddresses": addressesJson
                                };

                                context
                                    .read<AddressProvider>()
                                    .addAddress(context: context, body: body);
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
                  /*context.watch<AppointmentsProvider>().isAdding
                      ? showLoaderList()
                      : const SizedBox.shrink()*/
                ],
              ),
            ],
          ),
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
