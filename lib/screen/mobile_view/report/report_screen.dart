import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/app_scaffold.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/responsive.dart';
import 'package:doctor_app/core/string/string_utils.dart';
import 'package:flutter/material.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var isMobile = Responsive.isMobile(context);
    var isDesktop = Responsive.isDesktop(context);
    var size = MediaQuery.sizeOf(context);
    return AppScaffold(
      left: 0,

      right: 0,
      appBar: commonAppBar(
        title: "Report".toUpperCase(),
      ),
      // appBar: commonAppBar(title: "Report".toUpperCase(), actions: []),
      child: Container(
        color: isMobile ? AppColors.colorBG : Colors.white,
        child: ListView(
          children: [
            isMobile
                ? Column(
                    children: [
                      commonList(child: _viewTop()),
                      commonList(child: _viewSMS()),
                      commonList(child: _viewStorage()),
                    ],
                  )
                : Row(
                    children: [
                      Expanded(
                          child: SizedBox(
                        height:
                            isDesktop ? size.height * 0.33 : size.height * 0.2,
                        child: commonList(child: _viewTop()),
                      )),
                      Expanded(
                          child: SizedBox(
                        height:
                            isDesktop ? size.height * 0.33 : size.height * 0.2,
                        child: commonList(child: _viewSMS()),
                      ))
                    ],
                  ),
            const SizedBox(
              height: 30,
            ),
            Container(
              padding: const EdgeInsets.only(
                  top: 15, bottom: 15, left: 10, right: 10),
              decoration: commonBoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      color: Colors.grey.withOpacity(0.50), width: 0)),
              margin: const EdgeInsets.only(left: 0, right: 0, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonTextWidget(
                    left: 5,
                    text: "Showing data for 13 Sep - 13 Oct",
                  ),
                  CommonTextWidget(
                    text: "Change",
                    right: 10,
                    textColor: AppColors.colorAmber,
                    fontWeight: FontWeight.w600,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  commonList({
    String? title,
    Widget? child,
    double? top,
  }) {
    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      decoration: commonBoxDecoration(
          color: Colors.white,
          border:
              Border.all(color: Colors.grey.withOpacity( 0.50), width: 0)),
      margin: EdgeInsets.only(left: 5, right: 5, top: top ?? 10),
      child: child,
    );
  }

  _viewTop() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonTextWidget(
                text: "REVENUE (may include advance)",
                fontSize: 14,
              ),
              Flexible(
                  child: CommonTextWidget(
                text: "vs last 30 days",
                fontSize: 12,
                textColor: Colors.grey,
              ))
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              CommonTextWidget(
                text: "$rupee 19,54,550.00",
                fontSize: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Icon(Icons.arrow_drop_up_sharp, color: Colors.green),
                  CommonTextWidget(
                    text: "7%",
                    textColor: Colors.green,
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          LinearProgressIndicator(
            value: 9,
            minHeight: 6,
            borderRadius: BorderRadius.circular(8),
            backgroundColor: Colors.grey,
            valueColor:
                const AlwaysStoppedAnimation<Color>(AppColors.colorGreen),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonTextWidget(
                      text: "Paid ",
                    ),
                    CommonTextWidget(
                      text: "$rupee 19,50,350.00",
                      fontWeight: FontWeight.w600,
                      textColor: AppColors.colorGreen,
                      top: 10,
                    )
                  ],
                ),
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonTextWidget(
                    text: "Pending ",
                    textColor: Colors.grey,
                  ),
                  CommonTextWidget(
                    text: "$rupee 4,200.00",
                    fontWeight: FontWeight.w600,
                    textColor: Colors.grey,
                    top: 10,
                  )
                ],
              ))
            ],
          )
        ],
      ),
    );
  }

  _viewSMS() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonTextWidget(
                text: "SMS USAGE",
                fontSize: 14,
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          LinearProgressIndicator(
            value: 0.2,
            minHeight: 6,
            borderRadius: BorderRadius.circular(8),
            backgroundColor: AppColors.colorAmber,
            valueColor:
                const AlwaysStoppedAnimation<Color>(AppColors.colorGreen),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonTextWidget(
                      text: "Credit Used ",
                      textColor: Colors.grey,
                    ),
                    CommonTextWidget(
                      text: "56",
                      fontWeight: FontWeight.w600,
                      textColor: AppColors.colorGreen,
                      top: 10,
                    )
                  ],
                ),
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonTextWidget(
                    text: "Credit Left ",
                    textColor: Colors.grey,
                  ),
                  CommonTextWidget(
                    text: "214",
                    fontWeight: FontWeight.w600,
                    textColor: AppColors.colorAmber,
                    top: 10,
                  )
                ],
              ))
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              CommonTextWidget(
                text: "Total SMS:",
              ),
              CommonTextWidget(
                text: "270",
                fontWeight: FontWeight.w600,
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            thickness: 0.3,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonTextWidget(
                text: "View Details",
                textColor: AppColors.colorAmber,
                fontWeight: FontWeight.w700,
              ),
              const Icon(
                Icons.arrow_forward_ios_outlined,
                color: Colors.black,
                size: 20,
              )
            ],
          )
        ],
      ),
    );
  }

  _viewStorage() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonTextWidget(
                text: "STORAGE USAGE",
                fontSize: 14,
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          LinearProgressIndicator(
            value: 0.1,
            minHeight: 6,
            backgroundColor: AppColors.colorAmber,
            borderRadius: BorderRadius.circular(8),
            valueColor:
                const AlwaysStoppedAnimation<Color>(AppColors.colorGreen),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonTextWidget(
                      text: "Storage Used ",
                      textColor: Colors.grey,
                    ),
                    CommonTextWidget(
                      text: "63.85 MB",
                      fontWeight: FontWeight.w600,
                      textColor: AppColors.colorGreen,
                      top: 10,
                    )
                  ],
                ),
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonTextWidget(
                    text: "Storage Left",
                    textColor: Colors.grey,
                  ),
                  CommonTextWidget(
                    text: "960.14 Mb",
                    fontWeight: FontWeight.w600,
                    textColor: AppColors.colorAmber,
                    top: 10,
                  )
                ],
              ))
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              CommonTextWidget(
                text: "Total Storage:",
              ),
              CommonTextWidget(
                text: "1.0 GB",
                fontWeight: FontWeight.w600,
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            thickness: 0.3,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonTextWidget(
                text: "View Details",
                textColor: AppColors.colorAmber,
                fontWeight: FontWeight.w700,
              ),
              const Icon(
                Icons.arrow_forward_ios_outlined,
                color: Colors.black,
                size: 20,
              )
            ],
          )
        ],
      ),
    );
  }
}
