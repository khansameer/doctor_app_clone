import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/common/legend_item.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

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
mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: CommonTextWidget(
                  text: "patient demographics".toUpperCase(),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(0),
                child: CommonTextWidget(
                  text: "Oct 1 - Oct 30".toUpperCase(),
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  textColor: Colors.black,
                  textAlign: TextAlign.right,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            child: WorldMap()
          )
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
        _buildBarGroup(index, data.values),
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
                  return CommonTextWidget(
                    top: 5,
                    fontSize: 12,
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
    double totalHeight =
        values.reduce((a, b) => a + b); // Total height of the stacked bar

    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: totalHeight,
          // Set total height

          borderSide: BorderSide(color: AppColors.colorBgNew),
          borderRadius: BorderRadius.circular(5),
          rodStackItems: List.generate(values.length, (index) {
            double startValue = _getStartValue(values, index);
            double endValue = startValue + values[index];

            return BarChartRodStackItem(
              startValue, // Start value of the segment
              endValue, // End value of the segment
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
        return Color.fromRGBO(250, 251, 253, 1);
    }
  }
}

// Step 1: Define the dummy model
class BarDataModel {
  final String label; // Label for the x-axis (e.g., dates)
  final List<double> values; // Values for the stack segments

  BarDataModel({required this.label, required this.values});
}

class ChartData {
  ChartData(this.x, this.y1, this.y2, this.y3, this.y4);

  final String x;
  final double y1;
  final double y2;
  final double y3;
  final double y4;
}

class MapChart extends StatefulWidget {
  const MapChart({super.key});

  @override
  State<MapChart> createState() => _MapChartState();
}

class _MapChartState extends State<MapChart> {
  late List<Model> _data;
  late MapShapeSource _mapSource;

  @override
  void initState() {
    _data = const <Model>[
      Model('New South Wales', Color.fromRGBO(255, 215, 0, 1.0),
          '       New\nSouth Wales'),
      Model('Queensland', Color.fromRGBO(72, 209, 204, 1.0), 'Queensland'),
      Model('Northern Territory', Color.fromRGBO(255, 78, 66, 1.0),
          'Northern\nTerritory'),
      Model('Victoria', Color.fromRGBO(171, 56, 224, 0.75), 'Victoria'),
      Model('South Australia', Color.fromRGBO(126, 247, 74, 0.75),
          'South Australia'),
      Model('Western Australia', Color.fromRGBO(79, 60, 201, 0.7),
          'Western Australia'),
      Model('India', Color.fromRGBO(99, 164, 230, 1), 'India'),
      Model('Australian Capital Territory', Colors.teal, 'ACT')
    ];

    _mapSource = MapShapeSource.asset(
      'assets/world_map.json',
      shapeDataField: 'STATE_NAME',
      dataCount: _data.length,
      primaryValueMapper: (int index) => _data[index].state,
      dataLabelMapper: (int index) => _data[index].stateCode,
      shapeColorValueMapper: (int index) => _data[index].color,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 520,
      child: Center(
        child: SfMaps(
          layers: <MapShapeLayer>[
            MapShapeLayer(
              source: _mapSource,
              showDataLabels: true,
              legend: const MapLegend(MapElement.shape),
              tooltipSettings: MapTooltipSettings(
                  color: Colors.grey[700],
                  strokeColor: Colors.white,
                  strokeWidth: 2),
              strokeColor: Colors.white,
              strokeWidth: 0.5,
              shapeTooltipBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _data[index].stateCode,
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              },
              dataLabelSettings: MapDataLabelSettings(
                textStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: Theme.of(context).textTheme.bodySmall!.fontSize),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Model {
  /// Initialize the instance of the [Model] class.
  const Model(this.state, this.color, this.stateCode);

  /// Represents the Australia state name.
  final String state;

  /// Represents the Australia state color.
  final Color color;

  /// Represents the Australia state code.
  final String stateCode;
}

class WorldMap extends StatefulWidget {
  @override
  _WorldMapState createState() => _WorldMapState();
}

class _WorldMapState extends State<WorldMap> {
  // Define locations for markers (dots) on specific countries
  final List<BranchLocation> branchLocations = [
    BranchLocation(
        city: 'New York',
        latitude: 40.7128,
        longitude: -74.0060,
        color: Colors.green,
        patientName: 'Olga Ivanova' // New Patient
        ),
    BranchLocation(
        city: 'Paris',
        latitude: 48.8566,
        longitude: 2.3522,
        color: Colors.yellow,
        patientName: 'Alexei Smirnov' // Existing Patient
        ),
    BranchLocation(
        city: 'Mumbai',
        latitude: 19.0760,
        longitude: 72.8777,
        color: Colors.green,
        patientName: 'Anastasia Romanova' // New Patient
        ),
    BranchLocation(
        city: 'Berlin',
        latitude: 52.5200,
        longitude: 13.4050,
        color: Colors.yellow,
        patientName: 'Dmitry Orlov' // Existing Patient
        ),
    BranchLocation(
        city: 'Russia',
        latitude: 47.233334,
        longitude: 39.700001,
        color: Colors.yellow,
        patientName: 'João Silva' // Existing Patient
        ),
    BranchLocation(
      city: 'Russia',
      latitude: 54.983334,
      longitude: 73.366669,
      patientName: 'Dmitry Smirnov',
      color: Colors.green, // Existing Patient
    ),
    BranchLocation(
        city: 'Russia',
        latitude: 55.796391,
        longitude: 49.108891,
        color: Colors.green,
        patientName: 'Elena Kuznetsova' // Existing Patient
        ),
    BranchLocation(
        city: 'Japan',
        latitude: 35.183334,
        longitude: 136.899994,
        color: Colors.green,
        patientName: 'Hiroshi Tanaka' // Existing Patient
        ),
    BranchLocation(
        city: 'Japan',
        latitude: 33.883331,
        longitude: 130.883331,
        color: Colors.green,
        patientName: 'Yuki Nakamura' // Existing Patient
        ),
    BranchLocation(
        city: 'Japan',
        latitude: 38.268223,
        longitude: 140.869415,
        color: Colors.yellow,
        patientName: 'Aiko Sato' // Existing Patient
        ),
    BranchLocation(
        city: 'Japan',
        latitude: 34.383331,
        longitude: 132.449997,
        color: Colors.green,
        patientName: 'Kenji Yamamoto' // Existing Patient
        ),
    BranchLocation(
        city: 'Japan',
        latitude: 35.516666,
        longitude: 139.699997,
        color: Colors.yellow,
        patientName: 'Emi Suzuki' // Existing Patient
        ),
    BranchLocation(
        city: 'Japan',
        latitude: 35.011665,
        longitude: 135.768326,
        color: Colors.yellow,
        patientName: 'Ivan Petrov' // Existing Patient
        ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Legend for dot colors
        SfMaps(
          layers: [
            MapShapeLayer(
              source: MapShapeSource.asset(
                'assets/world_map.json', // GeoJSON file of the world map
                shapeDataField: 'name',
              ),
              color: Colors.green.withOpacity(0.1),
              // Set all countries to red with opacity
              strokeColor: Colors.grey,
              strokeWidth: 0.5,
              // Add markers (dots) on the map
              markerBuilder: (context, index) {
                final location = branchLocations[index];
                return MapMarker(
                  latitude: location.latitude,
                  longitude: location.longitude,
                  child: Tooltip(
                    message: '${location.patientName} - ${location.city}',
                    // Customize the tooltip text
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: location.color,
                        // Dot color based on new/existing patients
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                );
              },
              initialMarkersCount: branchLocations.length,
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
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

// Define branch location model
class BranchLocation {
  final String city;
  final double latitude;
  final double longitude;
  final Color color;
  final String patientName;

  BranchLocation({
    required this.city,
    required this.latitude,
    required this.longitude,
    required this.color,
    required this.patientName,
  });
}
