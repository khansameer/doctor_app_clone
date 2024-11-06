import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/provider/admin_dashboard_provider.dart';
import 'package:flutter/material.dart';

class DashboardPatientView extends StatelessWidget {
  const DashboardPatientView({super.key, required this.provider});

  final AdminDashboardProvider provider;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CommonTextWidget(
                  left: 5,
                  text: "appointments".toUpperCase(),
                  fontWeight: FontWeight.w800,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: CommonTextWidget(

                  right: 5,
                  text: "Oct 1 - Oct 30".toUpperCase(),
                  textColor: Colors.green.shade300,
                  fontWeight: FontWeight.w800,
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          const Divider(
            thickness: 0.3,
          ),
         // commonView(),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: commonView(
                    title: "No of completed appointments".toUpperCase(),
                    value: "50",
                    colorText: Colors.black,
                    bgColor: AppColors.colorBgNew,
                  ),
                ),
                Expanded(
                  child: commonView(
                    title: "No of upcoming appointments".toUpperCase(),
                    value: "40",
                    colorText: AppColors.primary,
                    bgColor: AppColors.colorBgNew,
                  ),
                ),
                Expanded(
                  child: commonView(
                    title: "No of missed appointments".toUpperCase(),
                    value: "5",
                    colorText: Colors.red.shade600,
                    bgColor: AppColors.colorBgNew,
                  ),
                ),
              ],
            ),
          )
          /* Padding(
            padding: const EdgeInsets.all(0.0),
            child: Row(
              children: [
                Expanded(
                    child: CommonTextWidget(
                  text: "Next Patient".toUpperCase(),
                  fontWeight: FontWeight.w800,
                )),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          provider.previousItem();
                          pageControllerPatientView
                              .jumpToPage(provider.currentIndex);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new_outlined,
                          color: Colors.grey,
                          size: 16,
                        )),
                    IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          provider.nextItem(provider.patients.length);
                          pageControllerPatientView
                              .jumpToPage(provider.currentIndex);
                          // buttonCarouselController.nextPage();
                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Colors.grey,
                          size: 16,
                        ))
                  ],
                ))
              ],
            ),
          ),
          SizedBox(
            height: isDeskTop
                ? size.height * 0.14
                : isTablet
                    ? size.height * 0.15
                    : size.height * 0.13,
            child: PageView.builder(
                controller: pageControllerPatientView,
                onPageChanged: (value) {
                  provider.currentIndex == value;
                },
                itemCount: provider.patients.length,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 9,
                                child: Row(
                                  children: [
                                    commonInkWell(
                                      onEnter: (event) {
                                        showProfileDialog(context);
                                        context.read<ReportProvider>().setName =
                                            provider.patients[index].name
                                                .toString();
                                        context
                                                .read<ReportProvider>()
                                                .setImage =
                                            provider.patients[index].profile
                                                .toString();
                                      },
                                      child: commonProfileIcon(
                                          width: 40,
                                          height: 40,
                                          path: provider
                                                  .patients[index].profile ??
                                              icDummyUsers),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        commonInkWell(
                                          onEnter: (event) {
                                            showProfileDialog(context);
                                            context
                                                    .read<ReportProvider>()
                                                    .setName =
                                                provider.patients[index].name
                                                    .toString();
                                            context
                                                    .read<ReportProvider>()
                                                    .setImage =
                                                provider.patients[index].profile
                                                    .toString();
                                          },
                                          child: CommonTextWidget(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            text: provider.patients[index].name,
                                          ),
                                        ),
                                        CommonTextWidget(
                                          text: provider
                                              .patients[index].description,
                                          fontSize: 11,
                                          top: 5,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Flexible(
                                    child: MouseRegion(
                                      onEnter: (_) => provider.setHover(true),
                                      onExit: (_) => provider.setHover(false),
                                      child: AnimatedContainer(
                                        alignment: Alignment.topLeft,
                                        width: 40,
                                        decoration: BoxDecoration(
                                            color: provider.isHovered
                                                ? AppColors.colorBlue
                                                : AppColors.colorBgNew,
                                            */ /*color: AppColors.colorBgNew,*/ /*
                                            shape: BoxShape.circle),
                                        height: 40,
                                        duration:
                                            const Duration(milliseconds: 200),
                                        child: Center(
                                          child: Icon(
                                            size: 18,
                                            Icons.call_sharp,
                                            color: provider.isHovered
                                                ? Colors.white
                                                : Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ))
                            ],
                          ),
                        ),
                      ),
                      const Divider(
                        thickness: 0.3,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Row(
                          children: [
                            Expanded(
                                child: Row(
                              children: [
                                const Icon(
                                  Icons.access_time,
                                  color: AppColors.colorTextNew,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                CommonTextWidget(
                                  text: provider.patients[index].time,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                )
                              ],
                            )),
                            const Expanded(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.more_horiz,
                                  color: AppColors.colorTextNew,
                                ),
                              ],
                            ))
                          ],
                        ),
                      )
                    ],
                  );
                }),
          ),*/
        ],
      ),
    );
  }

  commonView({String? title, String? value, Color? bgColor, Color? colorText}) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: bgColor ?? AppColors.colorBgNew,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CommonTextWidget(
            fontWeight: FontWeight.w400,
            fontSize: 12,
            text: title ?? "",
          ),
          const SizedBox(height: 8),
          CommonTextWidget(
            text: value ?? "",
            fontSize: 24,
            textColor: colorText ?? Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }
}
