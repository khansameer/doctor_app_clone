import 'package:doctor_app/core/app_constants.dart';
import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/common_button_widget.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/responsive.dart';
import 'package:doctor_app/provider/address_provider.dart';
import 'package:doctor_app/screen/web_view/admin_dashboard_view/my_address/add_my_address_screen.dart';
import 'package:flutter/material.dart';

import '../../../../provider/prescription_provider.dart';

class AddPrescriptionScreen extends StatefulWidget {
  const AddPrescriptionScreen({super.key,required this.isEdit,this.address});
  final bool isEdit;
  final  Prescription? address;

  @override
  State<AddPrescriptionScreen> createState() => _AddMyAddressScreenState();
}

class _AddMyAddressScreenState extends State<AddPrescriptionScreen> {
  var tetMedicine=TextEditingController();
  var tetFrequency=TextEditingController();
  var tetDuration=TextEditingController();
  var tetInstructions=TextEditingController();
  var tetState=TextEditingController();
  var tetZipCode=TextEditingController();
  var tetCountry=TextEditingController();

  @override
  void initState() {

    super.initState();
    if(widget.isEdit){
      tetMedicine.text='${widget.address?.tablet.toString()}';
      tetFrequency.text='${widget.address?.frequency.toString()}';
      tetDuration.text='${widget.address?.duration.toString()}';
      tetInstructions.text='${widget.address?.instructions.toString()}';

    }

  }
  @override
  Widget build(BuildContext context) {
    var isMobile = Responsive.isMobile(context);
    var isDesktop = Responsive.isDesktop(context);
    var isTablet = Responsive.isTablet(context);

    var width = MediaQuery.of(context).size.width;


    return  SizedBox(

      width: isMobile
          ? width * zero9
          : isDesktop
          ? width * 0.3
          :  isTablet?width * 0.3:width * 0.19,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CommonTextWidget(
                          text: widget.isEdit?"Edit Prescription": "Add Prescription",
                          fontSize: 16,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w700,
                          // top: 20,
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(
                              Icons.close,
                              size: 18,
                              color: Colors.black,
                            ))
                      ],
                    ),
                    const SizedBox(height: 20),

                    commonTextFiledView(
                      title: "Medicine Name",
                      topText: 10,
                      maxLines: 3,
                      keyboardType: TextInputType.phone,
                      controller: tetMedicine,
                      topTextField: 10,
                      height: 45,
                      radius: 8,
                    ),
                    commonTextFiledView(
                      title: "Frequency",
                      topText: 10,
                      maxLines: 3,
                      keyboardType: TextInputType.phone,
                      controller: tetFrequency,
                      topTextField: 10,
                      height: 45,
                      radius: 8,
                    ),
                    commonTextFiledView(
                      title: "Duration",
                      topText: 10,
                      maxLines: 3,
                      keyboardType: TextInputType.phone,
                      controller: tetDuration,
                      topTextField: 10,
                      height: 45,
                      radius: 8,
                    ),
                    commonTextFiledView(
                      title: "Instructions",
                      topText: 10,

                      controller: tetInstructions,
                      topTextField: 10,
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      radius: 8,
                    ),


                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CommonButtonWidget(
                          radius: 8,
                          padding: EdgeInsets.only(left: 50,right: 50,top: 15,bottom: 15),
                          height: isMobile ? null : 40,
                          onPressed: () async {

                          },
                          colorButton: AppColors.colorGreen,
                          fontSize: 12,
                          text:  widget.isEdit?"Update":"Add",
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        CommonButtonWidget(
                          text: "Cancel",
                          padding: EdgeInsets.only(left: 50,right: 50,top: 15,bottom: 15),
                          radius: 8,
                          height: isMobile ? null : 40,
                          colorBorder: Colors.black,
                          colorButton: Colors.white,
                          colorText: Colors.black,
                          onPressed: () {
                            Navigator.of(context).pop();

                          },
                          fontSize: 12,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              /*context.watch<AppointmentsProvider>().isAdding
                  ? showLoaderList()
                  : const SizedBox.shrink()*/
            ],
          ),
        ],
      ),
    );
  }
}
