import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/common/legend_item.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/dashboard_provider.dart';

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
    final appointments = Provider.of<DashboardProvider>(context).appointments;

    // Group appointments by hour for stacked bars
    Map<int, List<Appointment>> appointmentsByHour = {};
    for (var appointment in appointments) {
      appointmentsByHour
          .putIfAbsent(appointment.hour, () => [])
          .add(appointment);
    }

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
              Flexible(
                child: CommonTextWidget(
                  text: "Daily Appointment".toUpperCase(),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              /*Padding(
                padding: const EdgeInsets.all(0),
                child: CommonTextWidget(
                  text: "Oct 1 - Oct 30".toUpperCase(),
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  textColor: Colors.green.shade300,
                  textAlign: TextAlign.right,
                ),
              )*/
            ],
          ),
          const SizedBox(height: 20),
          const SizedBox(
            height: 10,
          ),
           Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              LegendItem(
                  color: AppColors.colorConsultation,
                  text: "Consultation".toUpperCase()),
              SizedBox(width: 10),
              LegendItem(
                  color: AppColors.colorTest,
                  text: "test".toUpperCase()),
              SizedBox(width: 10),
              LegendItem(
                  color:AppColors.colorCheckup,
                  text: "checkup".toUpperCase()),
              SizedBox(width: 10),
              LegendItem(
                  color:AppColors.colorSick,
                  text: "sick".toUpperCase()),
            ],
          ),
          SizedBox(height: 10,),
          SizedBox(
            height: 400,
            child:
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: StackedBarChart(),
            )
            ,
          ),

        ],
      ),
    );
  }
}


class StackedBarChart extends StatelessWidget {
  const StackedBarChart({super.key});

  @override
  Widget build(BuildContext context) {

    final List<BarDataModel> dummyData = [
      BarDataModel(
        label: "9AM",
        values: [600, 700, 650, 550, 500],
      ),
      BarDataModel(
        label: "10AM",
        values: [300, 400, 350, 250, 200],
      ),
      BarDataModel(
        label: "11AM",
        values: [400, 500, 450, 350, 300],
      ),
      BarDataModel(
        label: "12AM",
        values: [500, 600, 550, 450, 400],
      ),
      BarDataModel(
        label: "1PM",
        values: [600, 700, 650, 550, 500],
      ),
      BarDataModel(
        label: "2PM",
        values: [600, 700, 650, 550, 500],
      ),
      BarDataModel(
        label: "3PM",
        values: [600, 700, 650, 550, 500],
      ),
      BarDataModel(
        label: "4PM",
        values: [600, 700, 650, 550, 500],
      ),
      BarDataModel(
        label: "5PM",
        values: [600, 700, 650, 550, 500],
      ),
    ];
    final barGroups = dummyData.asMap().entries.expand((entry) {
      final index = entry.key;
      final data = entry.value;

      return [
        _buildBarGroup(index , data.values),
      ];
    }).toList();

    return BarChart(
      BarChartData(
        barGroups: barGroups,
        borderData: FlBorderData(
          show: false,
          border: Border.all(color: Colors.grey),
        ),
        backgroundColor: Colors.white,
        alignment: BarChartAlignment.spaceBetween,
        barTouchData: BarTouchData(enabled: false),

        titlesData: FlTitlesData(
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          leftTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                if (value.toInt() >= 0 && value.toInt() < dummyData.length) {
                  return CommonTextWidget(top: 5,
                    fontSize: 12  ,
                    text: dummyData[value.toInt()].label,
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        gridData: FlGridData(show: false),
      ),
    );
  }



  BarChartGroupData _buildBarGroup(int x, List<double> values) {
    double totalHeight = values.reduce((a, b) => a + b); // Total height of the stacked bar

    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(

          toY: totalHeight, // Set total height

          borderSide: BorderSide(
            color: AppColors.colorBgNew
          ),
          borderRadius: BorderRadius.circular(5),
          rodStackItems: List.generate(values.length, (index) {
            double startValue = _getStartValue(values, index);
            double endValue = startValue + values[index];

            return BarChartRodStackItem(
              startValue,  // Start value of the segment
              endValue,    // End value of the segment
              _getColorByIndex(index), // Color of the segment
            );
          }),
          width: 8, // Bar width
        ),
      ],
    );
  }

  double _getStartValue(List<double> values, int index) {
    return values.take(index).fold(0.0, (prev, curr) => prev + curr);
  }


  Color _getColorByIndex(int index) {
    switch (index) {
      case 0:
        return AppColors.colorSick;
      case 1:
        return AppColors.colorConsultation;
      case 2:
        return AppColors.colorTest;
      case 3:
        return AppColors.colorCheckup;
      default:
        return Color.fromRGBO(250, 251, 253,1);
    }
  }
}

// Step 1: Define the dummy model
class BarDataModel {
  final String label; // Label for the x-axis (e.g., dates)
  final List<double> values; // Values for the stack segments

  BarDataModel({required this.label, required this.values});
}


class ChartData{
  ChartData(this.x, this.y1, this.y2, this.y3, this.y4);
  final String x;
  final double y1;
  final double y2;
  final double y3;
  final double y4;
}