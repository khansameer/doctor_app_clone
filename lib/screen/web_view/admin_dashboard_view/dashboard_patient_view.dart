import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_app/core/color_utils.dart';
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
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: colorBGWithOpacity, borderRadius: BorderRadius.circular(8)),
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
            height: isDeskTop ? size.height * 0.23 : size.height * 0.13,
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
                      Padding(
                        padding: const EdgeInsets.all(12.0),
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
                                      width: 70,
                                      height: 70,
                                      fit: BoxFit.cover,
                                      image: icDummyUser,
                                    ) /*commonImageNetworkWidget(path: provider.patients[index].photo)*/,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                  child: Container(
                                    alignment: Alignment.topLeft,
                                    width: 40,
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle),
                                    height: 40,
                                    child: const Center(
                                      child: Icon(
                                        size: 18,
                                        Icons.call_sharp,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ))
                          ],
                        ),
                      ),
                      const Divider(
                        thickness: 0.3,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Expanded(
                                child: Row(
                              children: [
                                const Icon(Icons.access_time),
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
                                  color: Colors.grey,
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
