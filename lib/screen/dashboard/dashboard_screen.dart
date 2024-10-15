import 'package:doctor_app/core/color_utils.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/screen/dashboard/summary_view/summary_view_screen.dart';
import 'package:flutter/material.dart';

import '../../core/route/route.dart';
import 'app_list/app_list_view.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: commonAppBar(
            leadingWidth: 200,
            bottom: TabBar(
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
            leading: SizedBox(
              width: 200,
              height: 56,
              child: Center(
                  child: CommonTextWidget(
                fontWeight: FontWeight.w700,
                text: "Logo here",
                textColor: Colors.white,
              )),
            ),
            color: colorGreen,
            actions: [
              commonIcon(onTap: () {
                pushScreen(
                    context: context, routeName: RouteName.settingScreen);
              }),
              commonIcon(
                  icon: Icons.question_mark_outlined,
                  onTap: () {
                    pushScreen(
                        context: context,
                        routeName: RouteName.reportAndIssueScreen);
                  }),
              commonInkWell(
                onTap: () {
                  pushScreen(
                      context: context,
                      routeName: RouteName.notificationScreen);
                },
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Icon(
                      Icons.notifications_none,
                      color: Colors.white,
                      size: 24,
                    ),
                    Positioned(
                        top: -8.0,
                        right: -3.0,
                        child: Stack(
                          children: <Widget>[
                            Container(
                              width: 20,
                              height: 20,
                              decoration: commonBoxDecoration(
                                  shape: BoxShape.circle, color: Colors.red),
                              child: Center(
                                child: CommonTextWidget(
                                  text: "20",
                                  fontSize: 9,
                                  textColor: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ))
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              )
            ]),
        body: const TabBarView(
          children: [
            AppListView(),
            SummaryViewScreen(),
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
