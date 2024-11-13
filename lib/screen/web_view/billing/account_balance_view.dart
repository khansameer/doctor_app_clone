import 'package:doctor_app/core/common/common_button_widget.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:flutter/material.dart';

class AccountBalanceView extends StatelessWidget {
  AccountBalanceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonTextWidget(
            text: "Account Balance",
            fontWeight: FontWeight.w600,
            fontSize: 17,
          ),
          SizedBox(
            height: 10,
          ),
          _balanceView(),
          CommonButtonWidget(
            height: 40,
            top: 20,
            text: "Refill Balance".toUpperCase(),
          )
        ],
      ),
    );
  }

  final Color colorText = Color.fromRGBO(65, 77, 85, 1);
  final Color colorBalance = Color.fromRGBO(4, 150, 255, 1);
  final Color colorBounce = Color.fromRGBO(241, 113, 5, 1);

  _balanceView() {
    return IntrinsicHeight(
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonTextWidget(
                text: "Active balance",
                fontSize: 14,
                textColor: colorText,
                fontWeight: FontWeight.w400,
              ),
              CommonTextWidget(
                text: '\$ 754.40',
                textColor: colorBalance,
                fontSize: 24,
                fontWeight: FontWeight.w700,
                top: 5,
              ),
            ],
          ),
          SizedBox(width: 10,),
          VerticalDivider(
            color: Colors.blueAccent,
            thickness: 1,
          ),
          SizedBox(width: 10,),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonTextWidget(
                  text: "Bonus balance",
                  fontSize: 14,
                  textColor: colorText,
                  fontWeight: FontWeight.w400),
              CommonTextWidget(
                textColor: colorBounce,
                fontSize: 24,
                fontWeight: FontWeight.w700,
                top: 5,
                text: 'B 45.27',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
