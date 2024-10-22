import 'package:doctor_app/core/color_utils.dart';
import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:flutter/material.dart';

class CommonSideMenu extends StatefulWidget {
  const CommonSideMenu({super.key,required this.list,this.onTap,});
  final List<Map<String, dynamic>> list;

 final VoidCallback ?onTap;

  @override
  State<CommonSideMenu> createState() => _CommonSideMenuState();
}

class _CommonSideMenuState extends State<CommonSideMenu> {

  final int selectedOuterIndex=0;
  final int? selectedInnerIndex=0;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Container(
      height: size.height,

      decoration: const BoxDecoration(
        color: colorBG,
        /*  border: Border.a(vertical: BorderSide(
                              color: Colors.red,width:1
                            ))*/
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.list.length, // Number of outer list items
        itemBuilder: (context, outerIndex) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Outer list title
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CommonTextWidget(

                  text:widget.list[outerIndex]['title'],
                  fontSize: 16, fontWeight: FontWeight.bold,
                ),
              ),

              // Inner ListView
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.list[outerIndex]['items'].length,
                itemBuilder: (context, innerIndex) {
                  bool isSelected = selectedOuterIndex == outerIndex && selectedInnerIndex == innerIndex;
                  return GestureDetector(
                    onTap: widget.onTap/*() {
                      setState(() {

                        provider.setPatientDetailsPage = '${outerList[outerIndex]['items'][innerIndex]}';
                        print('======${innerIndex}');
                        print('======${outerList[outerIndex]['items'][innerIndex]}');
                        selectedOuterIndex = outerIndex;
                        selectedInnerIndex = innerIndex;
                        //selectedInnerIndex[outerIndex] = innerIndex;
                      });
                    }*/,
                    child: Container(
                      color: isSelected ? AppColors.primary.withOpacity(0.50) : colorBG,
                      padding: const EdgeInsets.all(10.0),
                      child: CommonTextWidget(
                          textColor: isSelected?Colors.white:null,
                          text:
                          widget.list[outerIndex]['items'][innerIndex],
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
    );
  }
}
