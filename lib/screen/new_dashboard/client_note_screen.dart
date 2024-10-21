
import 'package:doctor_app/core/component/component.dart';
import 'package:flutter/material.dart';

import '../../core/colors.dart';

class ClientNoteScreen extends StatelessWidget {
  const ClientNoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(0),
          color: Colors.grey.withOpacity(0.20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        commonText(text: "Client Note"),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.calendar_month_sharp),
                        commonText(text: "Share ON"),
                      ],
                    ),
                 commonWithIconButton(
                        onPressed: () {}, btnText: "Add", icon: Icons.add)
                  ],
                ),
              ),
              Divider(),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: commonText(text: "10 Oct,2024"),
                ),
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(0),
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          commonText(
                              text: "Michael",
                              color: AppColors.colorMenuProfile),
                          SizedBox(
                            width: 100,
                          ),
                          commonText(
                              text: "ID:4455",
                              color: AppColors.colorMenuProfile),
                        ],
                      ),
                      Row(
                        children: [Icon(Icons.print)],
                      )
                    ],
                  ))
            ],
          ),
        ),
        Divider(),
        IntrinsicHeight(
          child: Row(
            children: [
              commonText(text: 'Complaint', left: 10),
              VerticalDivider(
                color: Colors.black,
                thickness: 2,
              ),
              Flexible(
                child: commonText(
                    left: 10,
                    right: 10,
                    text:
                        'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using  Content here, content here making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for lorem ipsum will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).'),
              ),
            ],
          ),
        )
      ],
    );
  }
}
