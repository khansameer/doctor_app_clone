
import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
}

extension StringCasingExtension on String {
  String toCapitalize() {
    var result = this[0].toUpperCase();
    for (int i = 1; i < length; i++) {
      if (this[i - 1] == " ") {
        result = result + this[i].toUpperCase();
      } else {
        result = result + this[i];
      }
    }
    return result;
  }
}
