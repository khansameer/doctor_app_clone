import 'package:doctor_app/core/color_utils.dart';
import 'package:doctor_app/core/common/app_scaffold.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/responsive.dart';
import 'package:doctor_app/core/string/string_utils.dart';
import 'package:flutter/material.dart';

class WeeklyEarningScreen extends StatelessWidget {
  const WeeklyEarningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    var isMobile = Responsive.isMobile(context);
    return AppScaffold(
      left: 0,
      right: 0,
      appBar:  isMobile?PreferredSize(preferredSize: Size.zero, child: Container()):commonAppBar(title: "Weekly Earnings",color: colorBG,colorText:colorText,  leading:commonBackRedirectButton(), ),

      child: Container(
        width: size.width,
        color: isMobile?colorBG:Colors.white,
        height: size.height,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [

              isMobile?Column(
                children: [
                  _topView(),
                  _bottomView(size: size,isShowLastIndex: true),
                  SizedBox(height: 10,),
                  _bottomView(size: size,colorLine: colorAmber,isShowLastIndex: false,totalText: "Total Instant Earning"),
                ],
              ):Column(
                children: [
                  _topView(),

                  Row(children: [
                    Expanded(child: _bottomView(size: size,isShowLastIndex: true),),
                    Expanded(child:  _bottomView(size: size,colorLine: colorAmber,isShowLastIndex: false,totalText: "Total Instant Earning"),)
                  ],),



                ],
              ),

            ],
          ),
        ),
      ),
    );
  }

  _topView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          dense: true,
          leading: Icon(
            Icons.arrow_back_ios,
            color: Colors.black.withOpacity(0.60),
            size: 20,
          ),
          titleAlignment: ListTileTitleAlignment.center,
          title: CommonTextWidget(
            text: "This week 13 Oct to 19 Oct",
            alignment: Alignment.center,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonTextWidget(
                text: "Total Earnings",
                textColor: Colors.black.withOpacity(0.70),
              ),
              CommonTextWidget(
                text: "$rupee 0.00",
                fontSize: 30,
                fontWeight: FontWeight.w700,
                top: 20,
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _commonRow(),
                  const SizedBox(
                    width: 20,
                  ),
                  _commonRow(
                    text: "Instant Earnings 0%",
                    color: colorAmber,
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  _commonRow({String? text, Color? color}) {
    return Row(
      children: [
        Container(
          width: 15,
          height: 15,
          decoration: commonBoxDecoration(
              color: color ?? Colors.deepPurple, shape: BoxShape.circle),
        ),
        CommonTextWidget(
          text: text ?? "Prime Earnings 0%",
          left: 5,
          textColor: Colors.black.withOpacity(0.70),
          fontSize: 12,
        )
      ],
    );
  }

  _bottomView({required Size size,Color? colorLine,String ?totalText,bool isShowLastIndex=false}) {
    return commonList(
        child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        //height: size.height * 0.24,
        child: Row(
          children: [
            // Vertical line
            Container(
              width: 3, // Width of the vertical line
              height: size.height * 0.24,
              color: colorLine??Colors.purple, // Color of the vertical line
            ),
            const SizedBox(width: 0), // Space between line and text
            // The text part
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0,right: 12,top: 10,bottom: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonTextWidget(
                          text: '$rupee 0',
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                        CommonTextWidget(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          text: totalText??'Total Prime Earnings',
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  // SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0,right: 12,top: 5,bottom: 5),
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonTextWidget(text: 'Amount Paid'),
                          CommonTextWidget(text: '$rupee 0'),
                        ],
                      ),
                      const SizedBox(height: 15,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonTextWidget(text: 'Amount Pending'),
                          CommonTextWidget(text: '$rupee 0'),
                        ],
                      ),
                      const SizedBox(height: 15,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonTextWidget(text: 'Total Connection'),
                          CommonTextWidget(text: '0'),
                        ],
                      ),
                      isShowLastIndex? const SizedBox(height: 15,):SizedBox.shrink(),
                      isShowLastIndex? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonTextWidget(text: 'Completed Connection'),
                          CommonTextWidget(text: '0'),
                        ],
                      ):SizedBox.shrink(),
                    ],),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
