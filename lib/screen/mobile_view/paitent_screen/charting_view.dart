import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:flutter/material.dart';

class ChartingView extends StatelessWidget {
  const ChartingView({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, List<Map<String, String>>> groupedItems = {
      'Wednesday, 08 March 2024': [
        {
          'id': 'dr1',
          'name': 'Dr Steven A. Hauser',
          'status': 'Appointment',
          'time': '07:00 PM - 07:15 PM'
        },
        {
          'id': 'dr2',
          'name': 'Dr. Keith Black',
          'status': 'Appointment',
          'time': '07:00 PM - 07:15 PM'
        },
      ],
      'Thursday, 09 March 2024': [
        {
          'id': 'dr1',
          'name': 'Dr. Karen Remley',
          'status': 'Appointment',
          'time': '07:00 PM - 07:15 PM'
        },
        {
          'id': 'dr2',
          'name': 'Dr. Judith Beck',
          'status': 'Appointment',
          'time': '07:00 PM - 07:15 PM'
        },
      ],
    };

    return ListView(
      children: groupedItems.entries.map((entry) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 0.0),
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              initiallyExpanded: true,
              trailing: const SizedBox.shrink(),
              title: CommonTextWidget(
                text: entry.key,
                fontSize: 15,
                fontWeight: FontWeight.w400,
                textColor: Colors.black.withValues(alpha: 0.8),
              ),
              children: entry.value.map((item) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey.withValues(alpha: 0.40),
                        width: 0.5,
                      ),
                    ),
                  ),
                  child: ListTile(
                      dense: true,
                      title: CommonTextWidget(
                        text: item['status'] ?? '',
                        textColor: Colors.grey.shade600,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        marginBottom: 8,
                      ),
                      subtitle: Row(
                        children: [
                          const Icon(
                            Icons.circle_rounded,
                            color: Colors.green,
                            size: 12,
                          ),
                          CommonTextWidget(
                            text: '${item['name'] ?? ''} ${item['time'] ?? ''}',
                            left: 8,
                          )
                        ],
                      )),
                );
              }).toList(),
            ),
          ),
        );
      }).toList(),
    );
  }
}
