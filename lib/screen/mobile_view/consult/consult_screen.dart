import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/app_scaffold.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/responsive.dart';
import 'package:doctor_app/provider/dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConsultScreen extends StatelessWidget {
  const ConsultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var isMobile = Responsive.isMobile(context);
    var size = MediaQuery.sizeOf(context);
    var isDesktop = Responsive.isDesktop(context);
    return Consumer<DashboardProvider>(builder: (context, provider, child) {
      return AppScaffold(
        left: 0,
        right: 0,
        appBar: commonAppBar(
            //   leading: commonBackRedirectButton(color: Colors.white,onTap: ),
            title: "Consult".toUpperCase(),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.settings_outlined,
                    color: Colors.white,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_horiz,
                    color: Colors.white,
                  ))
            ]),
        child: Container(
          color: isMobile ? AppColors.colorBG : Colors.white,
          width: size.width,
          height: size.height,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  color: Colors.black,
                  child: CommonTextWidget(
                    text: "You're missing out on patients by being unavailable",
                    textColor: Colors.white,
                    fontSize: 12,
                    textAlign: TextAlign.center,
                  ),
                ),
                isMobile
                    ? Column(
                        children: [
                          commonList(
                              child: Padding(
                            padding:
                                const EdgeInsets.only(left: 15.0, right: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CommonTextWidget(
                                  fontWeight: FontWeight.w500,
                                  text: "Dr. Bhavesh Gohil",
                                ),
                                Row(
                                  children: [
                                    CommonTextWidget(
                                      text: "Unavailable",
                                      textColor: Colors.grey,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Switch(
                                      activeColor: Colors.white,
                                      inactiveTrackColor: Colors.white,
                                      inactiveThumbColor: Colors.grey,
                                      activeTrackColor: AppColors.colorGreen,
                                      value: provider.isOn,
                                      onChanged: (value) {
                                        provider.toggleSwitch();
                                      },
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )),
                          const SizedBox(
                            height: 20,
                          ),
                          commonView(
                              isMobile: isMobile,
                              size: size,
                              title: "Guide for Online Consultation",
                              desc:
                                  "Video guide and more on how to consult online with patients on Practo",
                              isBthHide: true,
                              btnText: "VIEW"),
                          const SizedBox(
                            height: 20,
                          ),
                          commonView(
                            isMobile: isMobile,
                            size: size,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          commonView(
                              isMobile: isMobile,
                              size: size,
                              title: "Q&A is enabled",
                              desc:
                                  "You will now receive free questions pertaining to your speciality. You can change this in settings.",
                              btnText: "GO IT"),
                          const SizedBox(
                            height: 20,
                          ),
                          commonList(
                              child: Padding(
                            padding: const EdgeInsets.only(
                                left: 15.0, right: 15, top: 10, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CommonTextWidget(
                                  fontWeight: FontWeight.w500,
                                  text: "Total People Helped",
                                ),
                                Row(
                                  children: [
                                    CommonTextWidget(
                                      text: "5",
                                      textColor: Colors.black,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Icon(
                                      Icons.favorite,
                                      color: AppColors.colorAmber,
                                    )
                                  ],
                                )
                              ],
                            ),
                          )),
                          const SizedBox(
                            height: 20,
                          ),
                          commonList(
                              child: Padding(
                            padding: const EdgeInsets.only(
                                left: 15.0, right: 15, top: 10, bottom: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonTextWidget(
                                  marginBottom: 10,
                                  fontWeight: FontWeight.w500,
                                  text: "Tips for a great consult experience",
                                ),
                                const Divider(
                                  thickness: 0.3,
                                ),
                                ListView.separated(
                                  shrinkWrap: true,
                                  itemCount: 2,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      dense: true,
                                      contentPadding: EdgeInsets.zero,
                                      leading: const Icon(
                                        Icons.check_circle,
                                        color: Colors.green,
                                      ),
                                      title: CommonTextWidget(
                                        text:
                                            "Explaining everything in detail to the patients",
                                      ),
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return const Divider(
                                      thickness: 0.3,
                                    );
                                  },
                                )
                              ],
                            ),
                          )),
                          const SizedBox(
                            height: 20,
                          ),
                          commonList(
                              child: Padding(
                            padding: const EdgeInsets.only(
                                left: 15.0, right: 15, top: 10, bottom: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CommonTextWidget(
                                      fontWeight: FontWeight.w500,
                                      text: "Answer Insight",
                                    ),
                                    const Icon(
                                      Icons.info_outline,
                                      color: Colors.grey,
                                    )
                                  ],
                                ),
                                const Divider(
                                  thickness: 0.3,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CommonTextWidget(
                                          text: "Answer View",
                                          left: 10,
                                          textColor: Colors.grey,
                                        ),
                                        CommonTextWidget(
                                          text: "0",
                                          fontSize: 20,
                                          left: 10,
                                          top: 10,
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Icon(
                                              Icons.arrow_drop_up_sharp,
                                              color: Colors.green,
                                            ),
                                            CommonTextWidget(
                                                text: "0%",
                                                textColor: Colors.green),
                                          ],
                                        )
                                      ],
                                    )),
                                    Expanded(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CommonTextWidget(
                                          text: "People Helped",
                                          left: 10,
                                          textColor: Colors.grey,
                                        ),
                                        CommonTextWidget(
                                          text: "0",
                                          fontSize: 20,
                                          left: 10,
                                          top: 10,
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Icon(
                                              Icons.arrow_drop_up_sharp,
                                              color: Colors.green,
                                            ),
                                            CommonTextWidget(
                                                text: "0%",
                                                textColor: Colors.green),
                                          ],
                                        )
                                      ],
                                    ))
                                  ],
                                ),
                                const Divider(
                                  thickness: 0.3,
                                ),
                                commonInkWell(
                                    child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 8),
                                  child: CommonTextWidget(
                                    text: "View All Answer",
                                    textColor: AppColors.colorAmber,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ))
                              ],
                            ),
                          )),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: commonList(
                                    child: Container(
                                  height: size.height * 0.05,
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CommonTextWidget(
                                        fontWeight: FontWeight.w500,
                                        text: "Dr. Bhavesh Gohil",
                                      ),
                                      Row(
                                        children: [
                                          CommonTextWidget(
                                            text: "Unavailable",
                                            textColor: Colors.grey,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Switch(
                                            activeColor: Colors.white,
                                            inactiveTrackColor: Colors.white,
                                            inactiveThumbColor: Colors.grey,
                                            activeTrackColor:
                                                AppColors.colorGreen,
                                            value: provider.isOn,
                                            onChanged: (value) {
                                              provider.toggleSwitch();
                                            },
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                  child: Expanded(
                                child: commonList(
                                    child: Container(
                                  height: size.height * 0.05,
                                  padding: const EdgeInsets.only(
                                      left: 15.0,
                                      right: 15,
                                      top: 10,
                                      bottom: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CommonTextWidget(
                                        fontWeight: FontWeight.w500,
                                        text: "Total People Helped",
                                      ),
                                      Row(
                                        children: [
                                          CommonTextWidget(
                                            text: "5",
                                            textColor: Colors.black,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Icon(
                                            Icons.favorite,
                                            color: AppColors.colorAmber,
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                )),
                              ))
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: commonView(
                                    isMobile: isMobile,
                                    size: size,
                                    title: "Guide for Online Consultation",
                                    desc:
                                        "Video guide and more on how to consult online with patients on Practo",
                                    isBthHide: true,
                                    btnText: "VIEW"),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                  child: commonView(
                                size: size,
                                isMobile: isMobile,
                              ))
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: commonView(
                                    isMobile: isMobile,
                                    size: size,
                                    title: "Q&A is enabled",
                                    desc:
                                        "You will now receive free questions pertaining to your speciality. You can change this in settings.",
                                    btnText: "GO IT"),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: commonList(
                                    child: Container(
                                  height: isDesktop
                                      ? size.height * 0.3
                                      : size.height * 0.18,
                                  padding: const EdgeInsets.only(
                                      left: 15.0,
                                      right: 15,
                                      top: 10,
                                      bottom: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CommonTextWidget(
                                        marginBottom: 10,
                                        fontWeight: FontWeight.w500,
                                        text:
                                            "Tips for a great consult experience",
                                      ),
                                      const Divider(
                                        thickness: 0.3,
                                      ),
                                      ListView.separated(
                                        shrinkWrap: true,
                                        itemCount: 2,
                                        itemBuilder: (context, index) {
                                          return ListTile(
                                            dense: true,
                                            contentPadding: EdgeInsets.zero,
                                            leading: const Icon(
                                              Icons.check_circle,
                                              color: Colors.green,
                                            ),
                                            title: CommonTextWidget(
                                              text:
                                                  "Explaining everything in detail to the patients",
                                            ),
                                          );
                                        },
                                        separatorBuilder:
                                            (BuildContext context, int index) {
                                          return const Divider(
                                            thickness: 0.3,
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                )),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: commonList(
                                    child: Container(
                                  height: isDesktop
                                      ? size.height * 0.29
                                      : size.height * 0.18,
                                  padding: const EdgeInsets.only(
                                      left: 15.0,
                                      right: 15,
                                      top: 10,
                                      bottom: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Flexible(
                                            child: CommonTextWidget(
                                              fontWeight: FontWeight.w500,
                                              text: "Answer Insight",
                                            ),
                                          ),
                                          const Icon(
                                            Icons.info_outline,
                                            color: Colors.grey,
                                          )
                                        ],
                                      ),
                                      const Divider(
                                        thickness: 0.3,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                              child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CommonTextWidget(
                                                text: "Answer View",
                                                left: 10,
                                                textColor: Colors.grey,
                                              ),
                                              CommonTextWidget(
                                                text: "0",
                                                fontSize: 20,
                                                left: 10,
                                                top: 10,
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Icon(
                                                    Icons.arrow_drop_up_sharp,
                                                    color: Colors.green,
                                                  ),
                                                  CommonTextWidget(
                                                      text: "0%",
                                                      textColor: Colors.green),
                                                ],
                                              )
                                            ],
                                          )),
                                          Expanded(
                                              child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CommonTextWidget(
                                                text: "People Helped",
                                                left: 10,
                                                textColor: Colors.grey,
                                              ),
                                              CommonTextWidget(
                                                text: "0",
                                                fontSize: 20,
                                                left: 10,
                                                top: 10,
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Icon(
                                                    Icons.arrow_drop_up_sharp,
                                                    color: Colors.green,
                                                  ),
                                                  CommonTextWidget(
                                                      text: "0%",
                                                      textColor: Colors.green),
                                                ],
                                              )
                                            ],
                                          ))
                                        ],
                                      ),
                                      const Divider(
                                        thickness: 0.3,
                                      ),
                                      commonInkWell(
                                          child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, bottom: 8),
                                        child: CommonTextWidget(
                                          text: "View All Answer",
                                          textColor: AppColors.colorAmber,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ))
                                    ],
                                  ),
                                )),
                              )
                            ],
                          )
                        ],
                      ),
              ],
            ),
          ),
        ),
      );
    });
  }

  commonView(
      {String? title,
      String? desc,
      bool isBthHide = false,
      String? btnText,
      required bool isMobile,
      required Size size}) {
    return commonList(
        child: Container(
      width: size.width,
      decoration: commonBoxDecoration(
          border: Border.all(
              color: Colors.grey.withValues(alpha: 0.50),
              width: isMobile ? 1 : 0)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: size.width,
            color: Colors.white,
            padding: const EdgeInsets.all(15.0),
            child: CommonTextWidget(
              fontWeight: FontWeight.w500,
              text: title ?? "Bank details verified",
            ),
          ),
          Container(
            color: AppColors.colorBG,
            width: size.width,
            alignment: Alignment.center,
            height: size.height * 0.15,
            padding: const EdgeInsets.all(20.0),
            child: CommonTextWidget(
              fontWeight: FontWeight.w600,
              text: desc ??
                  "Your bank details have been verified, If you'd like to change these you can do so from settings.",
              textColor: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                isBthHide
                    ? const SizedBox.shrink()
                    : Align(
                        alignment: Alignment.topRight,
                        child: commonInkWell(
                            child: CommonTextWidget(
                          text: "GO TO SETTINGS",
                          fontSize: 12,
                          textColor: AppColors.colorAmber,
                          fontWeight: FontWeight.w700,
                        )),
                      ),
                isBthHide
                    ? const SizedBox.shrink()
                    : const SizedBox(
                        width: 50,
                      ),
                Align(
                  alignment: Alignment.topRight,
                  child: commonInkWell(
                      child: CommonTextWidget(
                    text: btnText ?? "GO TO SETTINGS",
                    fontSize: 12,
                    textColor: AppColors.colorAmber,
                    fontWeight: FontWeight.w700,
                  )),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
