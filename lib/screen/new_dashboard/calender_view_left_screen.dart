import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/provider/calender_provider.dart';
import 'package:doctor_app/screen/new_dashboard/all_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CalenderViewLeftScreen extends StatefulWidget {
  const CalenderViewLeftScreen({super.key});

  @override
  State<CalenderViewLeftScreen> createState() => _CalenderViewLeftScreenState();
}

class _CalenderViewLeftScreenState extends State<CalenderViewLeftScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTabIndex = 0;

  final List<String> data = [
    'Data for Tab 1',
    'Data for Tab 2',
    'Data for Tab 3'
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: data.length, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedTabIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return SizedBox(
      width: size.width,
      height: size.height,
      child: ListView(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    commonText(
                        text: "Today's Schedule", fontSize: 12, left: 10),
                    const Row(
                      children: [
                        Icon(
                          Icons.arrow_back_ios_outlined,
                          size: 15,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const Divider(
                thickness: 0.3,
              ),
              Container(
                margin: EdgeInsets.only(
                    left: size.width * 0.04, right: size.width * 0.04),
                padding: const EdgeInsets.all(8),
                decoration: commonBoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.amber, width: 1),
                ),
                child: Center(
                  child: commonText(
                      text: "Add Walk in Appointment",
                      fontSize: 12,
                      color: Colors.amber),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                color: Colors.white,
                height: size.height,
                child: DefaultTabController(
                    initialIndex: 0,
                    length: 3,
                    child: Builder(
                      builder: (context) {
                        return Column(
                          children: [
                            Material(
                              color: Colors.grey.withOpacity(0.20),
                              child: TabBar(
                                controller: _tabController,
                                indicatorColor: Colors.amber,
                                labelColor: Colors.black,
                                tabs: const [
                                  Tab(text: 'All'),
                                  Tab(text: 'Online'),
                                  Tab(text: 'Offline'),
                                ],
                              ),
                            ),
                            Expanded(
                              child: TabBarView(
                                controller: _tabController,
                                children: [
                                  AllViewScreen(
                                    data: "all",
                                    appointments:
                                        Provider.of<CalenderProvider>(context)
                                            .appointmentsModel
                                            ?.appointments,
                                  ),
                                  AllViewScreen(
                                      data: "online",
                                      appointments:
                                          Provider.of<CalenderProvider>(context)
                                              .getTodayAppointments()),
                                  AllViewScreen(
                                    data: "offline",
                                    appointments:
                                        Provider.of<CalenderProvider>(context)
                                            .getYesterdayAppointments(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    )),
              )
            ],
          ),
        ],
      ),
    );
  }
}
