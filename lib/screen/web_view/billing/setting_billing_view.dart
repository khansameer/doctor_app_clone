import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/responsive.dart';
import 'package:doctor_app/provider/admin_dashboard_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'account_balance_view.dart';
import 'billing_card_view.dart';
import 'billing_payment_history_view.dart';

class SettingBillingView extends StatefulWidget {
  const SettingBillingView({super.key});

  @override
  State<SettingBillingView> createState() => _SettingBillingViewState();
}

class _SettingBillingViewState extends State<SettingBillingView> {
  @override
  Widget build(BuildContext context) {
    var isMobile = Responsive.isMobile(context);
    var isTablet = Responsive.isTablet(context);
    var size = MediaQuery.sizeOf(context);
    return Container(
      width: size.width,
      height: size.height,
      child:
          Consumer<AdminDashboardProvider>(builder: (context, provider, child) {
        return _webView(provider, context);
      }),
    );
  }

  _webView(AdminDashboardProvider provider, BuildContext context) {
    var isTablet = Responsive.isTablet(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AccountBalanceView(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.6,
                      //  height: MediaQuery.sizeOf(context).height*0.5,
                      child: BillingCardView(),
                    ),
                  ],
                ),
              ),
              Expanded(
                  flex: isTablet ? 4 : 7,
                  child: SizedBox(
                      height: MediaQuery.sizeOf(context).height,
                      child: ListView(
                        children: [
                          BillingPaymentHistoryView(),
                        ],
                      )))
            ],
          ),
        ],
      ),
    );
  }
}
