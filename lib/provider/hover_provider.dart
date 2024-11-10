import 'package:flutter/cupertino.dart';

class HoverProvider with ChangeNotifier {
  int? _hoveredEdit;

  int? get hoveredEdit => _hoveredEdit;

  void setHoveredChat(int? index) {
    _hoveredEdit = index;
    notifyListeners();
  }
}
