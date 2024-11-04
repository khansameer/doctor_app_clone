import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/common_button_widget.dart';
import 'package:doctor_app/core/common/common_drop_down_view.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/common/common_textfield.dart';
import 'package:doctor_app/core/responsive.dart';
import 'package:doctor_app/provider/report_provier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminWebReport extends StatelessWidget {
  const AdminWebReport({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    var isMobile = Responsive.isMobile(context);

    return Consumer<ReportProvider>(builder: (context, provider, child) {
      return SizedBox(
        width: size.width,
        height: size.height,
        child: ListView(
          children: [
            CommonTextWidget(
              letterSpacing: 1,
              text: "Reports",
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _topView(size: size, provider: provider, isMobile: isMobile),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: size.width,
                    padding: const EdgeInsets.all(10),
                    color: AppColors.colorBgNew,
                    child: CommonTextWidget(
                      text: "Summary",
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  isMobile
                      ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: _commonSummaryView(),
                                ),
                                Expanded(
                                  child: _commonSummaryView(
                                      title: "Discount",
                                      price: "\$1,72,300.00"),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: _commonSummaryView(
                                        title: "Income after Discount",
                                        price: "\$30,48,130.00")),
                                Expanded(
                                  child: _commonSummaryView(
                                      title: "Tax", price: '\$0.00'),
                                )
                              ],
                            ),
                            _commonSummaryView(
                                title: "Invoice Amount",
                                price: "\$30,48,130.00")
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: _commonSummaryView(),
                            ),
                            Expanded(
                              child: _commonSummaryView(
                                  title: "Discount", price: "\$1,72,300.00"),
                            ),
                            Expanded(
                              child: _commonSummaryView(
                                  title: "Income after Discount",
                                  price: "\$30,48,130.00"),
                            ),
                            Expanded(
                              child: _commonSummaryView(
                                  title: "Tax", price: '\$0.00'),
                            ),
                            Expanded(
                              child: _commonSummaryView(
                                  title: "Invoice Amount",
                                  price: "\$30,48,130.00"),
                            ),
                          ],
                        ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: size.width,
                    padding: const EdgeInsets.all(10),
                    color: AppColors.colorBgNew,
                    child: CommonTextWidget(
                      text: "Details",
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    width: size.width,
                    child: SingleChildScrollView(
                      scrollDirection: isMobile?Axis.horizontal:Axis.vertical,
                      child: DataTable(
                        columns: [
                          DataColumn(
                            label: Expanded(
                              child: CommonTextWidget(
                                  textColor: Colors.grey, text: 'S.No.'),
                            ),
                          ),
                          DataColumn(
                              label:Expanded(child:   CommonTextWidget(
                                  textColor: Colors.grey, text: 'Date'))),
                          DataColumn(
                              label: Expanded(child: CommonTextWidget(
                                  textColor: Colors.grey,
                                  text: 'Invoice Number'))),
                          DataColumn(
                              label: Expanded(child: CommonTextWidget(
                                  textColor: Colors.grey, text: 'Patient'))),
                          DataColumn(
                              label: Expanded(child: CommonTextWidget(
                                  textColor: Colors.grey,
                                  text: 'Treatments & Product'))),
                        ],
                        rows: provider.data.map((item) {
                          return DataRow(cells: [
                            DataCell(CommonTextWidget(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                text: item['S.No.'].toString())),
                            DataCell(CommonTextWidget(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                text: item['Date'])),
                            DataCell(CommonTextWidget(
                              text: item['Invoice Number'],
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              textColor: AppColors.colorBlue,
                            )),
                            DataCell(CommonTextWidget(
                              text: item['Patient'],
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              textColor: AppColors.colorBlue,
                            )),
                            DataCell(CommonTextWidget(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                text: item['Treatments & Product'])),
                          ]);
                        }).toList(),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  _topView(
      {required Size size,
      required ReportProvider provider,
      required bool isMobile}) {
    return isMobile
        ? Column(
            children: [
              Row(
                children: [
                  CommonTextWidget(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    text: "Select Reports Category",
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: SizedBox(
                      width: size.width,
                      child: commonDropDown(provider: provider, size: size),
                    ),
                  )
                ],
              ),
            ],
          )
        : Row(
            children: [
              Expanded(
                flex: 6,
                child: Row(
                  children: [
                    CommonTextWidget(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      text: "Select Reports Category",
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: size.width * 0.15,
                      child: commonDropDown(size: size, provider: provider),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CommonTextWidget(
                      text: "From",
                      left: 10,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      right: 10,
                    ),
                    CommonTextField(
                      width: size.width * 0.10,
                      height: 40,
                      isReadOnly: true,
                      suffixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            size: 20,
                            Icons.calendar_month_sharp,
                            color: Colors.grey,
                          )),
                      radius: 8,
                      borderColor: Colors.grey.withOpacity(0.4),
                      colorFill: Colors.white,
                    ),
                    CommonTextWidget(
                      right: 10,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      text: "TO",
                      left: 10,
                    ),
                    CommonTextField(
                      height: 40,
                      isReadOnly: true,
                      width: size.width * 0.10,
                      radius: 8,
                      suffixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            size: 20,
                            Icons.calendar_month_sharp,
                            color: Colors.grey,
                          )),
                      borderColor: Colors.grey.withOpacity(0.4),
                      colorFill: Colors.white,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    CommonButtonWidget(
                      text: "Mail",
                      colorText: AppColors.colorTextNew,
                      height: 40,
                      fontSize: 13,
                      colorBorder: Colors.grey.withOpacity(0.4),
                      colorButton: Colors.white,
                    )
                  ],
                ),
              )
            ],
          );
  }

  commonDropDown({required ReportProvider provider, required Size size}) {
    return CommonDropDownView(
        horizontal: 10,
        hint: "Income",
        borerColor: Colors.grey.withOpacity(0.4),
        selectedValue: provider.selectedValue,
        onChanged: (value) {
          provider.setSelectData = value.toString();
        },
        size: size,
        items: provider.patientReportCategories
            .map((category) => category['title'] as String)
            .toList());
  }

  _commonSummaryView({String? title, String? price}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonTextWidget(
          top: 20,
          fontSize: 13,
          textColor: Colors.grey,
          text: title ?? "Cost",
        ),
        CommonTextWidget(
          top: 5,
          fontWeight: FontWeight.w600,
          text: price ?? "\$32,45,430.00",
        )
      ],
    );
  }
}
