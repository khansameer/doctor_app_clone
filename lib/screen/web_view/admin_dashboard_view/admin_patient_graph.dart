import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/common/legend_item.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AdminPatientGraph extends StatelessWidget {
  const AdminPatientGraph({super.key});

  @override
  Widget build(BuildContext context) {
    return const PatientsPaceChart();
  }
}

class PatientsPaceChart extends StatelessWidget {
  const PatientsPaceChart({super.key});

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonTextWidget(
                text: "Patients Treated".toUpperCase(),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(680, 0, 0, 0),
                child: CommonTextWidget(
                  text: "Oct 1 - Oct 30".toUpperCase(),
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  textColor: Colors.green.shade300,
                  textAlign: TextAlign.right,
                ),
              )
            ],
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
                    color: const Color.fromARGB(255, 33, 211, 80),
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
                    color: const Color.fromARGB(255, 230, 211, 45),
                    barWidth: 4,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              LegendItem(
                  color: Color.fromARGB(255, 33, 211, 74),
                  text: "New Patients"),
              SizedBox(width: 10),
              LegendItem(
                  color: Color.fromARGB(255, 209, 231, 41),
                  text: "Existing Patients"),
            ],
          ),
        ],
      ),
    );
  }
}
