import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/common_button_widget.dart';
import 'package:doctor_app/core/common/common_drop_down_view.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/common/common_textfield.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/image/image_path.dart';
import 'package:doctor_app/core/responsive.dart';
import 'package:doctor_app/provider/dashboard_provider.dart';
import 'package:doctor_app/provider/report_provier.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminFeedbackScreen extends StatefulWidget {
  const AdminFeedbackScreen({super.key});

  @override
  State<AdminFeedbackScreen> createState() => _AdminFeedbackScreenState();
}

class _AdminFeedbackScreenState extends State<AdminFeedbackScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DashboardProvider>().getUserName();
    });

    super.initState();
  }
  List<int?> ratings = List<int?>.filled(5, null); // Stores ratings for each aspect
  String? initialImpression;
  String? productDuration;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    var isMobile=Responsive.isMobile(context);
    return SizedBox(
      width: size.width,
      height: size.height,
      child: isMobile?ListView(
        children: [
          Column(
            children: [
            Container(

              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8)
              ),

              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CommonTextWidget(
                      letterSpacing: 1,
                      top: 15,
                      text: "Patient's feedback",
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0, top: 10),
                          child: CommonTextWidget(
                            text: "Corey Augilar",
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: AppColors.colorBgNew.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(8)),
                          child: ListTile(
                            title: CommonTextWidget(
                              fontWeight: FontWeight.w600,
                              text: context.read<DashboardProvider>().name,
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.thumb_up,
                                    size: 15,
                                    color: Colors.green,
                                  ),
                                  CommonTextWidget(
                                    text: "99%",
                                    left: 5,
                                    textColor: Colors.green,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  CommonTextWidget(
                                    text: "4 star",
                                    left: 2,
                                    fontSize: 12,
                                    textColor: Colors.grey,
                                    fontWeight: FontWeight.w400,
                                  )
                                ],
                              ),
                            ),
                            trailing: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.message_rounded,
                                    size: 18,
                                    color: Colors.black,
                                  ),
                                  CommonTextWidget(
                                    text: "72 feedback",
                                    left: 2,
                                    fontSize: 13,
                                    textColor: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  )
                                ],
                              ),
                            ),
                            leading: commonProfileIcon(
                                width: 40, path: icPatientUser1, height: 40),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        // Row(
                        //   mainAxisSize: MainAxisSize.min,
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   crossAxisAlignment: CrossAxisAlignment.center,
                        //   children: [
                        //     Padding(
                        //       padding: const EdgeInsets.only(left: 15.0, top: 0),
                        //       child: CommonTextWidget(
                        //         text: "Other from",
                        //         textColor: Colors.grey,
                        //       ),
                        //     ),
                        //     const SizedBox(
                        //       width: 10,
                        //     ),
                        //     Expanded(
                        //       child: SizedBox(
                        //         width: size.width,
                        //         child: Consumer<ReportProvider>(
                        //             builder: (context, provider, child) {
                        //               return CommonDropDownView(
                        //                   hint: "All Center",
                        //                   height: 35,
                        //                   horizontal: 10,
                        //                   onChanged: (value) {
                        //                     provider.setSelectData = value.toString();
                        //                   },
                        //                   selectedValue: provider.selectedValue,
                        //                   borerColor: Colors.grey,
                        //                   size: size,
                        //                   items: provider.topMedicalCallCenters);
                        //             }),
                        //       ),
                        //     ),
                        //     const SizedBox(
                        //       width: 10,
                        //     ),
                        //   ],
                        // ),
                        Container(
                          padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: AppColors.colorBgNew.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(8)),
                          child: ListTile(
                            title: CommonTextWidget(
                              fontWeight: FontWeight.w600,
                              text: "Emily Davis",
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.thumb_up,
                                    size: 15,
                                    color: Colors.green,
                                  ),
                                  CommonTextWidget(
                                    text: "80%",
                                    left: 5,
                                    textColor: Colors.green,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  CommonTextWidget(
                                    text: "(180 Votes)",
                                    left: 2,
                                    fontSize: 12,
                                    textColor: Colors.grey,
                                    fontWeight: FontWeight.w400,
                                  )
                                ],
                              ),
                            ),
                            trailing: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.message_rounded,
                                    size: 18,
                                    color: Colors.black,
                                  ),
                                  CommonTextWidget(
                                    text: "28 feedback",
                                    left: 2,
                                    fontSize: 13,
                                    textColor: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  )
                                ],
                              ),
                            ),
                            leading: commonProfileIcon(
                                width: 40, path: icPatientUser8, height: 40),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 15,),
            Container(

              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8)
              ),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CommonTextWidget(
                      letterSpacing: 1,
                      top: 15,
                      text: "Feedback",
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0,right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonTextWidget(
                          letterSpacing: 1,
                          top: 14,
                          text:  'Rate the product based on the following aspects:',
                          fontSize: 16, fontWeight: FontWeight.w500,
                        ),
                        CommonTextWidget(
                          letterSpacing: 1,
                          top: 5,
                          text:  '(Poor) 1--2--3--4--5 (Excellent)',
                          fontSize: 16, fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  _buildRatingRow("Product feature", 0),
                  _buildRatingRow("Product design", 1),
                  _buildRatingRow("Product quality", 2),
                  _buildRatingRow("Product usefulness", 3),
                  _buildRatingRow("Product uniqueness", 4),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0,right: 10),
                    child: CommonTextWidget(
                      letterSpacing: 1,
                      top: 14,
                      text:  'What was your initial impression of the product?',
                      fontSize: 16, fontWeight: FontWeight.w500,
                    ),
                  ),

                  _buildRadioGroup(
                    options: ["Unsatisfactory", "Poor", "Fair", "Good", "Excellent"],
                    groupValue: initialImpression,
                    onChanged: (value) => setState(() => initialImpression = value),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0,right: 10),
                    child: CommonTextWidget(
                      letterSpacing: 1,
                      top: 14,
                      text:  "How long have you had the product?",
                      fontSize: 16, fontWeight: FontWeight.w500,
                    ),
                  ),

                  _buildRadioGroup(
                    options: [
                      "Less than a week",
                      "A week to a month",
                      "A month to half a year",
                      "Half a year to a year",
                      "Over a year"
                    ],
                    groupValue: productDuration,
                    onChanged: (value) => setState(() => productDuration = value),
                  ),
                  SizedBox(height: 20),

                  Padding(
                    padding: const EdgeInsets.only(left: 10.0,right: 10),
                    child: CommonTextWidget(
                      letterSpacing: 1,
                      top: 14,
                      text:  "Message",
                      fontSize: 16, fontWeight: FontWeight.w500,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CommonTextField(
                      colorFill: Colors.white,
                      inputTypes: TextInputType.text,
                      borderColor: Colors.grey,
                      maxLines: 3,
                    ),
                  ),

                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0,right: 10),
                        child: CommonButtonWidget(
                          text: "Send",
                          padding: EdgeInsets.only(left: 40,right: 40,top: 20,bottom: 20),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )

          ],),
        ],
      ):Row(
        children: [
          Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8)
            ),
            height: size.height,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CommonTextWidget(
                    letterSpacing: 1,
                    top: 0,
                    text: "Patient's Feedback",
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, top: 10),
                        child: CommonTextWidget(
                          text: "",
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: AppColors.colorBgNew.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(8)),
                        child: ListTile(
                          title: CommonTextWidget(
                            fontWeight: FontWeight.w600,
                            text: 'Corey Aguilar',
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.star,
                                  size: 15,
                                  color: Colors.green,
                                  fill: 1.0,
                                  grade: 1.0,
                                  weight: 1.0,
                                  
                                ),
                                Icon(
                                  Icons.star,
                                  size: 15,
                                  color: Colors.green,
                                ),
                                Icon(
                                  Icons.star,
                                  size: 15,
                                  color: Colors.green,
                                ),
                                Icon(
                                  Icons.star,
                                  size: 15,
                                  color: Colors.green,
                                ),
                                CommonTextWidget(
                                  text: "4 star",
                                  left: 2,
                                  fontSize: 12,
                                  textColor: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                )
                              ],
                            ),
                          ),
                          trailing: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.message_rounded,
                                  size: 18,
                                  color: Colors.black,
                                ),
                                CommonTextWidget(
                                  text: "Overall Richard did a great job. The process was smooth and I was kept well informed about what to expect. So far the healing has also gone well and I am mostly back to normal",
                                  left: 2,
                                  fontSize: 13,
                                  textColor: Colors.black,
                                  fontWeight: FontWeight.w500,
                                )
                              ],
                            ),
                          ),
                          leading: commonProfileIcon(
                              width: 40, path: icPatientUser1, height: 40),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: AppColors.colorBgNew.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(8)),
                        child: ListTile(
                          title: CommonTextWidget(
                            fontWeight: FontWeight.w600,
                            text: 'Samantha Lee',
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.star,
                                  size: 15,
                                  color: Colors.green,
                                  fill: 1.0,
                                  grade: 1.0,
                                  weight: 1.0,
                                  
                                ),
                                Icon(
                                  Icons.star,
                                  size: 15,
                                  color: Colors.green,
                                ),
                                Icon(
                                  Icons.star_half_sharp,
                                  size: 15,
                                  color: Colors.green,
                                ),
                                CommonTextWidget(
                                  text: "3.5 star",
                                  left: 2,
                                  fontSize: 12,
                                  textColor: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                )
                              ],
                            ),
                          ),
                          trailing: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.message_rounded,
                                  size: 18,
                                  color: Colors.black,
                                ),
                                CommonTextWidget(
                                  text: "Dr Richard was wonderful to deal with. He was polite, friendly and professional and I felt extremely safe and assured under his care.",
                                  left: 2,
                                  fontSize: 13,
                                  textColor: Colors.black,
                                  fontWeight: FontWeight.w500,
                                )
                              ],
                            ),
                          ),
                          leading: commonProfileIcon(
                              width: 40, path: icPatientUser2, height: 40),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      // Row(
                      //   mainAxisSize: MainAxisSize.min,
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   children: [
                      //     Padding(
                      //       padding: const EdgeInsets.only(left: 15.0, top: 0),
                      //       child: CommonTextWidget(
                      //         text: "Other from",
                      //         textColor: Colors.grey,
                      //       ),
                      //     ),
                      //     const SizedBox(
                      //       width: 10,
                      //     ),
                      //     SizedBox(
                      //       width: size.width * 0.14,
                      //       child: Consumer<ReportProvider>(
                      //           builder: (context, provider, child) {
                      //         return CommonDropDownView(
                      //             hint: "All Center",
                      //             height: 35,
                      //             horizontal: 10,
                      //             onChanged: (value) {
                      //               provider.setSelectData = value.toString();
                      //             },
                      //             selectedValue: provider.selectedValue,
                      //             borerColor: Colors.grey,
                      //             size: size,
                      //             items: provider.topMedicalCallCenters);
                      //       }),
                      //     ),
                      //   ],
                      // ),
                      // Container(
                      //   padding: const EdgeInsets.all(20),
                      //   margin: const EdgeInsets.all(10),
                      //   decoration: BoxDecoration(
                      //       color: AppColors.colorBgNew.withOpacity(0.4),
                      //       borderRadius: BorderRadius.circular(8)),
                      //   child: ListTile(
                      //     title: CommonTextWidget(
                      //       fontWeight: FontWeight.w600,
                      //       text: "Emily Davis",
                      //     ),
                      //     subtitle: Padding(
                      //       padding: const EdgeInsets.only(top: 8.0),
                      //       child: Row(
                      //         mainAxisSize: MainAxisSize.min,
                      //         children: [
                      //           const Icon(
                      //             Icons.thumb_up,
                      //             size: 15,
                      //             color: Colors.green,
                      //           ),
                      //           CommonTextWidget(
                      //             text: "80%",
                      //             left: 5,
                      //             textColor: Colors.green,
                      //             fontWeight: FontWeight.w700,
                      //           ),
                      //           CommonTextWidget(
                      //             text: "(180 Votes)",
                      //             left: 2,
                      //             fontSize: 12,
                      //             textColor: Colors.grey,
                      //             fontWeight: FontWeight.w400,
                      //           )
                      //         ],
                      //       ),
                      //     ),
                      //     trailing: Padding(
                      //       padding: const EdgeInsets.only(top: 8.0),
                      //       child: Row(
                      //         mainAxisSize: MainAxisSize.min,
                      //         children: [
                      //           const Icon(
                      //             Icons.message_rounded,
                      //             size: 18,
                      //             color: Colors.black,
                      //           ),
                      //           CommonTextWidget(
                      //             text: "28 feedback",
                      //             left: 2,
                      //             fontSize: 13,
                      //             textColor: Colors.black,
                      //             fontWeight: FontWeight.w500,
                      //           )
                      //         ],
                      //       ),
                      //     ),
                      //     leading: commonProfileIcon(
                      //         width: 40, path: icPatientUser8, height: 40),
                      //   ),
                      // ),
                    ],
                  ),
                )
              ],
            ),
          )),
          SizedBox(width: 15,),
          // Expanded(
          //     child: Container(
          //     padding: EdgeInsets.all(10),
          //       decoration: BoxDecoration(
          //           color: Colors.white,
          //           borderRadius: BorderRadius.circular(8)
          //       ),
          //       height: size.height,
          //       child: ListView(
          //         children: [
          //          Padding(
          //             padding: const EdgeInsets.all(10.0),
          //             child: CommonTextWidget(
          //               letterSpacing: 1,
          //               top: 0,
          //               text: "Feedback",
          //               fontSize: 20,
          //               fontWeight: FontWeight.w700,
          //             ),
          //           ),
          //           Padding(
          //             padding: const EdgeInsets.only(left: 10.0,right: 10),
          //             child: Column(
          //               mainAxisAlignment: MainAxisAlignment.start,
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 CommonTextWidget(
          //                   letterSpacing: 1,
          //                   top: 14,
          //                  text:  'Rate the product based on the following aspects:',
          //                   fontSize: 16, fontWeight: FontWeight.w500,
          //                 ),
          //                 CommonTextWidget(
          //                   letterSpacing: 1,
          //                   top: 5,
          //                   text:  '(Poor) 1--2--3--4--5 (Excellent)',
          //                   fontSize: 16, fontWeight: FontWeight.w500,
          //                 ),
          //               ],
          //             ),
          //           ),
          //           SizedBox(height: 10),
          //           _buildRatingRow("Product feature", 0),
          //           _buildRatingRow("Product design", 1),
          //           _buildRatingRow("Product quality", 2),
          //           _buildRatingRow("Product usefulness", 3),
          //           _buildRatingRow("Product uniqueness", 4),
          //           SizedBox(height: 20),
          //           Padding(
          //             padding: const EdgeInsets.only(left: 10.0,right: 10),
          //             child: CommonTextWidget(
          //               letterSpacing: 1,
          //               top: 14,
          //               text:  'What was your initial impression of the product?',
          //               fontSize: 16, fontWeight: FontWeight.w500,
          //             ),
          //           ),

          //           _buildRadioGroup(
          //             options: ["Unsatisfactory", "Poor", "Fair", "Good", "Excellent"],
          //             groupValue: initialImpression,
          //             onChanged: (value) => setState(() => initialImpression = value),
          //           ),
          //           SizedBox(height: 20),
          //           Padding(
          //             padding: const EdgeInsets.only(left: 10.0,right: 10),
          //             child: CommonTextWidget(
          //               letterSpacing: 1,
          //               top: 14,
          //               text:  "How long have you had the product?",
          //               fontSize: 16, fontWeight: FontWeight.w500,
          //             ),
          //           ),

          //           _buildRadioGroup(
          //             options: [
          //               "Less than a week",
          //               "A week to a month",
          //               "A month to half a year",
          //               "Half a year to a year",
          //               "Over a year"
          //             ],
          //             groupValue: productDuration,
          //             onChanged: (value) => setState(() => productDuration = value),
          //           ),
          //           SizedBox(height: 20),

          //           Padding(
          //             padding: const EdgeInsets.only(left: 10.0,right: 10),
          //             child: CommonTextWidget(
          //               letterSpacing: 1,
          //               top: 14,
          //               text:  "Message",
          //               fontSize: 16, fontWeight: FontWeight.w500,
          //             ),
          //           ),
          //           Padding(
          //             padding: const EdgeInsets.all(10.0),
          //             child: CommonTextField(
          //               colorFill: Colors.white,
          //               inputTypes: TextInputType.text,
          //               borderColor: Colors.grey,
          //               maxLines: 3,
          //             ),
          //           ),

          //           Row(
          //             mainAxisSize: MainAxisSize.min,
          //             mainAxisAlignment: MainAxisAlignment.end,
          //             children: [
          //               Padding(
          //                 padding: const EdgeInsets.only(left: 10.0,right: 10),
          //                 child: CommonButtonWidget(
          //                   text: "Send",
          //                   padding: EdgeInsets.only(left: 40,right: 40,top: 20,bottom: 20),
          //                 ),
          //               ),
          //             ],
          //           )
          //         ],
          //       ),
          //     ))
        ],
      )
      ,
    );
  }

  Widget _buildRatingRow(String title, int index) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: CommonTextWidget(text: title,fontSize: 13,),),
          Expanded(
            flex: 7,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List<Widget>.generate(5, (i) {
                return Flexible(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(
                        side: BorderSide(
                          color: Colors.grey,
                          width: 1
                        )
                      ),
                      elevation: 0,
                      foregroundColor: ratings[index] == i + 1 ? Colors.white : Colors.black, backgroundColor: ratings[index] == i + 1 ?AppColors.primary : Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        ratings[index] = i + 1;
                      });
                    },
                    child: CommonTextWidget(text: (i + 1).toString(),textColor:  ratings[index] == i + 1?Colors.white:null,),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  // Widget for radio groups
  Widget _buildRadioGroup({
    required List<String> options,
    required String? groupValue,
    required Function(String?) onChanged,
  }) {
    return Column(
      children: options.map((option) {
        return RadioListTile<String>(
          hoverColor: AppColors.colorBgNew,
          activeColor: AppColors.primary,

          title: CommonTextWidget(text: option,fontSize: 13,),
          value: option,
          groupValue: groupValue,
          onChanged: onChanged,
        );
      }).toList(),
    );
  }

}
