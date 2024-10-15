import 'package:doctor_app/core/color_utils.dart';
import 'package:doctor_app/core/common/app_scaffold.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/route/route.dart';
import 'package:flutter/material.dart';

class PatientsScreen extends StatelessWidget {
  const PatientsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);

    final Map<String, List<String>> groupedItems = {
      '2': [
        '2 pts pen',
      ],
      '3': [
        '333 Ashish Sharma',
      ],
      '5': [
        '5635',
      ],
      '4': [
        '4 pts pen',
      ],
      '7': [
        '777 Ashish Sharma',
      ],
      '8': [
        '888 Girish Chauhan',
      ],
    };

    return AppScaffold(
        right: 0,
        left: 0,
        color: Colors.white,
        // color: const Color.fromRGBO(252, 252, 254, 1),
        appBar: commonAppBar(
          title: "Patients".toUpperCase(),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.centerLeft,
                color: const Color.fromRGBO(252, 252, 254, 1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'PRACTICE'.toUpperCase(),
                          textAlign: TextAlign.left,
                        ),
                        const Text(
                          'Clear Vision Eye Clinic',
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          size: 36,
                        ))
                  ],
                )),
            Expanded(
              child: ListView(
                children: groupedItems.entries.map((entry) {
                  String group = entry.key;
                  List<String> items = entry.value;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: size.width,
                        color: colorGreen.withOpacity(0.10),
                        padding: const EdgeInsets.all(12.0),
                        child: CommonTextWidget(
                          text: group,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      ...items.map((item) {
                        return ListTile(
                          onTap: () {
                            pushScreen(
                              context: context,
                              routeName: RouteName.patientInfoScreen,
                            );
                          },
                          trailing: const Icon(
                            Icons.more_horiz,
                            color: Colors.grey,
                          ),
                          leading: Container(
                            height: 50,
                            width: 50,
                            decoration: commonBoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey.withOpacity(0.20),
                              border: Border.all(color: Colors.grey, width: 1),
                            ),
                            child: const Icon(
                              Icons.person,
                              color: colorGray,
                            ),
                          ),
                          title: CommonTextWidget(
                            text: item,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                          subtitle: CommonTextWidget(
                            text: item,
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        );
                      }),
                    ],
                  );
                }).toList(),
              ),
            ),
            Container(
              width: size.width,
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.orange.shade100,
                    width: 0.75,
                  ),
                ),
              ),
              child: TextButton.icon(
                icon: const Icon(
                  Icons.add_outlined,
                  color: Colors.orange,
                  size: 24,
                ),
                onPressed: () {},
                label: const Text(
                  'ADD PATIENT',
                  style: TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
