
import 'package:doctor_app/core/common/app_scaffold.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/responsive.dart';

import 'package:doctor_app/screen/dashboard/app_list/app_list_view.dart';
import 'package:doctor_app/screen/dashboard/summary_view/summary_view_screen.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.onSelectedPage});

  final Function(String) onSelectedPage;
  @override
  Widget build(BuildContext context) {
    var isMobile=Responsive.isMobile(context);
    return DefaultTabController(
      length: 2,
      child: AppScaffold(
        left: 0,
        right: 0  ,
        appBar: commonAppBar(
          toolbarHeight: isMobile?0:10,
          bottom:  TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            tabAlignment: TabAlignment.fill,
          labelStyle: commonTextStyle(fontSize: isMobile?14:16),
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

        child: TabBarView(
          children: [
            AppListView(onSelectedPage: onSelectedPage,),
            const SummaryViewScreen()

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
