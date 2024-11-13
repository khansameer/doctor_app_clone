

import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/common/common_textfield.dart';
import 'package:doctor_app/provider/billing_provider.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/common/MySeparator.dart';
import '../../../core/common/common_button_widget.dart';


class BillingPaymentHistoryView extends StatelessWidget {
  const BillingPaymentHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(0),

      decoration: BoxDecoration(
        color:Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CommonTextWidget(text: "Payments history",fontWeight: FontWeight.w600,fontSize: 18,),
                ),
            
                Divider(),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0,right: 16),
                  child: Consumer<BillingProvider>(
                      builder: (context,provider,child) {
                        return GroupedListView<DummyModel, String>(
                          elements:
                          provider.paymentList,
                          shrinkWrap: true,
                          groupBy: (billing) => DateFormat('yyyy-MM-dd').format(
                              DateTime.parse(billing.date ??
                                  DateTime.now().toString())), // Group by category
                          groupComparator: (value1, value2) =>
                              value2.compareTo(value1),
                          //  itemComparator: (item1, item2) => item1['name'].compareTo(item2['name']),
                          order: GroupedListOrder.DESC,
                          useStickyGroupSeparators: true,
                          separator: Divider(
                            thickness: 0.3,
                          ),
                          stickyHeaderBackgroundColor: Colors.transparent,
                          groupSeparatorBuilder: (String value) => Padding(
                            padding: const EdgeInsets.only(
                                left: 0.0, right: 0, top: 8, bottom: 8),
                            child: CommonTextWidget(
                              text: value,
                              fontWeight: FontWeight.w600,
                              textColor: Colors.green.shade300,
                            ),
                          ),
            
                          indexedItemBuilder: (c, element, index) {
                            return SizedBox(
                              child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                title:  CommonTextWidget(
                                  text: '${element.time}',
                                  fontSize: 12,
                                  textColor: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                ),
                                subtitle:  CommonTextWidget(
                                  text: '${element.title}',
                                  fontSize: 16,
            
                                  top: 8,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            );
                          },
                        );
                      }
                  ),
                ),

                Spacer(),
                Divider(thickness: 0.3,),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: CommonTextField(hint: "Transaction search",
              left: 20,
              radius: 8,
              colorFill: Colors.white,

              right: 20,
            ),
          )
        ],
      ),
    );
  }
}
