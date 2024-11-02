import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/image/image_path.dart';
import 'package:doctor_app/core/responsive.dart';
import 'package:doctor_app/provider/admin_dashboard_provider.dart';
import 'package:flutter/material.dart';

class DashboardPatientView extends StatelessWidget {
  const DashboardPatientView({super.key, required this.provider});
  final AdminDashboardProvider provider;

  @override
  Widget build(BuildContext context) {
    final PageController pageControllerPatientView = PageController();
    var size = MediaQuery.sizeOf(context);
    var isDeskTop = Responsive.isDesktop(context);
    var isTablet = Responsive.isTablet(context);
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
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
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: setAssetImage(
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.scaleDown,
                                          image: provider
                                                  .patients[index].profile ??
                                              icDummyUsers,
                                        )),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CommonTextWidget(
                                          text: provider.patients[index].name,
                                          fontSize: 12,
                                        ),
                                        CommonTextWidget(
                                          text: provider
                                              .patients[index].description,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14,
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
                                            /*color: AppColors.colorBgNew,*/
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
          ),
        ],
      ),
    );
  }
}
