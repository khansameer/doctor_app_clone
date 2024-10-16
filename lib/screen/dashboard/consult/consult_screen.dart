import 'package:doctor_app/core/color_utils.dart';
import 'package:doctor_app/core/common/app_scaffold.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/provider/dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConsultScreen extends StatelessWidget {
  const ConsultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(builder: (context, provider, child) {
      return AppScaffold(

        left: 0,
        right: 0,
        appBar: commonAppBar(title: "Consult".toUpperCase(), actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings_outlined)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz))
        ]),
        child: Container(
          color: colorGray.withOpacity(0.20),
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.all(20),
              color: Colors.black,
                child: CommonTextWidget(text: "You're missing out on patients by being unavailable",textColor: Colors.white,fontSize: 12,textAlign: TextAlign.center,),
              ),
              commonList(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0,right: 15),
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
                        const SizedBox(width: 10,),
                        Switch(
                          activeColor: Colors.white,
                          inactiveTrackColor: Colors.white,
                          inactiveThumbColor: Colors.grey,
                          activeTrackColor: colorGreen,
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
              const SizedBox(height: 20,),
              commonList(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0,right: 15,top: 10,bottom: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonTextWidget(
                          fontWeight: FontWeight.w500,
                          text: "Guide for Online Consultation",
                        ),
                        CommonTextWidget(
                          top: 8,
                          text: "Video guide and more on how to consult online with patients on Practo",
                          textColor: Colors.grey,
                        ),
                      Align(
                        alignment:Alignment.topRight,
                        child:   commonInkWell(
                            child: CommonTextWidget(text: "VIEW",
                            fontSize: 12,
                            textColor: colorAmber,
                            fontWeight: FontWeight.w700,)
                        ),
                      )
                      ],
                    ),
                  )),
              const SizedBox(height: 20,),
              commonList(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0,right: 15,top: 10,bottom: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonTextWidget(
                          fontWeight: FontWeight.w500,
                          text: "Bank details verified",
                        ),
                        CommonTextWidget(
                          top: 8,
                          text: "Your bank details have been verified, If you'd like to change these you can do so from settings.",
                          textColor: Colors.grey,
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Align(
                              alignment:Alignment.topRight,
                              child:   commonInkWell(
                                  child: CommonTextWidget(text: "GO TO SETTINGS",
                                    fontSize: 12,
                                    textColor: colorAmber,
                                    fontWeight: FontWeight.w700,)
                              ),
                            ),

                            const SizedBox(width: 50,),
                            Align(
                              alignment:Alignment.topRight,
                              child:   commonInkWell(
                                  child: CommonTextWidget(text: "GO TO SETTINGS",
                                    fontSize: 12,
                                    textColor: colorAmber,
                                    fontWeight: FontWeight.w700,)
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )),

              const SizedBox(height: 20,),

              commonList(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0,right: 15,top: 10,bottom: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonTextWidget(
                          fontWeight: FontWeight.w500,
                          text: "Q&A is enabled",
                        ),
                        CommonTextWidget(
                          top: 8,
                          text: "You will now receive free questions pertaining to your speciality. You can change this in settings.",
                          textColor: Colors.grey,
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Align(
                              alignment:Alignment.topRight,
                              child:   commonInkWell(
                                  child: CommonTextWidget(text: "GO TO SETTINGS",
                                    fontSize: 12,
                                    textColor: colorAmber,
                                    fontWeight: FontWeight.w700,)
                              ),
                            ),

                            const SizedBox(width: 50,),
                            Align(
                              alignment:Alignment.topRight,
                              child:   commonInkWell(
                                  child: CommonTextWidget(text: "GO IT",
                                    fontSize: 12,
                                    textColor: colorAmber,
                                    fontWeight: FontWeight.w700,)
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )),
              const SizedBox(height: 20,),
              commonList(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0,right: 15,top: 10,bottom: 10),
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
                            const SizedBox(width: 10,),
                           const Icon(Icons.favorite,color: colorAmber,)
                          ],
                        )
                      ],
                    ),
                  )),
              const SizedBox(height: 20,),
              commonList(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0,right: 15,top: 10,bottom: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonTextWidget(
                        marginBottom: 10,
                          fontWeight: FontWeight.w500,
                          text: "Tips for a great consult experience",
                        ),

                        const Divider(thickness: 0.3,),
                        ListView.separated(
                            shrinkWrap: true,
                            itemCount: 2,
                            itemBuilder: (context,index){
                            return ListTile(
                              dense: true,
                              contentPadding: EdgeInsets.zero,
                              leading: const Icon(Icons.check_circle,color: Colors.green,),
                              title: CommonTextWidget(text: "Explaining everything in detail to the patients",),
                            );
                        }, separatorBuilder: (BuildContext context, int index) { return const Divider(thickness: 0.3,); },)
                      ],
                    ),
                  )),
              const SizedBox(height: 20,),
              commonList(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0,right: 15,top: 10,bottom: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CommonTextWidget(

                              fontWeight: FontWeight.w500,
                              text: "Answer Insight",
                            ),
                            const Icon(Icons.info_outline,color: Colors.grey,)
                          ],
                        ),

                        const Divider(thickness: 0.3,),
                        Row(
                          children: [
                            Expanded(child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                CommonTextWidget(text: "Answer View",left: 10,textColor: Colors.grey,),
                                CommonTextWidget(text: "0",fontSize: 20,left: 10,top: 10,),
                                const SizedBox(height: 15,),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(Icons.arrow_drop_up_sharp,color: Colors.green,),
                                    CommonTextWidget(text: "0%",textColor: Colors.green),
                                  ],
                                )
                              ],)),
                            Expanded(child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                              CommonTextWidget(text: "People Helped",left: 10,textColor: Colors.grey,),
                              CommonTextWidget(text: "0",fontSize: 20,left: 10,top: 10,),
                              const SizedBox(height: 15,),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(Icons.arrow_drop_up_sharp,color: Colors.green,),
                                  CommonTextWidget(text: "0%",textColor: Colors.green),
                                ],
                              )
                            ],))
                          ],
                        ),
                        const Divider(thickness: 0.3,),

                        commonInkWell(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0,bottom: 8),
                            child: CommonTextWidget(text: "View All Answer",textColor: colorAmber,fontWeight: FontWeight.w700,),
                          )
                        )
                      ],
                    ),
                  )),
              const SizedBox(height: 20,),
            ],
          ),
        ),
      );
    });
  }


}
