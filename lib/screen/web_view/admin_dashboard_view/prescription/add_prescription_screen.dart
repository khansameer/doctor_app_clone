import 'package:doctor_app/core/app_constants.dart';
import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/common_button_widget.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/responsive.dart';
import 'package:doctor_app/provider/address_provider.dart';
import 'package:doctor_app/screen/web_view/admin_dashboard_view/my_address/add_my_address_screen.dart';
import 'package:doctor_app/service/gloable_status_code.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:provider/provider.dart';

import '../../../../provider/model/PrescriptionDetailsModel.dart';
import '../../../../provider/prescription_provider.dart';

class AddPrescriptionScreen extends StatefulWidget {
  const AddPrescriptionScreen({super.key, required this.isEdit, this.address});
  final bool isEdit;
  final Medications? address;

  @override
  State<AddPrescriptionScreen> createState() => _AddMyAddressScreenState();
}

class _AddMyAddressScreenState extends State<AddPrescriptionScreen> {
  var tetMedicine = TextEditingController();
  var tetTimesPerDay = TextEditingController();
  var tetDurationValue = TextEditingController();
  var tetDurationUnit = TextEditingController();
  var tetInstructions = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.isEdit) {
      tetMedicine.text = '${widget.address?.name.toString()}';
      tetTimesPerDay.text =
          '${widget.address?.frequency?.timesPerDay.toString()}';
      tetDurationValue.text = '${widget.address?.duration?.value.toString()}';
      tetDurationUnit.text = '${widget.address?.duration?.unit.toString()}';
      tetInstructions.text = '${widget.address?.instructions.toString()}';
    }
  }

  @override
  void dispose() {
    super.dispose();
    resetText();
  }

  resetText() {
    tetInstructions.clear();
    tetDurationUnit.clear();
    tetDurationValue.clear();
    tetTimesPerDay.clear();
    tetMedicine.clear();
    context.read<PrescriptionProvider>().setSelectedDaysTake([]);
  }

  @override
  Widget build(BuildContext context) {
    var isMobile = Responsive.isMobile(context);
    var isDesktop = Responsive.isDesktop(context);
    var isTablet = Responsive.isTablet(context);
    final formPrescription = GlobalKey<FormState>();
    var width = MediaQuery.of(context).size.width;
    final provider = context.read<PrescriptionProvider>();
    var size = MediaQuery.sizeOf(context);
    return SizedBox(
      width: isMobile
          ? width * zero9
          : isDesktop
              ? width * 0.3
              : isTablet
                  ? width * 0.3
                  : width * 0.19,
      child: SingleChildScrollView(
        child: Form(
          key: formPrescription,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CommonTextWidget(
                              text: widget.isEdit
                                  ? "EDIT PRESECRIPTION"
                                  : "ADD PRESECRIPTION",
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
                        const SizedBox(height: 20),
                        commonView(
                          title: "Medicine Name",
                          child: commonTextFiledView(
                            title: "",
                            topText: 0,
                            validator: (value) {
                              if (value.toString().trim().isEmpty) {
                                return "Please enter medicine name";
                              }

                              return null;
                            },
                            borderColor: Colors.grey.withOpacity(0.20),
                            keyboardType: TextInputType.text,
                            controller: tetMedicine,
                            radius: 8,
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        commonView(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            commonTextFiledView(
                              title: "Time Per day",
                              topText: 10,
                              validator: (value) {
                                if (value.toString().trim().isEmpty) {
                                  return "Please enter time per day";
                                }

                                return null;
                              },
                              borderColor: Colors.grey.withOpacity(0.20),
                              keyboardType: TextInputType.number,
                              controller: tetTimesPerDay,
                              topTextField: 10,
                              radius: 8,
                            ),
                            CommonTextWidget(
                              text: "When To Take",
                              top: 10,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            /* MultiSelectDialogField<String>(
                             // initialValue: _selectedDaysTake,
                              initialValue: provider.selectedDaysTake,
                              selectedColor: AppColors.primary,
                              // searchHint: "Select time per day",
                              title: CommonTextWidget(
                                text: "Select when to take",
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
                                    color: Colors.grey.withOpacity(0.20),
                                    width: 1),
                              ),
                              items: provider.whenToTake
                                  .map((e) => MultiSelectItem(e, e))
                                  .toList(),
                              listType: MultiSelectListType.LIST,
                              onConfirm: (selected) {
                              */ /*  setState(() {

                                  provider.setSelectedDaysTake(selected.toList());
                                  print('===length===${selected.length}');
                                 */ /**/ /* _selectedDaysTake = selected.toList();*/ /**/ /*
                                  // _selectedDaysTake = selected.map((e) => e).toList();
                                });*/ /*
                                provider.setSelectedDaysTake(
                                    selected.map((e) => e.toLowerCase()).toList()
                                );

                               // print('===length===${provider.selectedDaysTake}');
                               // provider.setSelectedDaysTake(selected.toList());
                              },
                            ),*/
                            Consumer<PrescriptionProvider>(
                              builder: (context, provider, child) {
                                return MultiSelectDialogField<String>(
                                  initialValue: provider
                                      .selectedDaysTake, // Make sure this matches the provider's current state
                                  selectedColor: AppColors.primary,
                                  title: CommonTextWidget(
                                    text: "Select when to take",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  searchTextStyle:
                                      commonTextStyle(fontSize: 12),
                                  selectedItemsTextStyle: commonTextStyle(
                                      color: Colors.green, fontSize: 12),
                                  itemsTextStyle: commonTextStyle(fontSize: 12),
                                  dialogHeight: size.height * 0.3,
                                  backgroundColor: Colors.white,
                                  checkColor: Colors.white,
                                  dialogWidth: 200,
                                  buttonIcon: const Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    color: Colors.grey,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: Colors.grey.withOpacity(0.20),
                                        width: 1),
                                  ),
                                  items: provider.whenToTake
                                      .map((e) => MultiSelectItem(e, e))
                                      .toList(),
                                  listType: MultiSelectListType.LIST,
                                  onConfirm: (selected) {
                                    provider.setSelectedDaysTake(
                                        selected.map((e) => e).toList());
                                  },
                                );
                              },
                            )
                          ],
                        )),
                        SizedBox(
                          height: 25,
                        ),
                        commonView(
                            title: "Duration",
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                commonTextFiledView(
                                  title: "Duration Value",
                                  topText: 10,
                                  validator: (value) {
                                    if (value.toString().trim().isEmpty) {
                                      return "Please enter duration value";
                                    }

                                    return null;
                                  },
                                  borderColor: Colors.grey.withOpacity(0.20),
                                  keyboardType: TextInputType.number,
                                  controller: tetDurationValue,
                                  topTextField: 10,
                                  radius: 8,
                                ),
                                commonTextFiledView(
                                  title: "Duration Unit",
                                  topText: 10,
                                  validator: (value) {
                                    if (value.toString().trim().isEmpty) {
                                      return "Please enter duration unit";
                                    }

                                    return null;
                                  },
                                  borderColor: Colors.grey.withOpacity(0.20),
                                  keyboardType: TextInputType.text,
                                  controller: tetDurationUnit,
                                  topTextField: 10,
                                  radius: 8,
                                ),
                              ],
                            )),
                        SizedBox(
                          height: 25,
                        ),
                        commonView(
                          title: "Instructions",
                          child: commonTextFiledView(
                            title: "",
                            borderColor: Colors.grey.withOpacity(0.20),
                            topText: 0,
                            controller: tetInstructions,
                            topTextField: 0,
                            maxLines: 3,
                            keyboardType: TextInputType.multiline,
                            radius: 8,
                          ),
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
                                final isValid =
                                    formPrescription.currentState?.validate() ??
                                        false;

                                if (isValid) {
                                  if (provider.selectedDaysTake.isEmpty) {
                                    showCommonDialog(
                                        context: context,
                                        title: "Error",
                                        content: "Please select when to take",
                                        isMessage: true);
                                  } else {
                                    Map<String, dynamic> body = {
                                      "name": tetMedicine.text,
                                      "frequency": {
                                        "timesPerDay":
                                            int.parse(tetTimesPerDay.text),
                                        "whenToTake": provider.selectedDaysTake
                                            .map((item) => item.toLowerCase())
                                            .toList()
                                      },
                                      "duration": {
                                        "value":
                                            int.parse(tetDurationValue.text),
                                        "unit":
                                            tetDurationUnit.text.toLowerCase()
                                      },
                                      "instructions": tetInstructions.text,
                                      "isCommon": true
                                    };

                                    print('====dsdsdsddd===${body.toString()}');
                                    print('=======${body.toString()}');
                                    provider
                                        .addPrescription(
                                            context: context, body: body)
                                        .then((value) {
                                      if (globalStatusCode == 200 ||
                                          globalStatusCode == 201) {
                                        showCommonDialog(
                                            context: context,
                                            title: "Success",
                                            content:
                                                'Prescription added successfully',
                                            isMessage: true);
                                        resetText();
                                      } else {
                                        showCommonDialog(
                                            context: context,
                                            title: "Error",
                                            content: errorMessage ?? '',
                                            isMessage: true);
                                      }
                                    });
                                  }
                                } else {
                                  formPrescription.currentState?.save();
                                }
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
                    context.watch<PrescriptionProvider>().isAdding
                        ? showLoaderList()
                        : SizedBox.shrink()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  commonView({String? title, Widget? child, double? padding}) {
    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Container(
          width: double.infinity,
          // height: 200,
          //  margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
          padding: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.withOpacity(0.50), width: 1),
            borderRadius: BorderRadius.circular(8),
            shape: BoxShape.rectangle,
          ),
          child: Padding(
            padding: EdgeInsets.all(padding ?? 10.0),
            child: child,
          ),
        ),
        Positioned(
          left: 10,
          top: -10,
          child: Container(
            padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
            color: Colors.white,
            child: CommonTextWidget(
              text: title ?? 'Frequency',
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
