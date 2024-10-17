import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_app/core/color_utils.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/image/image_path.dart';
import 'package:doctor_app/core/route/route.dart';
import 'package:doctor_app/core/string/string_utils.dart';
import 'package:doctor_app/provider/auth_provider.dart';
import 'package:doctor_app/shared_preferences/preference_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app_constants.dart';
import '../common/common_textfield.dart';


commonResponsiveLayout({required Size size,required Widget child,required bool isMobile,double? boxWidth,double ?boxHeight}){
  return Container(
    width: size.width,
    height: size.height,
    decoration: const BoxDecoration(
        image: DecorationImage(fit: BoxFit.cover, image: AssetImage(icBg))),
    child: Center(
      child: Container(
        decoration: commonBoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(isMobile?0:
            10)
        ),
        padding: isMobile
            ? EdgeInsets.zero
            : const EdgeInsets.only(
            left: 25, right: 25, bottom: 25, top: 0),
        width: isMobile ? size.width : boxWidth??size.width * 0.3,
        height: isMobile ? size.height : boxHeight??size.height * 0.38,
        child: child,
      ),
    ),
  );
}
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
Future getAuthToken() async {
  String? token =
  await PreferenceHelper.getString(key: PreferenceHelper.authToken);

  print('=================token${token}');
  return token;
}


commonTextStyle({FontWeight? fontWeight, double? fontSize, Color? color}) {
  return GoogleFonts.inter(
    color: color,
    fontWeight: fontWeight ?? FontWeight.w500,
    fontSize: fontSize ?? 14,
  );
}

commonTextFiledView({
  String? title,
  bool? obscureText,
  double? topText,
  String? hint,
  String? Function(String?)? validator,
  double? topTextField,
  bool? isReadOnly,
  Widget? suffixIcon,
  VoidCallback? onTap,
  TextInputType? keyboardType,
  TextEditingController? controller,
  int? maxLines,
}) {
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
        onTap: onTap,
        isReadOnly: isReadOnly,
        colorFill: Colors.white,
        inputTypes: keyboardType,
        suffixIcon: suffixIcon,
        validator: validator,
        obscureText: obscureText,
        controller: controller,
        radius: twelve,
        top: topTextField,
        maxLines: maxLines,
      )
    ],
  );
}

commonDivider() {
  return const Divider(
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
    Color? iconColor,
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
    iconTheme:  IconThemeData(color: iconColor??Colors.white),
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
commonList({
  String? title,
  Widget? child,
  double? top,
}) {
  return Container(

    padding: const EdgeInsets.only(top: 8, bottom: 8),
    decoration: commonBoxDecoration(
        color: Colors.white,

        border: Border.all(color: Colors.grey.withOpacity(0.50), width: 0)),
    margin: EdgeInsets.only(left: 0, right: 0, top: top ?? 0),
    child: child,
  );
}
genderView({required AuthProviders provider}) {
  return Column(
    children: [


      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Male Radio Button
          Align(
            alignment: Alignment.centerLeft,
            child: CommonTextWidget(
              text: gender,
              fontWeight: FontWeight.w500,
              fontSize: sixteen,
            ),
          ),
          Radio<Gender>(
            activeColor: colorGreen,
            value: Gender.male,
            groupValue: provider.selectedGender,
            onChanged: (Gender? value) {
              if (value != null) {
                provider.selectGender(value);
              }
            },
          ),
          CommonTextWidget(text: "Male"),
          // Female Radio Button
          Radio<Gender>(
            activeColor: colorGreen,
            value: Gender.female,
            groupValue: provider.selectedGender,
            onChanged: (Gender? value) {
              if (value != null) {
                provider.selectGender(value);
              }
            },
          ),
          CommonTextWidget(text: female),
          //CommonTextWidget(text: female),
        ],
      ),
    ],
  );
}

appBarView(BuildContext context) {
  return commonAppBar(
      leading: const Icon(Icons.dashboard_rounded,color: Colors.white,),
      color: colorGreen, actions: [
    commonIcon(onTap: () {
      pushScreen(context: context, routeName: RouteName.settingScreen);
    }),

    commonInkWell(
      onTap: (){
        pushScreen(
            context: context, routeName: RouteName.reportAndIssueScreen);
      },
      child: Container(
        width: 24,
        height: 24,
        alignment:Alignment.center ,
        decoration: commonBoxDecoration(shape: BoxShape.circle,
            border: Border.all(color: Colors.white,width: 1)),
        child: Container(

          alignment:Alignment.center ,
          child: const Icon(Icons.question_mark,size: 15,),
        ),),
    ),
    const SizedBox(width: 10,),
    commonInkWell(
      onTap: () {
        pushScreen(
            context: context, routeName: RouteName.notificationScreen);
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          const Icon(
            Icons.notifications_none,
            color: Colors.white,
            size: 24,
          ),
          Positioned(
              top: -8.0,
              right: -3.0,
              child: Stack(
                children: <Widget>[
                  Container(
                    width: 20,
                    height: 20,
                    decoration: commonBoxDecoration(
                        shape: BoxShape.circle, color: Colors.red),
                    child: Center(
                      child: CommonTextWidget(
                        text: "20",
                        fontSize: 9,
                        textColor: Colors.white,
                      ),
                    ),
                  )
                ],
              ))
        ],
      ),
    ),
    const SizedBox(
      width: 10,
    )
  ]);
}
