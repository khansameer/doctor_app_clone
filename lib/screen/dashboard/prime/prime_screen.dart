import 'package:doctor_app/core/color_utils.dart';
import 'package:doctor_app/core/common/app_scaffold.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/string/string_utils.dart';
import 'package:doctor_app/provider/dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PrimeScreen extends StatelessWidget {
  const PrimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      left: 0,
      right: 0,

      appBar: commonAppBar(
          color: colorBG,colorText:colorText,leading: Container(),
          title: "Prime".toUpperCase(), actions: [
        commonInkWell(
            child: CommonTextWidget(
          text: "Add Budget".toUpperCase(),
          textColor: colorText,
          fontWeight: FontWeight.w600,
          right: 10,
        ))
      ]),
      child: Container(
        color: colorGray.withOpacity(0.20),
        child: ListView(
          children: [
            _topView(),
            const SizedBox(
              height: 10,
            ),
            _topView(
                title: "Performance Duration", desc: "12 Sep 2024-12 Oct 2024"),
            Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(child: _middleView(color: Colors.green)),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: _middleView(
                          title: "Budget\nSpent", value: "$rupee 4050")),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                      child: _middleView(
                          title: "Unique Connections\nCharged", value: "11")),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: _middleView(
                          title: "Repeat Connections Not\nCharged",
                          value: "6")),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                      child: _middleView(
                          title: "Refunded\nConnections", value: "3")),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(child: Container()),
                ],
              ),
            ),
            const BookingListScreen(),
          ],
        ),
      ),
    );
  }

  _topView({String? title, String? desc}) {
    return commonList(
        child: ListTile(
      dense: true,
      trailing: Icon(
        Icons.more_vert,
        color: Colors.black.withOpacity(0.80),
      ),
      title: CommonTextWidget(
        text: title ?? "Campaign Name",
        textColor: Colors.black.withOpacity(0.80),
        marginBottom: 5,
      ),
      subtitle: Row(
        children: [
          CommonTextWidget(
            text: desc ?? "Prime 300 Ophthalmology",
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(
            width: 10,
          ),
          const Icon(
            Icons.arrow_drop_down,
            color: Colors.black,
          )
        ],
      ),
    ));
  }

  _middleView({String? title, String? value, Color? color}) {
    return commonList(
        child: Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10),
      child: Column(
        children: [
          Align(
              alignment: Alignment.topLeft,
              child: CommonTextWidget(
                text: title ?? "Available\nBudget",
                fontSize: 12,
                left: 10,
                textColor: Colors.black.withOpacity(0.80),
              )),
          Align(
              alignment: Alignment.topRight,
              child: CommonTextWidget(
                text: ' ${value ?? '$rupee 17,350'}',
                fontWeight: FontWeight.w600,
                fontSize: 15,
                right: 10,
                textColor: color ?? Colors.black,
              ))
        ],
      ),
    ));
  }
}

class BookingListScreen extends StatelessWidget {
  const BookingListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bookingProvider = Provider.of<DashboardProvider>(context);
    final bookings = bookingProvider.bookings;

    return SizedBox(
      child: commonList(
        child: Column(
          children: [
            Align(
              heightFactor: 0.7,
                alignment: Alignment.topRight,
                child: IconButton(onPressed: (){}, icon: const Icon(Icons.filter_alt_sharp,color: colorAmber,))),
            const Divider(
              thickness: 0.3,
            ),
            ListView.separated(
              shrinkWrap: true,

              itemCount: bookings.length,
              itemBuilder: (context, index) {
                final booking = bookings[index];
                return ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  leading: CommonTextWidget(
                    text: booking.date,
                    fontSize: 11,
                    left: 10,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w600,
                    textColor: Colors.black.withOpacity(0.50),
                  ),
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              flex: 2,
                              child: CommonTextWidget(
                                text: booking.name,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                textAlign: TextAlign.left,
                              )),
                          Expanded(
                              child: CommonTextWidget(
                            text: 'Book',
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            textAlign: TextAlign.center,
                            textColor: Colors.black.withOpacity(0.70),
                          )),
                          Expanded(
                              flex: 1,
                              child: CommonTextWidget(
                                text: '$rupee ${booking.price}',
                                fontSize: 12,
                                textDecoration:booking.status == "CANCELLED"?TextDecoration.lineThrough:null,
                                fontWeight: FontWeight.w500,
                                textAlign: TextAlign.center,
                                textColor: Colors.black.withOpacity(0.70),
                              )),
                        ],
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 5, left: 0),
                          color: booking.status == "CANCELLED"
                              ? Colors.grey.withOpacity(0.10)
                              : Colors.green.withOpacity(0.10),
                          padding: const EdgeInsets.all(5),
                          child: CommonTextWidget(
                            text: booking.status,
                            fontSize: 8,
                            fontWeight: FontWeight.w600,
                            textColor: booking.status == "CANCELLED"
                                ? Colors.grey
                                : Colors.green,
                            textAlign: TextAlign.center,
                          )),
                    ],
                  ),
                  trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 20,
                        color: Colors.grey,
                      )),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  thickness: 0.3,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
