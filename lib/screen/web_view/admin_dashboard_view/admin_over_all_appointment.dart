import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/provider/admin_dashboard_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../core/color_utils.dart';

class AdminOverAllAppointment extends StatelessWidget {
  const AdminOverAllAppointment({super.key,required this.provider});
  final AdminDashboardProvider provider;

  @override
  Widget build(BuildContext context) {
    final List<double> listValue = [20, 80,45,90,25,36,85,];
    final List<String> listLabel = ['8:00', '8:30',"9:00","9:30","10:00","10:30","11:00"];

    final PageController pageController = PageController();
    var size = MediaQuery.sizeOf(context);
    return Container(

      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(

          color: colorBGWithOpacity, borderRadius: BorderRadius.circular(8)),
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
                      text: "Overall Appointment".toUpperCase(),
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
                                provider.previousItem();
                                pageController.jumpToPage(provider.currentIndex);
                              },
                              icon: const Icon(
                                Icons.arrow_back_ios_new_outlined,
                                color: Colors.grey,
                                size: 16,
                              )),
                        ),
                       Flexible(child:  IconButton(

                           padding: EdgeInsets.zero,
                           onPressed: () {
                             provider.nextItem(provider.patients.length);
                             pageController.jumpToPage(provider.currentIndex);
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
            child: commonBarchart(barValues: listValue,labels: listLabel),
          ),
        ],
      ),
    );
  }


  commonBarchart({required List<double> barValues,required List<String> labels}){
    return Container(
      margin: const EdgeInsets.all(20),
      child: BarChart(
        BarChartData(
          borderData: FlBorderData(
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
                      textColor: Colors.black, fontSize: 10

                  );
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
                      text: labels[value.toInt()],
                        textColor: Colors.black, fontSize: 10
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
          gridData: const FlGridData(show: true),
          barGroups: List.generate(barValues.length, (index) {
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  width: 30,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(8),topRight: Radius.circular(8)),
                  toY: barValues[index],
                  color: AppColors.primaryLight,
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
