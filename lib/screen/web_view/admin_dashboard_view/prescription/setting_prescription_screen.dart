import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/common_button_widget.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/common/custom_alert_dialog.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/context_extension.dart';
import 'package:doctor_app/provider/prescription_provider.dart';

import 'package:doctor_app/screen/web_view/admin_dashboard_view/prescription/add_prescription_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingPrescriptionScreen extends StatefulWidget {
  const SettingPrescriptionScreen({super.key});

  @override
  State<SettingPrescriptionScreen> createState() =>
      _SettingPrescriptionScreenState();
}

class _SettingPrescriptionScreenState extends State<SettingPrescriptionScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<PrescriptionProvider>()
          .getPrescription(
            context: context,
          )
          .then((value) {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);

    return SizedBox(
      width: size.width,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ListView(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CommonTextWidget(
                                    text: "Prescription",
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CommonButtonWidget(
                                      fontSize: 12,
                                      iconShow: true,
                                      icon: Container(
                                        margin: EdgeInsets.only(right: 5),
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        ),
                                      ),
                                      radius: 8,
                                      onPressed: () {
                                        showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (BuildContext context) {
                                            return CustomAlertDialog(
                                              content: AddPrescriptionScreen(
                                                isEdit: false,
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      padding: EdgeInsets.only(
                                          left: 40,
                                          right: 40,
                                          top: 20,
                                          bottom: 20),
                                      text: "ADD Prescription",
                                    ),
                                  ],
                                )
                              ],
                            ))
                          ],
                        ),
                      ),
                      Consumer<PrescriptionProvider>(
                          builder: (context, provider, child) {
                        return Container(
                          width: size.width,
                          padding: const EdgeInsets.all(0.0),
                          child: DataTable(
                            dividerThickness: 0.3,
                            border: TableBorder.all(
                              width: 1.0,
                              color: AppColors.colorBgNew,
                            ),
                            columns: [
                              DataColumn(
                                  label: CommonTextWidget(
                                text: 'Medicine',
                                fontWeight: FontWeight.w900,
                              )),
                              DataColumn(
                                  label: CommonTextWidget(
                                text: 'Frequency',
                                fontWeight: FontWeight.w900,
                              )),
                              DataColumn(
                                  label: CommonTextWidget(
                                text: 'Duration',
                                fontWeight: FontWeight.w900,
                              )),
                              DataColumn(
                                  label: CommonTextWidget(
                                text: 'Instructions',
                                fontWeight: FontWeight.w900,
                              )),
                              DataColumn(
                                  numeric: true,
                                  label: CommonTextWidget(
                                    text: 'Action',
                                    fontWeight: FontWeight.w900,
                                  )),
                            ],
                            rows: (provider.prescriptionDetailsModel
                                        ?.medications ??
                                    [])
                                .where((prescription) => prescription != null)
                                .map(
                                  (prescription) => DataRow(
                                    cells: [
                                      DataCell(CommonTextWidget(
                                        text: prescription.name
                                            .toString()
                                            .toCapitalize(),
                                        fontSize: 12,
                                      )),
                                      DataCell(CommonTextWidget(
                                        text:
                                            '${prescription.frequency?.timesPerDay?.toString() ?? 'N/A'}  ${prescription.frequency?.whenToTake?.map((e) => e.toString().toCapitalize())}',
                                        fontSize: 12,
                                      )),
                                      DataCell(CommonTextWidget(
                                        text:
                                            '${prescription.duration?.value?.toString() ?? 'N/A'} ${prescription.duration?.unit?.toString() ?? 'N/A'}',
                                        fontSize: 12,
                                      )),
                                      DataCell(CommonTextWidget(
                                        text: prescription.instructions
                                            .toString()
                                            .toCapitalize(),
                                        fontSize: 12,
                                      )),
                                      DataCell(Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            commonInkWell(
                                              onTap: () {
                                                showDialog(
                                                  barrierDismissible: false,
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return CustomAlertDialog(
                                                      content:
                                                          AddPrescriptionScreen(
                                                        isEdit: true,
                                                        address: prescription,
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                              child: Container(
                                                margin:
                                                    EdgeInsets.only(right: 10),
                                                child: Icon(
                                                  Icons.edit_outlined,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                            commonInkWell(
                                              onTap: () {
                                                showCommonDialog(
                                                    context: context,
                                                    title: "Delete",
                                                    btnNegative: "No",
                                                    btnPositive: "Delete",
                                                    onPressPositive: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                      provider
                                                          .deletePrescription(
                                                              context: context,
                                                              id: prescription
                                                                  .sId
                                                                  .toString());
                                                    },
                                                    onPressNegative: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    content:
                                                        "Are you sure want to delete record?",
                                                    isMessage: false);
                                              },
                                              child: Container(
                                                margin:
                                                    EdgeInsets.only(right: 10),
                                                child: Icon(
                                                  Icons.delete_outline,
                                                  color: Colors.red
                                                      .withOpacity(0.70),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )),
                                    ],
                                  ),
                                )
                                .toList(),
                          ),
                        );
                      })
                    ],
                  ),
                ],
              ),
            ],
          ),
          Center(
            child: context.watch<PrescriptionProvider>().isFetching ||
                    context.watch<PrescriptionProvider>().isAdding
                ? showLoaderList()
                : SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
