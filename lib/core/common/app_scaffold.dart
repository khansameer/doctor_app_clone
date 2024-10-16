import 'package:flutter/material.dart';

import '../app_constants.dart';
import '../component/component.dart';

class AppScaffold extends StatelessWidget {
  AppScaffold(
      {this.color,
      super.key,
      this.child,
      this.left,
      this.bottom,
      this.top,
      this.appBar,
      this.right});
  final double? left;
  final double? right;
  final double? top;
  final double? bottom;
  final PreferredSizeWidget? appBar;
  final Color? color;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: color ?? Colors.white,
      appBar: appBar,
      body: Container(
        width: size.width,
        height: size.height,
        margin: EdgeInsets.only(
            left: left ?? twenty,
            right: right ?? twenty,
            top: top ?? zero,
            bottom: bottom ?? zero),
        decoration: commonBoxDecoration(),
        child: child,
      ),
    );
  }
}
