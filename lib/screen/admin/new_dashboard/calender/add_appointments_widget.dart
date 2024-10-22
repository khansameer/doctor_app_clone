import 'package:doctor_app/core/app_constants.dart';
import 'package:doctor_app/core/color_utils.dart';
import 'package:doctor_app/core/common/common_button_widget.dart';
import 'package:doctor_app/core/common/common_drop_down_view.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/responsive.dart';
import 'package:flutter/material.dart';

class AddAppointmentsWidget extends StatefulWidget {
  const AddAppointmentsWidget({super.key,this.dateTime});

 final  DateTime ? dateTime;

  @override
  State<AddAppointmentsWidget> createState() => _AddAppointmentsWidgetState();
}

class _AddAppointmentsWidgetState extends State<AddAppointmentsWidget> {


  var tetDate=TextEditingController();
  var tetTime=TextEditingController();

  @override
  void initState() {
    DateTime? now = widget.dateTime;
    super.initState();
    tetTime.text="${now?.hour}:${now?.minute}:${now?.second}";
    tetDate.text='${now?.year}-${now?.month}-${now?.day}';
  }

  @override
  Widget build(BuildContext context) {
    var isMobile = Responsive.isMobile(context);
    var size =MediaQuery.sizeOf(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SizedBox(

      height: isMobile
          ? height * zero29
          : height * 0.4,
      width: isMobile
          ? width * zero9
          : width * 0.19,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(

          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CommonTextWidget(text: "Add Appointment",fontSize: 16,textAlign: TextAlign.center,fontWeight: FontWeight.w700,
                top: 20,),
            ),

            commonTextFiledView(
                height: 45,
                radius: 8,
                topText: 5,
                controller: tetDate,
                topTextField: 10,
                title: "Date"),
            commonTextFiledView(
                height: 45,
                topText: 10,
                controller: tetTime,
                topTextField: 10,
                radius: 8,
                title: "Time"),
            CommonTextWidget(text: "Select Patient",
              top: 10,),
            const SizedBox(height: 10,),
            CommonDropDownView(
                horizontal: 10,
                height: 45,
                size: size, items: const ["sdsdsdds","sdsds"]),

            commonTextFiledView(title: "Reason",
              topText: 10,
              maxLines: 3,
              topTextField: 10,
              height: 45,
              radius: 8,),
            const SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CommonButtonWidget(
                  onPressed: () async {

                  },
                  colorButton: colorGreen,
                  fontSize: 12,
                  padding: const EdgeInsets.only(left: 40,right: 40,top: 10,bottom: 10),
                  text: "Add",
                ),
                const SizedBox(width: 10,),

                CommonButtonWidget(
                  text: "Cancel",
                  colorBorder: Colors.black,
                  colorButton: Colors.white,
                  colorText: Colors.black,
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  fontSize: 12,
                  padding: const EdgeInsets.only(left: 40,right: 40),
                ),

                const SizedBox(width: 20,)
              ],
            )

          ],
        ),
      ),
    );
  }
}
