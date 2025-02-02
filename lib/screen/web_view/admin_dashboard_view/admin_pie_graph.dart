
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/provider/dashboard_provider.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class AdminPieGraph extends StatelessWidget {
  const AdminPieGraph({super.key});

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

    Map<int, List<Appointment>> appointmentsByHour = {};
    for (var appointment in appointments) {
      appointmentsByHour
          .putIfAbsent(appointment.hour, () => [])
          .add(appointment);
    }

    DateTime currentDate = DateTime.now();
    DateTime tenDaysBefore = currentDate.subtract(Duration(days: 10));
    DateTime tenDaysAfter = currentDate.add(Duration(days: 10));

    String formattedBeforeDate = DateFormat('MMM d').format(tenDaysBefore);
    String formattedAfterDate = DateFormat('MMM d').format(tenDaysAfter);
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: CommonTextWidget(
                  text: "patient Dirstribution".toUpperCase(),
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: CommonTextWidget(
                  right: 5,
                  fontSize: 12,
                  text: "$formattedBeforeDate - $formattedAfterDate"
                      .toUpperCase(),
                  textColor: Colors.green.shade300,
                  fontWeight: FontWeight.w800,
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Container(child: DoughnutChartExample())
        ],
      ),
    );
  }
}

class DoughnutChartExample extends StatelessWidget {
  // Sample data for the chart
  final List<ChartData> chartData = [
    ChartData('Existing Patient', 60, Colors.yellow),
    ChartData('New Patient', 40, Colors.green),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Stack(
          alignment: Alignment.center,
          fit: StackFit.loose,
          children: [
            SfCircularChart(
              series: <CircularSeries>[
                DoughnutSeries<ChartData, String>(
                  dataSource: chartData,
                  xValueMapper: (ChartData data, _) => data.category,
                  yValueMapper: (ChartData data, _) => data.amount,
                  pointColorMapper: (ChartData data, _) => data.color,
                  animationDelay: 0,
                  enableTooltip: true,
                  cornerStyle: CornerStyle.bothFlat,
                  legendIconType: LegendIconType.circle,
                  dataLabelSettings: DataLabelSettings(isVisible: true),
                  radius: '70%',
                  innerRadius: '60%',
                ),
              ],
            ),
            // Center text in the middle of the doughnut
            Text(
              '30kUSD',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        Column(
          children: [
            Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                      color: Colors.green, shape: BoxShape.circle),
                ),
                SizedBox(width: 5),
                Text("New Patient"),
              ],
            ),
            SizedBox(width: 20),
            Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                      color: Colors.yellow, shape: BoxShape.circle),
                ),
                SizedBox(width: 5),
                Text("Existing Patient"),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

// Data model for the chart
class ChartData {
  final String category;
  final double amount;
  final Color color;

  ChartData(this.category, this.amount, this.color);
}
