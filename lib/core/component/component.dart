import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_app/core/color_utils.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/image/image_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app_constants.dart';
import '../common/common_textfield.dart';

setAssetImage(
    {required String image, double? width, double? height, BoxFit? fit}) {
  return Image.asset(
    image,
    width: width,
    height: height,
    fit: fit ?? BoxFit.cover,
  );
}

BoxDecoration commonBoxDecoration(
    {Color? color,
    BoxBorder? border,
      List<BoxShadow>? boxShadow,
    BoxShape shape = BoxShape.rectangle,
    BorderRadiusGeometry? borderRadius,
    DecorationImage? image}) {
  return BoxDecoration(
      color: color,
      image: image,
      border: border,
      shape: shape,
      boxShadow: boxShadow,
      borderRadius: borderRadius);
}

commonTextStyle({FontWeight? fontWeight, double? fontSize, Color? color}) {
  return GoogleFonts.inter(
    color: color,
    fontWeight: fontWeight ?? FontWeight.w500,
    fontSize: fontSize ?? 14,
  );
}

commonTextFiledView(
    {String? title,
    bool? obscureText,
    double? topText,
    String? hint,
    String? Function(String?)? validator,
    double? topTextField,
    Widget? suffixIcon,
    TextEditingController? controller}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CommonTextWidget(
        text: title,
        top: topText,
        fontWeight: FontWeight.w500,
        textColor: Colors.black,
      ),
      CommonTextField(
        hint: hint,
        colorFill: Colors.white,
        suffixIcon: suffixIcon,
        validator: validator,
        obscureText: obscureText,
        controller: controller,
        radius: twelve,
        top: topTextField,
      )
    ],
  );
}

commonDivider() {
  return Divider(
    thickness: 0.3,
    color: colorGreen,
  );
}

Widget commonInkWell({
  Widget? child,
  VoidCallback? onTap,
}) {
  return InkWell(
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    onTap: onTap,
    child: child,
  );
}
commonIcon({IconData? icon, double? size, VoidCallback? onTap}) {
  return IconButton(
      onPressed: onTap,
      icon: Icon(
        icon ?? Icons.settings_outlined,
        color: Colors.white,
        size: size,
      ));
}
AppBar commonAppBar(
    {String? title,
    Color? color,
    List<Widget>? actions,
    Color? colorText,
    Widget? leading,
    double? leadingWidth,
    double? toolbarHeight,
    PreferredSizeWidget? bottom}) {
  return AppBar(
    leadingWidth: leadingWidth,
    backgroundColor: color ?? colorGreen,
    centerTitle: true,
    bottom: bottom,
    toolbarHeight: toolbarHeight,
    leading: leading,
    iconTheme: const IconThemeData(color: Colors.white),
    actions: actions,
    title: CommonTextWidget(
      text: title,
      fontSize: sixteen,
      fontWeight: FontWeight.w700,
      textColor: colorText ?? Colors.white,
    ),
  );
}

pushScreen({
  required BuildContext context,
  required String routeName,
  Object? arguments,
}) {
  Navigator.pushNamed(
      arguments: arguments,
      // Use the parent widget's context, not the local one
      Navigator.of(context, rootNavigator: true).context,
      routeName);
}

pushNamedAndRemoveUntil(
    {required BuildContext context, required String routeName}) {
  Navigator.pushNamedAndRemoveUntil(
      Navigator.of(context, rootNavigator: true).context,
      routeName,
      (route) => true);
}

void showCommonDialog(
    {required BuildContext context,
    required String title,
    required String content,
    String? btnPositive,
    String? btnNegative,
    bool isMessage = false,
    VoidCallback? onPressPositive,
    VoidCallback? onPressNegative}) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
            title: CommonTextWidget(
              text: title,
              fontSize: sixteen,
              fontWeight: FontWeight.w700,
            ),
            content: CommonTextWidget(text: content),
            actions: [
              if (!isMessage)
                CupertinoDialogAction(
                  onPressed: onPressNegative ??
                      () {
                        Navigator.of(context).pop();
                      },
                  child: CommonTextWidget(
                    text: btnNegative ?? "no",
                  ),
                ),

              // Show only if isMessage is false
              CupertinoDialogAction(
                onPressed: onPressPositive ??
                    () {
                      Navigator.of(context).pop();
                    },
                child: CommonTextWidget(
                  text: btnPositive ?? "okay",
                  textColor: Colors.red,
                ),
              ),
            ],
          ));
}

Widget showLoaderList() {
  return Center(
    child: Container(
        decoration: BoxDecoration(
            color: colorGreen, borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.all(20),
        child: const CupertinoActivityIndicator(
          radius: 20,
          color: Colors.white,
          animating: true,
        )),
  );
}

Widget commonImageNetworkWidget(
    {String? path,
    double? width,
    double? height,
    Alignment? alignment,
    bool? isNotification = false,
    bool? isCircle = true,
    Color? iconColor,
    BoxFit? boxFit}) {
  return Center(
    child: ClipOval(
      clipBehavior: isCircle == false ? Clip.none : Clip.antiAliasWithSaveLayer,
      child: CachedNetworkImage(
        cacheManager: CacheManager(Config(
          "fluttercampus",
          stalePeriod: const Duration(days: 7),

//one week cache period
        )),
        imageUrl: path ?? '',
        width: width,
        height: height,
        placeholder: (context, url) => showLoaderList(),
        errorWidget: (context, url, error) => Image.asset(icLoginLogo),
        color: iconColor,
        fit: boxFit ?? BoxFit.cover,
      ),
    ),
  );
}
