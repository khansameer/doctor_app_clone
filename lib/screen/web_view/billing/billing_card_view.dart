
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/provider/billing_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/colors.dart';
import '../../../core/component/component.dart';
import '../../../core/responsive.dart';
import '../../../provider/admin_dashboard_provider.dart';
import '../admin_dashboard_view/paitent_details/doctor_note_view.dart';
import 'billing_card_active_view.dart';


class BillingCardView extends StatelessWidget {
  const BillingCardView({super.key});

  @override
  Widget build(BuildContext context) {
    final tabProvider = Provider.of<BillingProvider>(context);

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child:  DefaultTabController(
        length: 2,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                  color: const Color.fromRGBO(250, 251, 253, 1),
                ),
                child: TabBar(
                  labelStyle: commonTextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                  dividerColor: Colors.white,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabAlignment: TabAlignment.fill,

                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.colorBgNew),
                  labelColor: AppColors.colorTextNew,
                  indicatorColor: AppColors.colorTextNew,
                  unselectedLabelColor: Colors.grey,
                  tabs: const [
                    Tab(text: 'Active'),
                    Tab(text: 'Archived'),
                  ],
                ),
              ),
            ),

            Divider(thickness: 0.3,),
            // Use Expanded here to fill the remaining space
            Expanded(
              child: TabBarView(
                children: [
                  BillingCardActiveView(), // Content for the first tab
                  Container(
                    child: Center(
                      child: CommonTextWidget(text: "You did not archive any cards yet",fontSize: 18,
                      fontWeight: FontWeight.w800,),
                    ),
                  ), // Content for the second tab
                ],
              ),
            ),
          ],
        ),
      ),
    );

  }



}
