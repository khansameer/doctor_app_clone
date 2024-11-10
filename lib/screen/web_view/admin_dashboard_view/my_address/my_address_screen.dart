import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/common_button_widget.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/common/custom_alert_dialog.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/image/image_path.dart';
import 'package:doctor_app/core/responsive.dart';
import 'package:doctor_app/provider/address_provider.dart';
import 'package:doctor_app/provider/dashboard_provider.dart';
import 'package:doctor_app/screen/web_view/admin_dashboard_view/my_address/add_my_address_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyAddressScreen extends StatefulWidget {
  const MyAddressScreen({super.key});

  @override
  State<MyAddressScreen> createState() => _MyAddressScreenState();
}

class _MyAddressScreenState extends State<MyAddressScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DashboardProvider>().getUserName();
      context.read<AddressProvider>().getAddress(context: context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    var isTablet = Responsive.isTablet(context);
    var isMobile = Responsive.isMobile(context);
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(0),
        width: size.width,
        height: size.height,
        child: ListView(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonTextWidget(
                              text: "Clinic Address",
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                            ),
                            /* CommonTextWidget(
                              top: 5,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              text: "Add addresses for future use.",
                            ),*/
                          ],
                        ),
                      ),
                      Expanded(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CommonButtonWidget(
                                fontSize: 12,
                                radius: 8,
                                iconShow: true,
                                icon: Container(
                                  margin: EdgeInsets.only(right: 5),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: () {
                                  showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return CustomAlertDialog(
                                        content: AddMyAddressScreen(
                                          isEdit: false,
                                        ),
                                      );
                                    },
                                  );
                                },
                                padding: EdgeInsets.only(
                                    left: 40, right: 40, top: 20, bottom: 20),
                                text: "ADD ADDRESS",
                              ),
                            ],
                          )
                        ],
                      ))
                    ],
                  ),
                ),
                Divider(
                  thickness: 0.3,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Consumer<AddressProvider>(
                      builder: (context, provider, child) {
                    return LayoutBuilder(builder: (context, constraints) {
                      return GridView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: provider
                            .dummyAddresses.length, // Example: number of items
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: isTablet
                              ? 1
                              : isMobile
                                  ? 1
                                  : 2,
                          crossAxisSpacing: 30,
                          mainAxisSpacing: 30,
                          childAspectRatio:
                              3, // Adjust based on height requirements
                        ),
                        // padding: const EdgeInsets.fromLTRB(10, 20, 30, 40),
                        itemBuilder: (context, index) {
                          var data = provider.dummyAddresses[index];
                          return Container(
                            decoration: BoxDecoration(
                                color: AppColors.colorBgNew,
                                borderRadius: BorderRadius.circular(8)),
                            child: Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CommonTextWidget(
                                    text:
                                        context.read<DashboardProvider>().name,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  CommonTextWidget(
                                    text: data.address1,
                                    top: 8,
                                  ),
                                  CommonTextWidget(
                                    text:
                                        '${data.address1},${data.city},${data.state},${data.city},${data.zipcode}',
                                    top: 5,
                                  ),
                                  CommonTextWidget(
                                    text: 'Ph:${data.phoneNumber}',
                                    top: 5,
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        MouseRegion(
                                          onEnter: (_) {
                                            provider.setHoverEdit(index);
                                          },
                                          onExit: (_) {
                                            provider.setHoverEdit(null);
                                          },
                                          child: AnimatedContainer(
                                            duration: const Duration(
                                                milliseconds: 200),
                                            child: CommonButtonWidget(
                                              text: "Edit",
                                              height: 40,
                                              onPressed: () {
                                                showDialog(
                                                  barrierDismissible: false,
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return CustomAlertDialog(
                                                      content:
                                                          AddMyAddressScreen(
                                                        isEdit: true,
                                                        //address: data,
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                              colorBorder:
                                                  provider.hoverEdit == index
                                                      ? AppColors.colorTextNew
                                                      : Colors.black,
                                              colorButton:
                                                  provider.hoverEdit == index
                                                      ? Colors.white
                                                      : AppColors.colorBgNew,
                                              colorText:
                                                  provider.hoverEdit == index
                                                      ? AppColors.colorTextNew
                                                      : AppColors.colorTextNew,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              icon: Container(
                                                margin:
                                                    EdgeInsets.only(right: 10),
                                                child: setAssetImage(
                                                    color: provider.hoverEdit ==
                                                            index
                                                        ? AppColors.colorTextNew
                                                        : Colors.black,
                                                    image: icEditIcon,
                                                    width: 14,
                                                    height: 14),
                                              ),
                                              iconShow: true,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        MouseRegion(
                                          onEnter: (_) {
                                            provider.setHoverDelete(index);
                                          },
                                          onExit: (_) {
                                            provider.setHoverDelete(null);
                                          },
                                          child: AnimatedContainer(
                                            duration: const Duration(
                                                milliseconds: 200),
                                            child: CommonButtonWidget(
                                              text: "Delete",
                                              fontSize: 12,
                                              height: 40,
                                              onPressed: () {
                                                provider.deleteItem(index);
                                              },
                                              fontWeight: FontWeight.w400,
                                              /* colorButton:
                                                  Colors.red.withOpacity(0.8),*/
                                              colorBorder:
                                                  provider.hoverDelete == index
                                                      ? Colors.white
                                                      : Colors.black,
                                              colorButton:
                                                  provider.hoverDelete == index
                                                      ? Colors.redAccent
                                                      : Colors.white,
                                              colorText:
                                                  provider.hoverDelete == index
                                                      ? Colors.white
                                                      : AppColors.colorTextNew,
                                              icon: Container(
                                                margin:
                                                    EdgeInsets.only(right: 10),
                                                child: setAssetImage(
                                                    color:
                                                        provider.hoverDelete ==
                                                                index
                                                            ? Colors.white
                                                            : Colors.black,
                                                    image: icDeleteIcon,
                                                    width: 14,
                                                    height: 14),
                                              ),
                                              iconShow: true,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    });
                  }),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
