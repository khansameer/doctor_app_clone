import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/provider/admin_dashboard_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/string/string_utils.dart';

class AdminOverAllAppointment extends StatefulWidget {
  const AdminOverAllAppointment({super.key, required this.provider});
  final AdminDashboardProvider provider;

  @override
  State<AdminOverAllAppointment> createState() => _AdminOverAllAppointmentState();
}

class _AdminOverAllAppointmentState extends State<AdminOverAllAppointment> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      DateTime today = DateTime.now();
      DateTime tomorrow = today.add(Duration(days: 7));
      String endDate = DateFormat(yyyMMdd).format(tomorrow);
      context
          .read<AdminDashboardProvider>()
          .getUpComingAppointment(context: context,endDate:endDate )
          .then((value) {});
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final List<double> listValue = [
      20,
      80,
      45,
      90,
      25,
      36,
      85,
    ];
    final List<String> listLabel = [
      'Mon',
      'Tue',
      "Wed",
      "Thu",
      "Fri",
      "Sat",
      "Sun"
    ];

    final PageController pageController = PageController();
    var size = MediaQuery.sizeOf(context);
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                    child: CommonTextWidget(
                  text: "Weekly Appointments".toUpperCase(),
                  fontWeight: FontWeight.w800,
                )),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            widget.provider.previousItem();
                            pageController.jumpToPage(widget.provider.currentIndex);
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios_new_outlined,
                            color: Colors.grey,
                            size: 16,
                          )),
                    ),
                    Flexible(
                        child: IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              widget.provider.nextItem(widget.provider.patients.length);
                              pageController.jumpToPage(widget.provider.currentIndex);
                            },
                            icon: const Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: Colors.grey,
                              size: 16,
                            )))
                  ],
                ))
              ],
            ),
          ),
          SizedBox(
            height: size.height * 0.29,
            child: commonBarchart(barValues: listValue, labels: listLabel),
          ),
        ],
      ),
    );
  }

  commonBarchart(
      {required List<double> barValues, required List<String> labels}) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: BarChart(
        swapAnimationDuration: Duration(milliseconds: 1000), // Optional
        swapAnimationCurve: Curves.linear, // Optional
        BarChartData(

          borderData: FlBorderData(
            show: false,
            border: Border.all(color: Colors.grey),
          ),
          backgroundColor: Colors.white,
          alignment: BarChartAlignment.spaceAround,
          maxY: 100,
          // Adjust to cover all values
          barTouchData: BarTouchData(enabled: false),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) {
                  return CommonTextWidget(
                      text: '${value.toInt()}',
                      textColor: Colors.black,
                      fontSize: 10);
                },
              ),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  if (value.toInt() < labels.length) {
                    return CommonTextWidget(
                        top: 10,
                        text: labels[value.toInt()],
                        fontWeight: FontWeight.w600,
                        textColor: AppColors.colorTextNew,
                        fontSize: 12);
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
          gridData: const FlGridData(
              show: false, drawVerticalLine: false, drawHorizontalLine: false),
          barGroups: List.generate(barValues.length, (index) {
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  width: 25,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                      bottomLeft: Radius.circular(8)),
                  toY: barValues[index],
                  color: Colors.green.shade300,
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
