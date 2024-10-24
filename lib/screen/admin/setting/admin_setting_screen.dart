import 'package:doctor_app/core/color_utils.dart';
import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/common_button_widget.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/image/image_path.dart';
import 'package:doctor_app/core/responsive.dart';
import 'package:doctor_app/provider/dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminSettingScreen extends StatefulWidget {
  const AdminSettingScreen({super.key});

  @override
  State<AdminSettingScreen> createState() => _AdminSettingScreenState();
}

class _AdminSettingScreenState extends State<AdminSettingScreen> {
  List<Map<String, dynamic>> outerList = [
  //  {'title': '', 'items': ['Invoice', 'Clinic Address', 'Notification']},
    {'title': '', 'items': ['Procedure Catalog', 'Clinic Address', 'Notification','Consent Forms','Billing','EMR','Prescriptions','Calendar','Communications','Contacts','Email PDF Settings','Medical History']},
  ];

  int selectedOuterIndex = 0;
  int selectedInnerIndex = 0;

  @override
  void initState() {

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DashboardProvider>().getUserName();
      context.read<DashboardProvider>().getEmail();
    });
  }
  getDoctorData()async{

  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    var isMobile=Responsive.isMobile(context);
    return  Consumer<DashboardProvider>(
      builder: (context, provider, child) {
        return Container(
          color: Colors.white,
          width: size.width,
          padding: const EdgeInsets.all(0),
          height: size.height,
          child: ListView(
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      flex: isMobile?3:1,
                      child: Container(
                        padding: EdgeInsets.zero,
                        height: size.height,


                        decoration: const BoxDecoration(
                          color: colorBG,
                        ),
                        child: Column(
                          children: [

                           /* Container(
                              padding: const EdgeInsets.all(20),
                            child:  Column(

                              children: [
                                const Stack(
                                    alignment: Alignment.center,
                                    children: [

                                      Align(
                                          alignment: Alignment.topCenter,
                                          child: SizedBox(
                                            child: CircleAvatar(
                                              radius: 40.0,
                                              backgroundColor: Colors.white,
                                              child: CircleAvatar(
                                                radius: 38.0,
                                                backgroundImage: AssetImage(icDoctorWidget),
                                                child: Align(
                                                  alignment: Alignment.bottomRight,
                                                  child: CircleAvatar(
                                                    backgroundColor: Colors.white,
                                                    radius: 12.0,
                                                    child: Icon(
                                                      Icons.camera_alt,
                                                      size: 15.0,
                                                      color: Color(0xFF404040),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),)
                                      ),
                                    ]
                                ),
                                CommonTextWidget(text:  provider.name ?? "",fontSize: 14,fontWeight: FontWeight.w600,top: 10,),
                                CommonTextWidget(text: provider.email ?? "",fontSize: 12,top: 5,),
                                CommonButtonWidget(text: "Edit",left: 40,right: 40,fontSize: 11,radius: 5,height: 30,top: 15,)
                              ],
                            ),
                            ),
                            const Divider(thickness: 0.3,),
*/
                            ListView.builder(
                              padding: EdgeInsets.zero  ,
                              shrinkWrap: true,
                              itemCount: outerList.length, // Number of outer list items
                              itemBuilder: (context, outerIndex) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: outerList[outerIndex]['items'].length,
                                      itemBuilder: (context, innerIndex) {
                                        bool isSelected = selectedOuterIndex == outerIndex && selectedInnerIndex == innerIndex;
                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              provider.setAdminSettingPagePage = '${outerList[outerIndex]['items'][innerIndex]}';
                                              print('======${innerIndex}');
                                              print('======${outerList[outerIndex]['items'][innerIndex]}');
                                              selectedOuterIndex = outerIndex;
                                              selectedInnerIndex = innerIndex;
                                              //selectedInnerIndex[outerIndex] = innerIndex;
                                            });
                                          },
                                          child: Container(
                                            color: isSelected ? AppColors.primary.withOpacity(0.50) : colorBG,
                                            padding: const EdgeInsets.all(10.0),
                                            child: CommonTextWidget(
                                                textColor: isSelected?Colors.white:null,
                                                text:
                                                outerList[outerIndex]['items'][innerIndex],
                                                fontSize: 12
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      )),

                 Expanded(
                    flex: 8,
                    child: SizedBox(
                      height: size.height,
                      child: provider.currentAdminSettingPage,
                    ),
                  )


                ],
              )
            ],
          ),

        );
      }
    );
  }
}
