import 'package:doctor_app/core/colors.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app_constants.dart';

//ignore: must_be_immutable
class CommonTextField extends StatelessWidget {
  String? hint;
  FontWeight? fontWeight;
  double? fontSize;
  double? top;
  double? bottom;
  Widget? iconWidget;
  double? radius;
  TextInputType? inputTypes;
  Widget? suffixIcon;
  ValueChanged? onChange;
  bool? obscureText;
  Color? colorFill;
  Color? colorText;
  Color? colorHint;
  Color? borderColor;
  double? left;
  double? right;
  double? width;
  double? height;
  double? borderWidth;
  double? padding;
  TextEditingController? controller;
  TextInputAction? textInputAction;
  TextCapitalization? textCapitalization;
  bool? isReadOnly;
  EdgeInsetsGeometry? contentPadding;
  List<TextInputFormatter>? inputFormatters;
  bool? isDense;
  int? maxLines;
  int? textInputLength;
  String? errorMessage;
  bool isError = false;
  bool? autofocus = false;
  bool? isHideBorder = false;
  bool? isFill = false;
  String? fontFamily;
  VoidCallback? onTap;
  Color? colorBg;
  EdgeInsetsGeometry? margin;
  String? Function(String?)? validator;

  CommonTextField({
    super.key,
    this.hint,
    this.fontWeight,
    this.fontSize,
    this.iconWidget,
    this.radius,
    this.inputTypes,
    this.suffixIcon,
    this.onChange,
    this.top,
    this.obscureText,
    this.controller,
    this.colorFill,
    this.colorText,
    this.left,
    this.right,
    this.isDense,
    this.colorHint,
    this.maxLines,
    this.textCapitalization,
    this.inputFormatters,
    this.isReadOnly,
    this.textInputLength,
    this.errorMessage,
    this.isError = false,
    this.onTap,
    this.colorBg,
    this.validator,
    this.isFill,
    this.autofocus,
    this.borderWidth,
    this.borderColor,
    this.textInputAction,
    this.contentPadding,
    this.width,
    this.height,
    this.fontFamily,
    this.bottom,
    this.isHideBorder,
    this.margin,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding ?? zero),
      width: width ?? MediaQuery.sizeOf(context).width,
      height: height,
      margin: EdgeInsets.only(
          left: left ?? zero,
          right: right ?? zero,
          top: top ?? zero,
          bottom: bottom ?? zero),
      child: TextFormField(
        validator: validator,
        cursorColor: AppColors.colorBlack,
        readOnly: isReadOnly ?? false,
        maxLines: maxLines ?? 1,
        inputFormatters: inputFormatters ??
            [
              LengthLimitingTextInputFormatter(textInputLength),
            ],
        controller: controller,
        textCapitalization: textCapitalization ?? TextCapitalization.none,
        onChanged: onChange,
        autofocus: autofocus ?? false,
        keyboardType: inputTypes,
        autocorrect: false,
        onTap: onTap,
        obscureText: obscureText ?? false,
        textInputAction: textInputAction ?? TextInputAction.next,
        style: GoogleFonts.inter(
          fontWeight: fontWeight ?? FontWeight.w400,
          color: colorText ?? colorText,
          fontSize: fontSize ?? fourteen,
        ),
        decoration: InputDecoration(
            prefixIcon: iconWidget,
            contentPadding: contentPadding ??
                const EdgeInsets.only(
                    left: twelve, right: twelve, top: twelve, bottom: twelve),
            suffixIcon: suffixIcon,
            hintStyle: GoogleFonts.inter(
              fontWeight: fontWeight ?? FontWeight.w400,
              color: Colors.grey.withValues(alpha: zero080),
              fontSize: fontSize ?? fourteen,
            ),
            filled: isFill ?? true,
            //filled: false,
            isCollapsed: false,
            isDense: isDense ?? false,
            hintText: hint,
            fillColor: colorFill ?? AppColors.colorFillBg,
            border: OutlineInputBorder(
                gapPadding: ten,
                borderSide: BorderSide(
                  width: 1,
                  color: borderColor ?? AppColors.primary,
                ),
                borderRadius:
                    BorderRadius.all(Radius.circular(radius ?? eight))),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.primary.withValues(alpha: 0.20),
                  width: 1,
                ),
                borderRadius:
                    BorderRadius.all(Radius.circular(radius ?? eight))),
            focusedBorder: OutlineInputBorder(
                gapPadding: ten,
                borderSide: BorderSide(
                  width: 1,
                  color: borderColor ?? AppColors.primary,
                ),
                borderRadius:
                    BorderRadius.all(Radius.circular(radius ?? eight)))),
      ),
    );
  }
}
