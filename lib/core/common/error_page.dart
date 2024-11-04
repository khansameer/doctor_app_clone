import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:flutter/material.dart';


class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      width: size.width,
      padding: const EdgeInsets.all(16),
      height: size.height,
      child: Center(
        child: CommonTextWidget(
          fontWeight: FontWeight.w700,
          fontSize: 16,
          text: "Data not found",
        ),
      ),
    );
  }
}
