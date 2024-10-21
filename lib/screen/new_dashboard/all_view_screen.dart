
import 'package:doctor_app/provider/calender_provider.dart';
import 'package:doctor_app/screen/new_dashboard/appointments_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/component/component.dart';

class AllViewScreen extends StatelessWidget {
  const AllViewScreen({super.key,required this.data,required this.appointments});
  final String data;
  final List<Appointments>? appointments;
  @override
  Widget build(BuildContext context) {


    var size = MediaQuery.sizeOf(context);
    return SizedBox(
      width: size.width,
      height: size.height,
      child: ListView(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(child: commonView(textValue: appointments!=null?'${appointments?.length}':"0")),
                    const VerticalDivider(
                      thickness: 0.3,
                    ),
                    Expanded(
                        child: commonView(
                      color: Colors.red,
                      textValue: "0",
                      title: "Waiting".toUpperCase(),
                    )),
                    const VerticalDivider(
                      thickness: 0.3,
                    ),
                    Expanded(
                        child: commonView(
                      title: "Engaged".toUpperCase(),
                      color: Colors.cyan,
                      textValue: "0",
                    )),
                    const VerticalDivider(
                      thickness: 0.3,
                    ),
                    Expanded(
                        child: commonView(
                            title: "Done".toUpperCase(),
                            color: Colors.green,
                            textValue: "0")),
                  ],
                ),
              ),
              Consumer<CalenderProvider>(
                builder: (context,provider,child) {
                  return ListView.separated(
                    itemCount: appointments!=null?appointments!.length:0,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var data=appointments?[index];
                      DateTime dateTime = DateTime.parse('${data?.dateTime.toString()}');

                      // Extract time components
                      int hour = dateTime.hour;
                      int minute = dateTime.minute;
                      int second = dateTime.second;
                      int millisecond = dateTime.millisecond;
                      String amPm = hour >= 12 ? 'PM' : 'AM';

                      return ListTile(
                        titleAlignment: ListTileTitleAlignment.top,
                        leading: commonText(
                            //text: "10:24 AM",
                            text: '${hour}:${minute}:${second}:$amPm',
                            fontSize: 12,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400),
                        title: commonText(text: "David", color: Colors.black),
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            commonText(
                                text: '${data?.reason.toString()}',
                                color: Colors.grey,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                            commonText(
                                text: "Dr.Richard",
                                fontSize: 12,
                                color: Colors.grey,
                                fontWeight: FontWeight.w400)
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(
                        thickness: 0.3,
                      );
                    },
                  );
                }
              )
            ],
          ),
        ],
      ),
    );
  }

  commonView({String? title, Color? color, String? textValue}) {
    return Column(
      children: [
        commonText(text: title ?? "Today".toUpperCase(), fontSize: 12),
        const SizedBox(
          height: 5,
        ),
        Container(
          width: 40,
          height: 25,
          decoration: commonBoxDecoration(
              color: color ?? Colors.grey,
              borderRadius: BorderRadius.circular(3)),
          child: Center(
            child: commonText(
                text: textValue ?? "12", color: Colors.white, fontSize: 10),
          ),
        )
      ],
    );
  }
}
