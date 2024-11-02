import 'package:doctor_app/core/app_constants.dart';
import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/responsive.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class CommonDropDownView extends StatelessWidget {
  const CommonDropDownView({
    super.key,
    required this.size,
    this.hint,
    this.decoration,
    this.horizontal,
    this.onChanged,
    this.hintColor,
    this.padding,
    this.height,
    required this.items,
    this.selectedValue,
  });
  final Size size;
  final String? hint;
  final BoxDecoration? decoration;
  final Color? hintColor;
  final String? selectedValue;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final double? horizontal;
  final void Function(String?)? onChanged;
  final List<String> items;
  @override
  Widget build(BuildContext context) {
    var isMobile = Responsive.isMobile(context);
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isDense: true,
        iconStyleData: const IconStyleData(
            icon: Icon(
          Icons.keyboard_arrow_down,
          color: Colors.grey,
        )),
        isExpanded: true,
        dropdownStyleData: DropdownStyleData(
          offset: const Offset(-0, -10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Colors.white,
          ),
        ),
        alignment: Alignment.center,
        hint: Row(
          children: [
            Expanded(
              child: CommonTextWidget(
                text: hint ?? 'Select',
                fontSize: twelve,
                left: horizontal != null ? 0 : 0,
                textColor: hintColor ?? Colors.grey,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        items: items
            .map((String item) => DropdownMenuItem<String>(
                  value: item,
                  child: CommonTextWidget(
                    text: item,
                    fontSize: 14,
                    left: horizontal != null ? 10 : 0,
                  ),
                ))
            .toList(),
        value: selectedValue,
        /*onChanged: (String? value) {
          */ /*setState(() {
                selectedValue = value;
              });*/ /*
        },*/
        onChanged: onChanged,
        buttonStyleData: ButtonStyleData(
          decoration: decoration ??
              BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppColors.colorGreen.withValues(alpha: 0.30),
                ),
                //color: Colors.redAccent,
              ),
          padding: padding ?? EdgeInsets.symmetric(horizontal: horizontal ?? 0),
          height: height ?? 40,
          width: isMobile ? size.width : size.width * 0.7,
        ),
        menuItemStyleData: MenuItemStyleData(
          height: height ?? 40,
        ),
      ),
    );
  }
}
