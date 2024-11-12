import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/provider/admin_dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReceiverMessageView extends StatelessWidget {
  const ReceiverMessageView({super.key, this.msg});
  final String? msg;

  @override
  Widget build(BuildContext context) {
    return Align(
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
            /*CommonTextWidget(
              text: msg.toString(),
              */ /*text:
                  "${chatMessage?.sender.toString()}, ${DateFormat('hh:mm a').format(DateTime.parse('${chatMessage?.date.toString()}'))}",
            */ /*  left: 15,
              fontSize: 10,
              top: 20,
            ),*/
            Container(
              decoration: BoxDecoration(
                  color: AppColors.colorBgNew,
                  borderRadius: BorderRadius.circular(8)),
              margin: const EdgeInsets.only(left: 15, top: 5),
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CommonTextWidget(
                    text: msg.toString(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
