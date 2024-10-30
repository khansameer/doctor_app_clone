import 'package:doctor_app/core/color_utils.dart';
import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/LegendItem.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AdminPatientGraph extends StatelessWidget {
  const AdminPatientGraph({super.key});

  @override
  Widget build(BuildContext context) {
    return  PatientsPaceChart();
  }


}


class PatientsPaceChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonTextWidget(text:
            "Patients Treated".toUpperCase(),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
                titlesData: const FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      const FlSpot(0, 1),
                      const FlSpot(1, 1.5),
                      const FlSpot(2, 1.4),
                      const FlSpot(3, 3.4),
                      const FlSpot(4, 2),
                      const FlSpot(5, 2.2),
                      const FlSpot(6, 1.8),
                    ],
                    isCurved: true,
                    color:AppColors.colorLineChart1,
                    barWidth: 4,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                  ),
                  LineChartBarData(
                    spots: [
                      const FlSpot(0, 1.2),
                      const FlSpot(1, 2.8),
                      const FlSpot(2, 1.8),
                      const FlSpot(3, 2.1),
                      const FlSpot(4, 2.5),
                      const FlSpot(5, 3.2),
                      const FlSpot(6, 2.4),
                    ],
                    isCurved: true,
                    color: AppColors.colorLineChart2,
                    barWidth: 4,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10,),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              LegendItem(color: AppColors.colorLineChart1, text: "New Patients"),
              SizedBox(width: 10),
              LegendItem(color:AppColors.colorLineChart2, text: "Returned Patients"),
            ],
          ),
        ],
      ),
    );
  }
}

