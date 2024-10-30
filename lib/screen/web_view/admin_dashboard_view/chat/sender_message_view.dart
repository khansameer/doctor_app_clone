import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';

import 'package:flutter/material.dart';

class SenderMessageView extends StatelessWidget {
  const SenderMessageView({super.key,this.msg});
 final  String ? msg;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [

            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CommonTextWidget(text: "You, 01:15 PM",right: 10,fontSize: 12,),
                Container(

                  decoration: BoxDecoration(
                    color: AppColors.colorBgNew,
                    borderRadius: BorderRadius.circular(8)
                  ),
                  margin: const EdgeInsets.only(left: 15, top: 5),
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [


                      CommonTextWidget(text: msg,)
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(width: 20,),
          ],
        ),
      ),
    );
  }
}
