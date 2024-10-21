
import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/common/common_textfield.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:flutter/material.dart';

class PatientProfilePage extends StatelessWidget {
  const PatientProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          children: [
            Expanded(
                flex: 5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 10,),
                     Expanded(
                        child: SizedBox(
                      height: 40,
                      child: CommonTextField(
                        hint: "Search Patient Name/ID/Phone number",
                      ),
                    )),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: CommonTextWidget(
                            text: "Advance Search",
                            textColor: AppColors.colorMenuProfile,
                            fontSize: 12))
                  ],
                )),
            Expanded(
                flex: 5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    commonButton(
                      colorText: Colors.black,
                      isShowBorder: true,
                      btnText: "Print Label",
                      onPressed: () {},
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    commonButton(
                      colorText: Colors.black,
                      isShowBorder: true,
                      btnText: "Marge Patients",
                      onPressed: () {},
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    commonButton(
                      colorText: Colors.black,
                      isShowBorder: true,
                      btnText: "Add new patients",
                      onPressed: () {},
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ))
          ],
        ),
        const Divider(
          thickness: 0.3,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 3,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  height: MediaQuery.sizeOf(context).height,
                  color: AppColors.colorMenuProfile1,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      commonText(
                          text: "Patients",
                          left: 0,
                          color: AppColors.colorGreenLight,
                          fontWeight: FontWeight.w700,
                          fontSize: 18),

                      commonRow(padding: 8),
                      commonRow(title: "Recently Visited", isShowBox: false),
                      // Parent expandable menu
                      const SizedBox(
                        height: 5,
                      ),

                      const SizedBox(
                        height: 30,
                      ),
                      commonText(
                          text: "Groups",
                          left: 0,
                          color: AppColors.colorGreenLight,
                          fontWeight: FontWeight.w700,
                          fontSize: 18),

                      commonRow(
                          title: "My Groups",
                          color: AppColors.colorGreenLight,
                          isShowBox: true,
                          boxWidget:
                              commonText(text: "Manage", color: Colors.blue)),

                      const SizedBox(
                        height: 10,
                      ),
                      commonRow(
                          title: "Memberships",
                          isShowBox: false,
                          color: AppColors.colorGreenLight),
                      const SizedBox(
                        height: 10,
                      ),
                      commonRow(
                          title: "Smart Groups",
                          color: AppColors.colorGreenLight,
                          isShowBox: false),
                      const SizedBox(
                        height: 20,
                      ),

                      commonText(
                          text: "Smart Groups",
                          left: 0,
                          color: AppColors.colorGreenLight,
                          fontWeight: FontWeight.w700,
                          fontSize: 18),

                      commonRow(title: "All Female Customer", boxValue: "123"),
                      commonRow(title: "All male Customer", boxValue: "123"),
                      commonRow(
                          title: "Female Customer over 30", boxValue: "123"),
                      commonRow(
                          title: "Female Customer under 30", boxValue: "123"),
                    ],
                  ),
                )),
            Expanded(
              flex: 8,
              child: Container(
                padding: const EdgeInsets.all(10),
                color: Colors.white,
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: 15,
                  itemBuilder: (context, index) {
                    return Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: commonBoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey, width: 1)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            width: MediaQuery.sizeOf(context).width,
                            height: 150 ,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(0),
                            ),
                            child: const Icon(
                              Icons.image,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),

                           Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Top text
                                commonText(
                                  left: 10,
                                text:   'Jhon',

                                ),
                                const Spacer(),
                                // Bottom text
                                commonText(
                                  right: 10,
                                  text: '#0403',
                                ),
                              ],
                            ),
                          )
                          /* commonText(text: "Jhons"),
                          commonText(text: "#301")*/
                        ],
                      ),
                    );
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 2 / 1,
                    crossAxisCount: 3, // Number of columns
                    crossAxisSpacing:
                        10.0, // Horizontal space between grid items
                    mainAxisSpacing: 10.0, // Vertical space between grid items
                    // childAspectRatio: 2 / 3, // Aspect ratio for the grid items
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  commonRow(
      {String? title,
      bool? isShowBox = true,
      String? boxValue,
      double? padding,
      Color? color,
      Widget? boxWidget}) {
    return Padding(
      padding: EdgeInsets.all(padding ?? 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              flex: 7,
              child: commonText(
                  fontSize: 12, text: title ?? "All Patients", color: color)),
          isShowBox == false
              ? const SizedBox.shrink()
              : Expanded(
                  flex: 3,
                  child: boxWidget ??
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: commonBoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.colorGrayLight),
                        child: Center(
                          child: commonText(
                              text: boxValue ?? "1112",
                              color: Colors.white.withOpacity(0.60)),
                        ),
                      )),
        ],
      ),
    );
  }
}
