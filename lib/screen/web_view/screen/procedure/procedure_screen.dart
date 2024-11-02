import 'package:doctor_app/core/common/custom_alert_dialog.dart';
import 'package:doctor_app/core/common/app_scaffold.dart';
import 'package:doctor_app/core/common/common_button_widget.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/responsive.dart';
import 'package:doctor_app/provider/procedure_provider.dart';
import 'package:doctor_app/screen/web_view/screen/procedure_charges_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/procedure_model.dart';

class ProcedureScreen extends StatefulWidget {
  const ProcedureScreen({super.key});

  @override
  State<ProcedureScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<ProcedureScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<ProcedureProvider>()
          .getProcedureCharges(context: context)
          .then((value) {
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    var isMobile = Responsive.isMobile(context);
    var provider = context.watch<ProcedureProvider>();
    return AppScaffold(
      appBar: isMobile
          ? commonAppBar(title: "Procedure Catalog".toUpperCase(), actions: [
              IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        var width = MediaQuery.of(context).size.width;

                        return CustomAlertDialog(
                          content: SizedBox(
                              //  height: isMobile ? height * 0.4 : height * 0.7,
                              width: isMobile ? width * 0.9 : width * 0.3,
                              child: const ProcedureChargesScreen()),
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.add))
            ])
          : PreferredSize(preferredSize: Size.zero, child: Container()),
      child: Container(
        width: size.width,
        height: size.height,
        color: Colors.white,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 10,
                ),
                isMobile
                    ? const SizedBox.shrink()
                    : Align(
                        alignment: Alignment.topRight,
                        child: CommonButtonWidget(
                          fontSize: 12,
                          right: 10,
                          radius: 8,
                          borderWidth: 1,
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                var width = MediaQuery.of(context).size.width;

                                return CustomAlertDialog(
                                  content: SizedBox(
                                      //  height: isMobile ? height * 0.4 : height * 0.7,
                                      width:
                                          isMobile ? width * 0.9 : width * 0.3,
                                      child: const ProcedureChargesScreen()),
                                );
                              },
                            );
                          },
                          colorButton: Colors.white,
                          colorBorder: Colors.black,
                          colorText: Colors.black,
                          padding: EdgeInsets.zero,
                          width: isMobile ? size.width * 0.3 : size.width * 0.1,
                          text: "Add Procedure",
                        ),
                      ),
                provider.procedureList == null || provider.procedureList.isEmpty
                    ? const Text("")
                    : Theme(
                        data: Theme.of(context).copyWith(
                          cardColor: Colors.white,
                          cardTheme: const CardTheme(
                            color: Colors.white,
                            elevation: 0,
                            margin: EdgeInsets.zero,
                          ),
                          dataTableTheme: DataTableThemeData(
                            headingRowColor:
                                WidgetStateProperty.resolveWith<Color>(
                                    (Set<WidgetState> states) {
                              // Set color for heading row
                              //  return Colors.blueGrey[200]!; // example color
                              return const Color.fromRGBO(
                                  48, 180, 128, 1); // example color
                            }),
                            dataRowColor:
                                WidgetStateProperty.resolveWith<Color>(
                                    (Set<WidgetState> states) {
                              // Set color for data rows
                              // return Colors.grey[200]!; // example color

                              return const Color.fromARGB(
                                  255, 240, 242, 241); // example color
                            }),
                            // Add other customizations here
                          ),
                        ),
                        child: Container(
                          color: Colors.white,
                          width: size.width,
                          padding: EdgeInsets.zero,
                          child: PaginatedDataTable(
                            header: isMobile
                                ? const SizedBox.shrink()
                                : CommonTextWidget(
                                    // text: 'Invoice Items',
                                    text: 'Procedure Catalog',
                                    fontWeight: FontWeight.w600,
                                  ),
                            columns: [
                              DataColumn(
                                  label: CommonTextWidget(
                                text: 'Procedure',
                                fontSize: 12,
                                textColor: Colors.white,
                                fontWeight: FontWeight.w700,
                              )),
                              DataColumn(
                                  label: CommonTextWidget(
                                text: 'Cost',
                                textColor: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              )),
                              DataColumn(
                                  label: CommonTextWidget(
                                fontSize: 12,
                                text: 'Discount',
                                textColor: Colors.white,
                                fontWeight: FontWeight.w700,
                              )),
                              DataColumn(
                                  label: CommonTextWidget(
                                text: 'Note',
                                fontSize: 12,
                                textColor: Colors.white,
                                fontWeight: FontWeight.w700,
                              )),
                              DataColumn(
                                  label: CommonTextWidget(
                                text: 'Total',
                                fontSize: 12,
                                textColor: Colors.white,
                                fontWeight: FontWeight.w700,
                              )),
                              DataColumn(
                                numeric: true,
                                label: CommonTextWidget(
                                  text: 'Action',
                                  fontSize: 12,
                                  textColor: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                            source: MyData(
                                procedureList: provider.procedureList,
                                context: context,
                                provider: provider),
                            rowsPerPage: (provider.procedureList.isNotEmpty)
                                ? provider.procedureList.length
                                : 1,
                          ),
                        ),
                      ),
              ],
            ),
            provider.isLoading || provider.isDelete
                ? showLoaderList()
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}

class MyData extends DataTableSource {
  MyData({this.procedureList, required this.context, required this.provider});

  List<ProcedureModel>? procedureList;
  BuildContext context;
  ProcedureProvider provider;
  @override
  DataRow? getRow(int index) {
    assert(index >= 0);

    final user = procedureList?[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(CommonTextWidget(fontSize: 12, text: user?.name.toString())),
        DataCell(CommonTextWidget(fontSize: 12, text: user?.cost.toString())),
        DataCell(CommonTextWidget(fontSize: 12, text: '')),
        DataCell(
            CommonTextWidget(fontSize: 12, text: user?.description.toString())),
        DataCell(
            CommonTextWidget(fontSize: 12, text: user?.description.toString())),
        DataCell(buildPopupMenu(
            context: context,
            provider: provider,
            id: '${user?.sId.toString()}')),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => procedureList != null ? procedureList!.length : 1;

  @override
  int get selectedRowCount => 0;
}

Widget buildPopupMenu(
    {required BuildContext context,
    required ProcedureProvider provider,
    String? id}) {
  return PopupMenuButton<String>(
    color: Colors.white,
    onSelected: (String value) {
      // Handle the selected option
      if (value == 'edit') {
        // Handle Active logic
      } else if (value == 'delete') {
        if (kDebugMode) {
          print('======onClickDelete');
        }
        provider.deleteProcedureCharges(context: context, id: id.toString());
      }
    },
    itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
      const PopupMenuItem<String>(
        value: 'edit',
        child: Text('Edit'),
      ),
      const PopupMenuItem<String>(
        value: 'delete',
        child: Text('Delete'),
      ),
    ],
    child: const Icon(
      Icons.more_vert,
      color: Colors.grey,
    ), // Icon to trigger the pop-up menu
  );
}
