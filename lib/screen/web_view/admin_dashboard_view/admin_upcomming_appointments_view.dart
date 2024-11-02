import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/image/image_path.dart';
import 'package:doctor_app/core/string/string_utils.dart';
import 'package:doctor_app/provider/admin_dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdminUpComingAppointmentsView extends StatelessWidget {
  const AdminUpComingAppointmentsView({super.key, required this.provider});
  final AdminDashboardProvider provider;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Container(
      height: size.height,
      margin: const EdgeInsets.all(20),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            CommonTextWidget(
              text: "Upcoming appointments".toUpperCase(),
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
            CommonTextWidget(
              top: 12,
              textColor: AppColors.colorActive,
              fontWeight: FontWeight.w700,
              fontSize: 12,
              text: DateFormat(dMMYYYY).format(
                DateTime.now(),
              ),
            ),
            SizedBox(
              height: size.height,
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: provider.patients.length,
                itemBuilder: (context, index) {
                  return Column(
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
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                      image: provider.patients[index].profile ??
                                          icDummyUser,
                                    ) /*commonImageNetworkWidget(path: provider.patients[index].photo)*/,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Flexible(
                                    child: Column(
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
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          top: 5,
                                        ),
                                      ],
                                    ),
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
                                        color: AppColors.colorBgNew,
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
                      // / const Divider(thickness: 0.3,),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
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
                                  fontWeight: FontWeight.w500,
                                )
                              ],
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                            /* Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CommonTextWidget(
                                  text: '\$${provider.patients[index].price}',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                )
                              ],
                            )*/
                          ],
                        ),
                      )
                    ],
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    thickness: 0.3,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}