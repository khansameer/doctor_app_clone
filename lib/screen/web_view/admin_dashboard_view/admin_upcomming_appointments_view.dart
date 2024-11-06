import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/image/image_path.dart';
import 'package:doctor_app/core/string/string_utils.dart';
import 'package:doctor_app/provider/admin_dashboard_provider.dart';
import 'package:doctor_app/provider/report_provier.dart';
import 'package:doctor_app/screen/web_view/admin_dashboard_view/patient_profile_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
                  return Container(
                    decoration: BoxDecoration(
                        /* color: provider.hoveredIndex == index
                            ? AppColors.colorBgNew.withValues(alpha: 0.7)
                            : Colors.transparent,*/
                        borderRadius: BorderRadius.circular(8)),
                    child: Column(
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
                                    commonInkWell(
                                      /*onEnter: (event) {
                                        provider.setHoveredProfile(index);
                                        */ /*showProfileDialog(context);
                                        context.read<ReportProvider>().setName =
                                            provider.patients[index].name
                                                .toString();
                                        context
                                                .read<ReportProvider>()
                                                .setImage =
                                            provider.patients[index].profile
                                                .toString();*/ /*
                                      },
                                      onExit: (_){
                                        provider.setHoveredProfile(null);
                                      },*/
                                      child: commonProfileIcon(
                                          width: 40,
                                          height: 40,
                                          path: provider
                                                  .patients[index].profile ??
                                              icDummyUser),
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
                                          commonInkWell(
                                            onEnter: (event) {
                                              //  showProfileDialog(context);
                                              context
                                                      .read<ReportProvider>()
                                                      .setName =
                                                  provider.patients[index].name
                                                      .toString();
                                              context
                                                      .read<ReportProvider>()
                                                      .setImage =
                                                  provider
                                                      .patients[index].profile
                                                      .toString();
                                            },
                                            child: CommonTextWidget(
                                              fontWeight: FontWeight.w600,
                                              text:
                                                  provider.patients[index].name,
                                              fontSize: 14,
                                            ),
                                          ),
                                          CommonTextWidget(
                                            text: provider
                                                .patients[index].description,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 10,
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  MouseRegion(
                                    onEnter: (_) {
                                      provider.setHoveredChat(index);
                                    },
                                    onExit: (_) {
                                      provider.setHoveredChat(null);
                                    },
                                    child: AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 200),
                                      alignment: Alignment.topLeft,
                                      width: 35,
                                      decoration: BoxDecoration(
                                          color: provider.hoveredChat == index
                                              ? AppColors.primary
                                              : AppColors.colorBgNew,
                                          shape: BoxShape.circle),
                                      height: 35,
                                      child: Center(
                                        child: Icon(
                                          size: 15,
                                          Icons.message,
                                          color: provider.hoveredChat == index
                                              ? Colors.white
                                              : Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  MouseRegion(
                                    onEnter: (_) {
                                      provider.setHoveredVideoCall(index);
                                    },
                                    onExit: (_) {
                                      provider.setHoveredVideoCall(null);
                                    },
                                    child: AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 200),
                                      alignment: Alignment.topLeft,
                                      width: 35,
                                      decoration: BoxDecoration(
                                          color:
                                              provider.hoveredVideoCall == index
                                                  ? AppColors.primary
                                                  : AppColors.colorBgNew,
                                          shape: BoxShape.circle),
                                      height: 35,
                                      child: Center(
                                        child: Icon(
                                          size: 15,
                                          Icons.videocam,
                                          color:
                                              provider.hoveredVideoCall == index
                                                  ? Colors.white
                                                  : Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Builder(builder: (context) {
                                    return commonInkWell(
                                      onTap: () {
                                        context.read<ReportProvider>().setName =
                                            provider.patients[index].name
                                                .toString();
                                        context
                                                .read<ReportProvider>()
                                                .setImage =
                                            provider.patients[index].profile
                                                .toString();
                                        // showPopoverMenu(
                                        //     width: size.width*0.1,
                                        //     context: context,child:PatientProfileDialog() , size: size);
                                        showProfileDialog(context);
                                      },
                                      child: Consumer<AdminDashboardProvider>(
                                          builder: (context, provider, child) {
                                        return MouseRegion(
                                          onEnter: (_) {
                                            provider.setHoveredEdit(index);
                                          },
                                          onExit: (_) {
                                            provider.setHoveredEdit(null);
                                          },
                                          child: AnimatedContainer(
                                            height: 35,
                                            duration: const Duration(
                                                milliseconds: 200),
                                            margin: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                color: provider.hoveredEdit ==
                                                        index
                                                    ? AppColors.primary
                                                    : AppColors.colorBgNew,
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: Center(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0, right: 10),
                                                child: CommonTextWidget(
                                                  fontSize: 12,
                                                  textColor:
                                                      provider.hoveredEdit ==
                                                              index
                                                          ? Colors.white
                                                          : null,
                                                  text: "View Profile",
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                    );
                                  }),
                                  /* MouseRegion(
                                    onEnter: (_) {
                                      provider.setHoveredEdit(index);
                                    },
                                    onExit: (_) {
                                      provider.setHoveredEdit(null);
                                    },
                                    child: AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 200),
                                      alignment: Alignment.topLeft,
                                      width: 35,
                                      decoration: BoxDecoration(
                                          color: provider.hoveredEdit == index
                                              ? AppColors.primary
                                              : AppColors.colorBgNew,
                                          shape: BoxShape.circle),
                                      height: 35,
                                      child: Center(
                                        child: Icon(
                                          size: 15,
                                          Icons.edit,
                                          color: provider.hoveredEdit == index
                                              ? Colors.white
                                              : Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),*/
                                ],
                              )
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
                    ),
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
