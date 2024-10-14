import 'package:flutter/material.dart';

import '../app_constants.dart';
import '../component/component.dart';



class CommonsScreenContainer extends StatelessWidget {
  const CommonsScreenContainer(
      {this.color,
      super.key,
      this.child,
      this.left,
      this.bottom,
      this.top,
      this.right});
  final double? left;
  final double? right;
  final double? top;
  final double? bottom;
  final Color? color;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Container(
      width: size.width,
      height: size.height,
      margin: EdgeInsets.only(
          left: left ?? twenty,
          right: right ?? twenty,
          top: top ?? zero,
          bottom: bottom ?? zero),
      decoration: commonBoxDecoration(),
      child: child,
    );
  }
}
