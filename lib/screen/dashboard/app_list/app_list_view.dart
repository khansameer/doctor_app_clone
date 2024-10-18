import 'package:doctor_app/core/app_constants.dart';
import 'package:doctor_app/core/color_utils.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/responsive.dart';
import 'package:doctor_app/core/route/route.dart';
import 'package:doctor_app/provider/dashboard_provider.dart';
import 'package:doctor_app/provider/model/dummy_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppListView extends StatelessWidget {
  const AppListView({super.key,required this.onSelectedPage});
  final Function(String) onSelectedPage;
  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(builder: (context, provider, child) {
      var isMobile = Responsive.isMobile(context);
      var isTablet = Responsive.isTablet(context);
      return Container(
        color: isMobile?colorBG:Colors.white,
        padding: const EdgeInsets.all(2),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                commonGridView(list: provider.appList, context: context),
                const Divider(),
                CommonTextWidget(
                  text: "Ray",
                  left: 20,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  marginBottom: 10,
                  top: 10,
                ),
                commonGridView(list: provider.rayList, context: context)
              ],
            ),
          ],
        ),
      );
    });
  }

  commonGridView(
      {required List<DummyModel> list, required BuildContext context}) {
    var isMobile = Responsive.isMobile(context);
    var isTablet = Responsive.isTablet(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        shrinkWrap: true,
        primary: false,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: isMobile ? 3 : isTablet?3:4,
          mainAxisSpacing: isMobile ? 8 : 10,
          crossAxisSpacing: isMobile ? 8 : 10,
          childAspectRatio: isMobile ? 0.99 : isTablet?1:2,
        ),
        itemCount: list.length,
        itemBuilder: (context, index) {
          return commonInkWell(
            onTap: () {
         /*     if (list[index].date == "Healthfeed") {
                pushScreen(
                    context: context, routeName: RouteName.healthFeedScreen);
              }
              if (list[index].date == "Profile") {
                pushScreen(
                    context: context, routeName: RouteName.profileScreen);
              }
              if (list[index].date == "Patient") {
                pushScreen(
                    context: context, routeName: RouteName.patientsScreen);
              }
              if (list[index].date == "Calender") {
                pushScreen(
                    context: context, routeName: RouteName.calenderScreen);
              }
              if (list[index].date == "Consult") {
                pushScreen(
                    context: context, routeName: RouteName.consultScreen);
              }
              if (list[index].date == "Report") {
                pushScreen(context: context, routeName: RouteName.reportScreen);
              }
              if (list[index].date == "Prime") {
                pushScreen(context: context, routeName: RouteName.primeScreen);
              }
              if (list[index].date == "Patient Stories") {
                pushScreen(
                    context: context,
                    routeName: RouteName.patientStoriesScreen);
              }

              if (list[index].date == "Reach") {
                pushScreen(context: context, routeName: RouteName.reachScreen);
              }
              if (list[index].date == "Earning") {
                pushScreen(
                    context: context, routeName: RouteName.weeklyEarningScreen);
              }
*/

              onSelectedPage('${list[index].date}');
              print('=============list${list[index].date}');
            },
            child: Container(
              decoration: commonBoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey, width: 0.5),
                  borderRadius: BorderRadius.circular(2),
                  boxShadow: isMobile
                      ? null
                      : [
                          const BoxShadow(
                              color: Colors.grey,
                              spreadRadius: 0.1,
                              blurRadius: 1)
                        ]),
              margin: const EdgeInsets.only(top: 0, left: 0, right: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: setAssetImage(
                        fit: BoxFit.scaleDown,
                        image: list[index].icon.toString(),
                        width: isMobile ? 40 : 80,
                        height: isMobile ? 40 : 80),
                  ),
                  Flexible(
                    child: CommonTextWidget(
                      top: twenty,
                      fontSize: isMobile ? twelve : 16,
                      textColor: colorText,
                      fontWeight: FontWeight.w700,
                      textAlign: TextAlign.center,
                      text: list[index].date,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
