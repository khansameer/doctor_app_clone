import 'package:flutter/material.dart';
import 'package:doctor_app/core/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app_constants.dart';

//ignore: must_be_immutable
class CommonTextWidget extends StatelessWidget {
  String? _text;
  Color? _textColor;
  Color? _decorationColor;
  double? _fontSize;
  FontWeight? _fontWeight;
  TextDecoration? _textDecoration;
  TextDecorationStyle? _decorationStyle;
  double? _letterSpacing;
  TextAlign? _textAlign;
  double? _top;
  double? _height;
  double? _width;
  double? _left;
  TextStyle? _textStyles;
  double? _right;
  double? _lineHeight;
  double? _marginBottom;
  double? _decorationThickness;
  AlignmentGeometry? _alignment;
  TextOverflow? _overflow;
  List<Shadow>? _shadows;
  bool? _softWrap;
  int? _maxLines;
  CommonTextWidget({
    String? text,
    Color? textColor,
    double? fontSize,
    FontWeight? fontWeight,
    TextDecoration? textDecoration,
    double? letterSpacing,
    TextAlign? textAlign,
    double? top,
    double? marginBottom,
    double? height,
    double? width,
    double? left,
    double? right,
    TextOverflow? overflow,
    String? fontFamily,
    double? lineHeight,
    List<Shadow>? shadows,
    AlignmentGeometry? alignment,
    int? maxLines,
    bool? softWrap,
    TextStyle? textStyle,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    Color? decorationColor,
    super.key,
  }) {
    _text = text;
    _textColor = textColor;
    _fontSize = fontSize;
    _fontWeight = fontWeight;
    _textDecoration = textDecoration;
    _letterSpacing = letterSpacing;
    _textAlign = textAlign;
    _height = height;
    _width = width;
    _top = top;
    _left = left;
    _right = right;
    _lineHeight = lineHeight;

    _marginBottom = marginBottom;
    _overflow = overflow;
    _softWrap = softWrap;
    _alignment = alignment;
    _shadows = shadows;
    _maxLines = maxLines;
    _decorationColor = decorationColor;
    _decorationThickness = decorationThickness;
    _decorationStyle = decorationStyle;
    _textStyles = textStyle;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height,
      width: _width,
      alignment: _alignment,
      margin: EdgeInsets.only(
        bottom: _marginBottom ?? zero,
        top: _top ?? zero,
        left: _left ?? zero,
        right: _right ?? zero,
      ),
      child: Text(
        overflow: _overflow,
        softWrap: _softWrap,
        _text ?? "",
        maxLines: _maxLines,
        textAlign: _textAlign,
        style: _textStyles ??
            GoogleFonts.inter(
                shadows: _shadows,
                decorationColor: _decorationColor,
                decorationThickness: _decorationThickness,
                decorationStyle: _decorationStyle,
                height: _lineHeight ?? zero,
                letterSpacing: _letterSpacing ?? zero05,
                fontSize: _fontSize,
                color: _textColor ?? colorText,
                fontWeight: _fontWeight,
                decoration: _textDecoration),
      ),
    );
  }
}
