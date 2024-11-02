import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final Widget content;
  final EdgeInsets? insetPadding;

  const CustomAlertDialog({
    super.key,
    this.insetPadding,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: insetPadding,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      contentPadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      backgroundColor: Colors.white,
      content: content,
    );
  }
}
