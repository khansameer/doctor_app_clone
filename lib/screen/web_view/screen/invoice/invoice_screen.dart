import 'package:doctor_app/core/common/CustomAlertDialog.dart';
import 'package:doctor_app/core/common/app_scaffold.dart';
import 'package:doctor_app/core/common/common_button_widget.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/responsive.dart';
import 'package:doctor_app/provider/procedure_provider.dart';
import 'package:doctor_app/screen/web_view/screen/procedure_charges_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InvoiceScreen extends StatefulWidget {
  InvoiceScreen({super.key});

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  final DataTableSource _data = MyData();

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
                  icon: Icon(Icons.add))
            ])
          : PreferredSize(preferredSize: Size.zero, child: Container()),
      child: Container(
        width: size.width,
        height: size.height,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 10,
            ),
            isMobile
                ? SizedBox.shrink()
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
                                  width: isMobile ? width * 0.9 : width * 0.3,
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
            Theme(
              data: Theme.of(context).copyWith(
                cardColor: Colors.white,
                cardTheme: const CardTheme(
                  color: Colors.white,
                  elevation: 0,
                  margin: EdgeInsets.zero,
                ),
                dataTableTheme: DataTableThemeData(
                  headingRowColor: WidgetStateProperty.resolveWith<Color>(
                      (Set<WidgetState> states) {
                    // Set color for heading row
                    //  return Colors.blueGrey[200]!; // example color
                    return const Color.fromRGBO(
                        48, 180, 128, 1); // example color
                  }),
                  dataRowColor: WidgetStateProperty.resolveWith<Color>(
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
                      ? SizedBox.shrink()
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
                  source: _data,
                  rowsPerPage: 5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyData extends DataTableSource {
  final List<Map<String, dynamic>> _data = [
    {
      "name": "Diagnostic Procedures",
      "cost": "500",
      "discount": "0",
      "total": "500",
      "note": "",
    },
    {
      "name": "Surgical Procedures",
      "cost": "500",
      "discount": "0",
      "total": "500",
      "note": "",
    },
    {
      "name": "Therapeutic Procedures",
      "cost": "600",
      "discount": "0",
      "total": "600",
      "note": "",
    },
    {
      "name": "Preventive Procedures",
      "cost": "900",
      "discount": "0",
      "total": "900",
      "note": "",
    },
    {
      "name": "Minimally Invasive Procedures",
      "cost": "800",
      "discount": "0",
      "total": "800",
      "note": "",
    },
  ];

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= _data.length) return null;
    final user = _data[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(CommonTextWidget(fontSize: 12, text: user['name'])),
        DataCell(CommonTextWidget(fontSize: 12, text: user['cost'])),
        DataCell(CommonTextWidget(fontSize: 12, text: user['discount'])),
        DataCell(CommonTextWidget(fontSize: 12, text: user['note'])),
        DataCell(CommonTextWidget(fontSize: 12, text: user['total'])),
        DataCell(buildPopupMenu()),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _data.length;

  @override
  int get selectedRowCount => 0;
}
