import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/app_scaffold.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/responsive.dart';
import 'package:doctor_app/core/string/string_utils.dart';
import 'package:doctor_app/provider/dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PrimeScreen extends StatelessWidget {
  const PrimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var isMobile = Responsive.isMobile(context);
    var size = MediaQuery.sizeOf(context);
    return AppScaffold(
      left: 0,
      right: 0,
      appBar: commonAppBar(
          colorText: Colors.white,
          title: "Prime".toUpperCase(),
          actions: [
            commonInkWell(
                child: CommonTextWidget(
              text: "Add Budget".toUpperCase(),
              textColor: Colors.white,
              fontWeight: FontWeight.w600,
              right: 10,
            ))
          ]),
      child: Container(
        color: isMobile ? AppColors.colorBG : Colors.white,
        child: Padding(
          padding: EdgeInsets.all(isMobile ? 10 : 20.0),
          child: ListView(
            children: [
              isMobile
                  ? _mobileView(
                      size: size,
                      isMobile: isMobile,
                    )
                  : Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: size.height * 0.12,
                                child: _topView(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: SizedBox(
                                height: size.height * 0.12,
                                child: _topView(
                                    fontSize: 18,
                                    title: "Performance Duration",
                                    desc: "12 Sep 2024-12 Oct 2024"),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: _middleView(
                                    color: Colors.green,
                                    size: size,
                                    isMobile: isMobile)),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: _middleView(
                                    size: size,
                                    isMobile: isMobile,
                                    title: "Budget\nSpent",
                                    value: "$rupee 4050")),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: _middleView(
                                    size: size,
                                    isMobile: isMobile,
                                    title: "Unique Connections\nCharged",
                                    value: "11")),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: _middleView(
                                    size: size,
                                    isMobile: isMobile,
                                    title: "Repeat Connections Not\nCharged",
                                    value: "6")),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: _middleView(
                                    size: size,
                                    isMobile: isMobile,
                                    title: "Refunded\nConnections",
                                    value: "3")),
                          ],
                        )
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }

  _mobileView({required bool isMobile, required Size size}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _topView(),
        const SizedBox(
          height: 10,
        ),
        _topView(
            title: "Performance Duration", desc: "12 Sep 2024-12 Oct 2024"),
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.all(0),
          child: Row(
            children: [
              Expanded(
                  child: _middleView(
                      color: Colors.green, size: size, isMobile: isMobile)),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  child: _middleView(
                      size: size,
                      isMobile: isMobile,
                      title: "Budget\nSpent",
                      value: "$rupee 4050")),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.all(0),
          child: Row(
            children: [
              Expanded(
                  child: _middleView(
                      size: size,
                      isMobile: isMobile,
                      title: "Unique Connections\nCharged",
                      value: "11")),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  child: _middleView(
                      size: size,
                      isMobile: isMobile,
                      title: "Repeat Connections Not\nCharged",
                      value: "6")),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.all(0),
          child: Row(
            children: [
              Expanded(
                  child: _middleView(
                title: "Refunded\nConnections",
                value: "3",
                size: size,
                isMobile: isMobile,
              )),
              const SizedBox(
                width: 10,
              ),
              Expanded(child: Container()),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const BookingListScreen(),
      ],
    );
  }

  _topView({String? title, String? desc, double? fontSize}) {
    return commonList(
        child: ListTile(
      dense: true,
      trailing: Icon(
        Icons.more_vert,
        color: Colors.black.withOpacity( 0.80),
      ),
      title: CommonTextWidget(
        text: title ?? "Campaign Name",
        fontSize: fontSize,
        textColor: Colors.black.withOpacity( 0.80),
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

  _middleView(
      {String? title,
      String? value,
      Color? color,
      required bool isMobile,
      required Size size}) {
    return commonList(
        child: Container(
      height: isMobile ? null : size.height * 0.15,
      padding: const EdgeInsets.only(top: 10.0, bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Align(
              alignment: Alignment.topLeft,
              child: CommonTextWidget(
                text: title ?? "Available\nBudget",
                fontSize: isMobile ? 12 : 14,
                left: 10,
                textColor: Colors.black.withOpacity( 0.80),
              )),
          Align(
              alignment: Alignment.bottomRight,
              child: CommonTextWidget(
                text: ' ${value ?? '$rupee 17,350'}',
                fontWeight: FontWeight.w600,
                fontSize: isMobile ? 15 : 18,
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
                child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.filter_alt_sharp,
                      color: AppColors.colorAmber,
                    ))),
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
                    textColor: Colors.black.withOpacity( 0.50),
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
                            textColor: Colors.black.withOpacity( 0.70),
                          )),
                          Expanded(
                              flex: 1,
                              child: CommonTextWidget(
                                text: '$rupee ${booking.price}',
                                fontSize: 12,
                                textDecoration: booking.status == "CANCELLED"
                                    ? TextDecoration.lineThrough
                                    : null,
                                fontWeight: FontWeight.w500,
                                textAlign: TextAlign.center,
                                textColor: Colors.black.withOpacity( 0.70),
                              )),
                        ],
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 5, left: 0),
                          color: booking.status == "CANCELLED"
                              ? Colors.grey.withOpacity( 0.10)
                              : Colors.green.withOpacity( 0.10),
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
