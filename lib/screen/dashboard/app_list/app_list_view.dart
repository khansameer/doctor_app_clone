import 'package:doctor_app/core/app_constants.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/route/route.dart';
import 'package:doctor_app/provider/dashboard_provider.dart';
import 'package:doctor_app/provider/model/dummy_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppListView extends StatelessWidget {
  const AppListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(builder: (context, provider, child) {
      return ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              commonGridView(list: provider.appList),
              const Divider(),
              CommonTextWidget(
                text: "Ray",
                left: 20,
                fontWeight: FontWeight.w500,
                fontSize: 18,
                marginBottom: 10,
                top: 10,
              ),
              commonGridView(list: provider.rayList)
            ],
          ),
        ],
      );
    });
  }

  commonGridView({required List<DummyModel> list}) {
    return GridView.builder(
      shrinkWrap: true,
      primary: false,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        childAspectRatio: 0.99,
      ),
      itemCount: list.length,
      itemBuilder: (context, index) {
        return commonInkWell(
          onTap: () {
            if (list[index].date == "Healthfeed") {
              pushScreen(
                  context: context, routeName: RouteName.healthFeedScreen);
            }
            if (list[index].date == "Profile") {
              pushScreen(context: context, routeName: RouteName.profileScreen);
            }
            if (list[index].date == "Patient") {
              pushScreen(context: context, routeName: RouteName.patientsScreen);
            }
            if (list[index].date == "Calender") {
              pushScreen(context: context, routeName: RouteName.calenderScreen);
            }

            print('=============list${list[index].date}');
          },
          child: Container(
            margin: const EdgeInsets.only(top: ten, left: ten, right: ten),
            decoration: commonBoxDecoration(
              color: Colors.white,
              border:
                  Border.all(color: Colors.grey.withOpacity(0.50), width: 1),

              borderRadius: BorderRadius.circular(12), //border corner radius
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                commonImageNetworkWidget(
                    boxFit: BoxFit.scaleDown,
                    path: list[index].icon,
                    width: 40,
                    height: 40),
                CommonTextWidget(
                  top: five,
                  fontSize: twelve,
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.center,
                  text: list[index].date,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
