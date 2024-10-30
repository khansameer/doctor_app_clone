import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:flutter/material.dart';

class ReviceMessageView extends StatelessWidget {
  const ReviceMessageView({super.key, this.msg });
final String ?msg;
  @override
  Widget build(BuildContext context) {
    return  Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width - 45,
      ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CommonTextWidget(text: "John Doe, 01:15 PM",left: 15,fontSize: 12,),
            Container(
              decoration: BoxDecoration(
                  color: AppColors.colorBgNew,
                  borderRadius: BorderRadius.circular(8)
              ),
              margin: const EdgeInsets.only(left: 15, top: 5),
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CommonTextWidget(text: msg,)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
