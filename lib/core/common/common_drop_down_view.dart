import 'package:doctor_app/core/app_constants.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
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
  final double? horizontal;
  final void Function(String?)? onChanged;
  final List<String> items;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isDense: true,
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
                text: hint ?? 'Select Item',
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
                    fontSize: 12,
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
                  color: Colors.grey.withOpacity(0.30),
                ),
                //color: Colors.redAccent,
              ),
          padding: EdgeInsets.symmetric(horizontal: horizontal ?? 0),
          height: height ?? 40,
          width: size.width * 0.7,
        ),
        menuItemStyleData: MenuItemStyleData(
          height: height ?? 40,
        ),
      ),
    );
  }
}
