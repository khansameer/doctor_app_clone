import 'package:doctor_app/core/color_utils.dart';
import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/image/image_path.dart';
import 'package:doctor_app/provider/dashboard_provider.dart';
import 'package:flutter/material.dart';


class NestedExpandableMenu extends StatefulWidget {
  const NestedExpandableMenu(this.provider, {super.key});
  final DashboardProvider provider;

  @override
  State<NestedExpandableMenu> createState() => _NestedExpandableMenuState();
}

class _NestedExpandableMenuState extends State<NestedExpandableMenu> {
  int? expandedIndex;
  @override
  void initState() {
    super.initState();
    setState(() {
      expandedIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorDrawer,
      body: ListView(
        children: [
          const Divider(
            thickness: 0.3,
          ),
          /* CommonTextWidget(
              text: "Ray",
              left: 15,
              textColor: Colors.white.withOpacity(0.40),
              fontWeight: FontWeight.w600,
              fontSize: 18),*/
          // Parent expandable menu
          const SizedBox(
            height: 5,
          ),
          commonMenu(
            index: 0, // Index for Calender
            children: [],
            backgroundColor: expandedIndex == 0
                ? Colors.white.withOpacity(0.10)
                : Colors.transparent,
            onExpansionChanged: (isExpanded) {
              setState(() {
                expandedIndex = isExpanded ? 0 : null;
              });
              if (isExpanded) {
                widget.provider.updatePage = "Calender";
              }
            },
            leading: Icon(
              Icons.calendar_month_sharp,
              color: expandedIndex == 0
                  ? Colors.white
                  : Colors.white.withOpacity(0.50),
            ),
            headerTextColor: expandedIndex == 0
                ? Colors.white
                : Colors.white.withOpacity(0.50),
          ),
          commonMenu(
            index: 1,
            onExpansionChanged: (isExpanded) {
              setState(() {
                expandedIndex = isExpanded ? 1 : null;
              });
              if (isExpanded) {
                widget.provider.updatePage = "Patients";
              }
            },
            backgroundColor: expandedIndex == 1
                ? Colors.white.withOpacity(0.10)
                : Colors.transparent,
            leading: loadAssetImage(
                path: icPatient,
                width: 24,
                height: 24,
                color: Colors.white.withOpacity(0.40)),
            headerText: "Patients",
            children: [],
          ),
          commonMenu(
              index: 2,
              headerText: "Communications",
              children: [],
              leading: Icon(
                Icons.cell_tower,
                color: Colors.white.withOpacity(0.40),
              )),
          commonMenu(
              index: 3,
              onExpansionChanged: (isExpanded) {
                setState(() {
                  expandedIndex = isExpanded ? 3 : null;
                });
                if (isExpanded) {
                  widget.provider.updatePage = "menu_report";
                }
              },
              backgroundColor: expandedIndex == 3
                  ? Colors.white.withOpacity(0.10)
                  : Colors.transparent,
              headerText: "Reports",
              children: [],
              leading: Icon(
                Icons.auto_graph,
                color: Colors.white.withOpacity(0.40),
              )),
          commonMenu(
              index: 4,
              onExpansionChanged: (isExpanded) {
                setState(() {
                  expandedIndex = isExpanded ? 4 : null;
                });
                if (isExpanded) {
                  widget.provider.updatePage = "menu_setting";
                }
              },
              backgroundColor: expandedIndex == 4
                  ? Colors.white.withOpacity(0.10)
                  : Colors.transparent,
              headerText: "Settings",
              children: [],
              leading: Icon(
                Icons.settings_outlined,
                color: Colors.white.withOpacity(0.40),
              )),
          /*commonMenu(
              index: 5,
              headerText: "Integrations",
              children: [],
              leading: Icon(
                Icons.settings_accessibility,
                color: Colors.white.withOpacity(0.40),
              )),*/
          /*commonMenu(
              index: 6,
              headerText: "Claims",
              children: [],
              leading: Icon(
                Icons.clean_hands_sharp,
                color: Colors.white.withOpacity(0.40),
              )),*/
          /* commonMenu(
              index: 7,
              headerText: "Back Offices",
              showIcon: true,
              leading: Icon(
                Icons.local_post_office_outlined,
                color: Colors.white.withOpacity(0.40),
              )),*/

          const SizedBox(
            height: 5,
          ),
          const Divider(
            thickness: 0.3,
          ),

          /*   commonText(
              text: "Practo.com",
              left: 10,
              color: Colors.white.withOpacity(0.40),
              fontWeight: FontWeight.w700,
              fontSize: 14),*/
          const SizedBox(
            height: 5,
          ),
          commonMenu(
              index: 8,
              headerText: "Profiles",
              children: [],
              leading: Icon(
                Icons.person,
                color: Colors.white.withOpacity(0.40),
              )),
          /*commonMenu(
              headerText: "Prime",
              children: [],
              index: 9,
              leading: Icon(
                Icons.light_mode_sharp,
                color: Colors.white.withOpacity(0.40),
              )),*/
          commonMenu(
              index: 10,
              headerText: "Feedback",
              children: [],
              leading: Icon(
                Icons.thumb_up_alt_outlined,
                color: Colors.white.withOpacity(0.40),
              )),
          /* commonMenu(
              index: 11,
              onExpansionChanged: (isExpanded) {
                setState(() {
                  expandedIndex = isExpanded ? 11 : null;
                });
                if (isExpanded) {
                  widget.provider.updatePage = "menu_reach";
                }
              },
              backgroundColor: expandedIndex == 11
                  ? Colors.white.withOpacity(0.10)
                  : Colors.transparent,
              headerText: "Reach",
              children: [],
              leading: Icon(
                Icons.notifications_none,
                color: Colors.white.withOpacity(0.40),
              )),*/
          /* commonMenu(
              index: 12,
              headerText: "Consult",
              children: [],
              leading: Icon(
                Icons.chat,
                color: Colors.white.withOpacity(0.40),
              )),*/

          /* Container(
            color: Colors.white.withOpacity(0.10),
            child: ListTile(
              leading: const Icon(
                Icons.lightbulb_outline,
                color: Colors.white,
              ),
              title: commonText(
                  text: "See how navigation works", color: Colors.white),
            ),
          )*/
        ],
      ),
    );
  }
}
