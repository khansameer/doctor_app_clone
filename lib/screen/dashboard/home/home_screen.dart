
import 'package:doctor_app/core/common/app_scaffold.dart';
import 'package:doctor_app/core/component/component.dart';

import 'package:doctor_app/screen/dashboard/app_list/app_list_view.dart';
import 'package:doctor_app/screen/dashboard/summary_view/summary_view_screen.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: AppScaffold(
        left: 0,
        right: 0  ,
        appBar: commonAppBar(
          toolbarHeight: 0,
          bottom:  TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            tabAlignment: TabAlignment.fill,

            unselectedLabelColor: Colors.white.withOpacity(0.80),
            indicatorColor: Colors.white,
            dividerColor: Colors.white,
            labelColor: Colors.white,
            tabs: const [
              Tab(
                // icon: Icon(Icons.chat_bubble),
                text: "App",
              ),
              Tab(

                text: "Summary",
              ),

            ],
          ),
        ),

        child: const TabBarView(
          children: [
            AppListView(),
            SummaryViewScreen()

          ],
        ),
      ),
    );
  }
  commonIcon({IconData? icon, double? size, VoidCallback? onTap}) {
    return IconButton(
        onPressed: onTap,
        icon: Icon(
          icon ?? Icons.settings_outlined,
          color: Colors.white,
          size: size,
        ));
  }
}
