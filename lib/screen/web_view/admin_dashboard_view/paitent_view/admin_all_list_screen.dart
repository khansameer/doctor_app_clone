import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_app/core/color_utils.dart';
import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/CustomAlertDialog.dart';

import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/image/image_path.dart';
import 'package:doctor_app/provider/admin_dashboard_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'admin_patient_details_view.dart';

class AdminAllListScreen extends StatefulWidget {
  const AdminAllListScreen({super.key,this.title});

  final String? title;

  @override
  State<AdminAllListScreen> createState() => _AdminAllListScreenState();
}

class _AdminAllListScreenState extends State<AdminAllListScreen> {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.title == "all") {
        context.read<AdminDashboardProvider>().clearFilter();
      }
      else if (widget.title == "all_male") {
        context.read<AdminDashboardProvider>().filterByGender("male");
        //provider.filterBYGenders(gender: 'male');
      }
      else if (widget.title == "all_female") {
        context.read<AdminDashboardProvider>().filterByGender("female");
        //provider.filterBYGenders(gender: 'male');
      }
    });

    return Consumer<AdminDashboardProvider>(
        builder: (context, provider, child) {

      return ListView(
        children: [
          Column(
            children: [

              Container(
                padding: const EdgeInsets.all(15.0),
                color: AppColors.colorBgNew,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(26, (index) {
                    final letter = String.fromCharCode(65 + index); // ASCII value of A is 65
                    final isAvailable = provider.availableLetters.contains(letter);

                    return GestureDetector(
                      onTap: isAvailable
                          ? () => provider.selectLetter(letter)
                          : null,
                      child: Container(

                        margin: const EdgeInsets.all(8),
                      //  padding: const EdgeInsets.all(0.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: isAvailable ? Colors.white : null
                        ),

                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: CommonTextWidget(
                            text: letter,

                              textColor: isAvailable ? AppColors.colorBlue :  AppColors.colorTextNew,
                              fontWeight: isAvailable ? FontWeight.w600 : FontWeight.w600,

                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: provider.patients.length,
                  itemBuilder: (context, index) {
                    var data = provider.patients[index];
                    return Container(
                      decoration: BoxDecoration(
                          color:AppColors.colorListView, borderRadius: BorderRadius.circular(8)),
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(15),
                      child: ListTile(

                        titleAlignment: ListTileTitleAlignment.threeLine,
                        contentPadding: EdgeInsets.zero,
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(

                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 25.0, right: 25,top: 0,bottom: 0),
                                  child: CommonTextWidget(
                                    text:
                                        data.isActive == false ? "InActive".toUpperCase() : "Active".toUpperCase(),
                                    textColor: data.isActive == false
                                        ? Colors.red
                                        : Colors.green,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),

                            Container(
                              width: 50,
                              height: 50,

                              decoration: const BoxDecoration(
                                  color: Colors.white,

                              shape: BoxShape.circle
                              ),
                              child: const Center(
                                child:Icon(Icons.chat,size: 20,
                                color: Colors.grey,),
                              ),
                            ),
                            const SizedBox(width: 10,),
                            Flexible(
                              child: Container(
                                alignment: Alignment.topLeft,
                                width: 50,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle),
                                height: 50,
                                child: const Center(
                                  child: Icon(
                                    size: 20,
                                    Icons.call_sharp,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10,),
                            commonInkWell(

                              onTap: () {
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return const CustomAlertDialog(
                                        content: AdminPatientDetailsView(),
                                      );
                                    });
                              },
                              child: Container(
                                margin: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Center(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(left: 20.0, right: 20),
                                    child: CommonTextWidget(
                                      text: "View Profile",
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: setAssetImage(
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                            image: icDummyUser,
                          ) /*commonImageNetworkWidget(path: provider.patients[index].photo)*/,
                        ),
                        title: CommonTextWidget(
                          text: '${data.name.toString()} (${data.gender.toString().toUpperCase()[0]})',
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                        subtitle: CommonTextWidget(
                          text: "28 years",
                          top: 5,
                          fontSize: 13,
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ],
      );
    });
  }
}
