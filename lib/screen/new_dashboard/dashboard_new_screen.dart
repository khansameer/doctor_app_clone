import 'package:doctor_app/core/app_constants.dart';
import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/CustomAlertDialog.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/image/image_path.dart';
import 'package:doctor_app/core/responsive.dart';
import 'package:doctor_app/core/string/string_utils.dart';
import 'package:doctor_app/provider/dashboard_provider.dart';
import 'package:doctor_app/screen/new_dashboard/menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardNewScreen extends StatefulWidget {
  const DashboardNewScreen({super.key});

  @override
  State<DashboardNewScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardNewScreen> {
  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DashboardProvider>().getUserName();
    });
  }

  @override
  Widget build(BuildContext context) {
    var isMobile = Responsive.isMobile(context);
    return Consumer<DashboardProvider>(builder: (context, provider, child) {
      return Scaffold(
        drawer: isMobile
            ? Drawer(
                child: NestedExpandableMenu(provider),
              )
            : const SizedBox.shrink(),
        appBar: AppBar(
          centerTitle: true,
          actions: [
            Container(
              width: thirtyFive,
              height: thirtyFive,
              clipBehavior: Clip.antiAlias,
              decoration: commonBoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey, width: one)),
              child: loadAssetImage(path: icDoctorWidget),
            ),
            const SizedBox(
              width: ten,
            ),
            PopupMenuButton<int>(
              color: Colors.white,
              constraints: const BoxConstraints.tightFor(width: twoHundred),
              elevation: zero,
              tooltip: "profile",
              offset: const Offset(zero, thirty),
              onSelected: (value) {
                print('====${value}');
                if (value == 0) {
                  provider.updatePage = "setting";
                  //provider.setSelectedMenu("profile");
                  //     provider.setSelectedIndex(index);
                }
                if (value == 1) {
                  provider.setSelectedMenu("profile");
                }
                /*if (value == 3) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      var height = MediaQuery.of(context).size.height;
                      var width = MediaQuery.of(context).size.width;

                      return CustomAlertDialog(
                        content: Container(
                          height: isMobile
                              ? height * zero29
                              : isDesktop
                                  ? height * 0.5
                                  : height * zero28,
                          width: isMobile
                              ? width * zero9
                              : isDesktop
                                  ? width * 0.1
                                  : width * zero2,
                          padding: const EdgeInsets.symmetric(
                              horizontal: twenty, vertical: twenty),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(twenty),
                              ),
                            ),
                            child: const LogoutPage(),
                          ),
                        ),
                      );
                    },
                  );
                }*/
              },
              itemBuilder: (context) => [
                //buildPopupMenuItem(context: context, index: 0, text: profile),
                buildPopupMenuItem(context: context, index: 0, text: "Setting"),
                buildPopupMenuItem(context: context, index: 1, text: "Logout"),
              ],
              child: Row(
                children: [
                  CommonTextWidget(
                      text: provider.name ?? "", textColor: Colors.white),
                  const Icon(
                    Icons.keyboard_arrow_down_sharp,
                    color: Colors.white,
                  )
                ],
              ),
            ),
            const SizedBox(
              width: ten,
            ),
          ],
          leadingWidth: isMobile ? null : oneHundred,
          iconTheme: const IconThemeData(color: Colors.white),
          leading: isMobile
              ? null
              : const ImageIcon(
                  color: Colors.white,
                  AssetImage(
                    icLogoApps,
                  )),
          backgroundColor: AppColors.colorDrawer,
        ),
        body: Row(
          children: [
            isMobile
                ? SizedBox.shrink()
                : Expanded(flex: 2, child: NestedExpandableMenu(provider)),
            //NestedExpandableMenu(),

            Expanded(
              flex: 9,
              child: provider.currentPage, // Display the selected page
            ),
          ],
        ),
      );
    });
  }
}
