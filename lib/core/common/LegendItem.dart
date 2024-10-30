import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:flutter/material.dart';

class LegendItem extends StatelessWidget {
  final Color color;
  final String text;

  const LegendItem({super.key, required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 4),
        Icon(Icons.circle_outlined, color: color, size: 14),
        CommonTextWidget(
          text:  text,
          left: 5,
          fontSize: 12, fontWeight: FontWeight.w600,
        ),
      ],
    );
  }
}
