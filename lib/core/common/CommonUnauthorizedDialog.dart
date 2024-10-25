import 'package:flutter/material.dart';

class CommonUnauthorizedDialog {
  static Future<void> showAlertDialog(
      BuildContext context, {
        required String title,
        required String message,
        String? positiveButtonText,
        String? negativeButtonText,
        VoidCallback? onPositivePressed,
        VoidCallback? onNegativePressed,
      }) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap button to dismiss
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            if (negativeButtonText != null)
              TextButton(
                onPressed: () {
                  if (onNegativePressed != null) {
                    onNegativePressed();
                  }
                  Navigator.of(dialogContext).pop(); // Dismiss the dialog
                },
                child: Text(negativeButtonText),
              ),
            TextButton(
              onPressed: () {
                if (onPositivePressed != null) {
                  onPositivePressed();
                }
                Navigator.of(dialogContext).pop(); // Dismiss the dialog
              },
              child: Text(positiveButtonText ?? 'OK'),
            ),
          ],
        );
      },
    );
  }
}
