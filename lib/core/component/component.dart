import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_app/core/color_utils.dart';
import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/image/image_path.dart';
import 'package:doctor_app/core/route/route.dart';
import 'package:doctor_app/main.dart';

import 'package:doctor_app/provider/dashboard_provider.dart';
import 'package:doctor_app/service/gloable_status_code.dart';
import 'package:doctor_app/shared_preferences/preference_helper.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

import '../app_constants.dart';
import '../common/common_textfield.dart';

commonResponsiveLayout(
    {required Size size,
    required Widget child,
    required bool isMobile,
    double? boxWidth,
    required bool isTablet}) {
  return Container(
    width: size.width,
    height: size.height,
    decoration: const BoxDecoration(
        image: DecorationImage(fit: BoxFit.cover, image: AssetImage(icBg))),
    child: Container(
      color: colorBG.withOpacity(0.60),
      child: Center(
        child: Container(
          margin: EdgeInsets.all(isMobile ? 0 : 10),
          decoration: commonBoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(isMobile ? 0 : 10)),
          padding: isMobile
              ? EdgeInsets.zero
              : const EdgeInsets.only(left: 25, right: 25, bottom: 25, top: 0),
          width: isMobile
              ? size.width
              : isTablet
                  ? size.width * 0.6
                  : size.width * 0.3,
          height: isMobile ? size.height : null,
          child: child,
        ),
      ),
    ),
  );
}

commonWithIconButton(
    {required VoidCallback onPressed, String? btnText, IconData? icon}) {
  return TextButton(
    style: TextButton.styleFrom(
      foregroundColor: Colors.transparent,
      disabledForegroundColor: Colors.transparent.withOpacity(zero38),
    ),
    onPressed: onPressed,
    child: Container(
      padding: const EdgeInsets.all(7),
      decoration: commonBoxDecoration(
          borderRadius: BorderRadius.circular(8), color: AppColors.colorFillBg),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          commonText(
              text: btnText ?? "New account",
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 13,
              right: 10),
          Icon(icon ?? Icons.add)
        ],
      ),
    ),
  );
}

commonButton(
    {required VoidCallback onPressed,
    String? btnText,
    Color? colorText,
    double? fontSize,
    bool isShowBorder = false}) {
  return TextButton(
    style: TextButton.styleFrom(
      shape: isShowBorder
          ? RoundedRectangleBorder(
              side: const BorderSide(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(10),
            )
          : const CircleBorder(),
      foregroundColor: Colors.transparent,
      disabledForegroundColor: Colors.transparent.withOpacity(zero38),
    ),
    onPressed: onPressed,
    child: commonText(
      text: btnText ?? "newAccount",
      color: colorText ?? AppColors.primary,
      fontWeight: FontWeight.w500,
      fontSize: fontSize ?? 14,
    ),
  );
}

commonBackRedirectButton({String? page, Color? color}) {
  return IconButton(
      onPressed: () {
        final dashboardProvider = Provider.of<DashboardProvider>(
            navigatorKey.currentState!.context,
            listen: false);
        dashboardProvider.updateAppPage = page ?? "Home";
      },
      icon: Icon(
        Icons.arrow_back_ios,
        color: color ?? colorText,
      ));
}

String formatDate({required DateTime date, String? formatDate}) {
  return DateFormat(formatDate).format(date);
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

Future getName() async {
  String? name = await PreferenceHelper.getString(key: PreferenceHelper.name);

  return name;
}

Future getDoctorEmail() async {
  String? email = await PreferenceHelper.getString(key: PreferenceHelper.email);

  return email;
}

Future getUserID() async {
  String? userID =
      await PreferenceHelper.getString(key: PreferenceHelper.userID);

  print('=================userID${userID}');
  return userID;
}

commonTextStyle({FontWeight? fontWeight, double? fontSize, Color? color}) {
  return GoogleFonts.inter(
    color: color,
    fontWeight: fontWeight ?? FontWeight.w500,
    fontSize: fontSize ?? 14,
  );
}

loadAssetImage(
    {required String path, double? width, double? height, Color? color}) {
  return Image.asset(
    path,
    width: width,
    color: color,
    height: height,
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
  double? width,
  double? radius,
  double? height,
  Widget? suffixIcon,
  VoidCallback? onTap,
  double? textFontSize,
  double? fontSize,
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
        fontSize: textFontSize,
        fontWeight: FontWeight.w400,
        textColor: Colors.black,
      ),
      CommonTextField(
        hint: hint,
        onTap: onTap,
        height: height,
        isReadOnly: isReadOnly,
        colorFill: Colors.white,
        inputTypes: keyboardType,
        suffixIcon: suffixIcon,
        validator: validator,
        width: width,
        fontSize: fontSize,
        obscureText: obscureText,
        controller: controller,
        radius: radius ?? 8,
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
    iconTheme: IconThemeData(color: iconColor ?? Colors.white),
    actions: actions,
    title: CommonTextWidget(
      text: title,
      fontSize: 14,
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

commonSessionError({required BuildContext context}) {
  showCommonDialog(
    context: context,
    title: "Error",
    content: errorMessage ?? '',
    btnPositive: "Close",
    onPressPositive: () {
      PreferenceHelper.clear();
      pushNamedAndRemoveUntil(
          context: context, routeName: RouteName.loginScreen);
    },
    isMessage: true,
  );
}

Widget showLoaderList() {
  return Center(
    child: Container(
        decoration: BoxDecoration(
            color: AppColors.primary, borderRadius: BorderRadius.circular(10)),
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
    //  padding: const EdgeInsets.only(top: 8, bottom: 8),
    decoration: commonBoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.withOpacity(0.50), width: 0)),
    margin: EdgeInsets.only(left: 0, right: 0, top: top ?? 0),
    child: child,
  );
}
/*

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
*/

appBarView({required BuildContext context, String? title}) {
  print('=================${title}');
  return commonAppBar(
      title: title,
      leading: const Icon(
        Icons.dashboard_rounded,
        color: Colors.white,
      ),
      color: colorGreen,
      actions: [
        commonIcon(onTap: () {
          pushScreen(context: context, routeName: RouteName.settingScreen);
        }),
        commonInkWell(
          onTap: () {
            pushScreen(
                context: context, routeName: RouteName.reportAndIssueScreen);
          },
          child: Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            decoration: commonBoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 1)),
            child: Container(
              alignment: Alignment.center,
              child: const Icon(
                Icons.question_mark,
                size: 15,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
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

commonText({
  String? text,
  FontWeight? fontWeight,
  double? fontSize,
  double? top,
  double? bottom,
  Color? color,
  double? left,
  TextAlign? textAlign,
  double? right,
}) {
  return Container(
      margin: EdgeInsets.only(
          top: top ?? zero,
          left: left ?? zero,
          right: right ?? zero,
          bottom: bottom ?? zero),
      child: Text(text ?? '',
          textAlign: textAlign,
          style: TextStyle(
              color: color,
              fontWeight: fontWeight ?? FontWeight.w500,
              fontSize: fontSize ?? fourteen)));
}

commonMenu(
    {String? headerText,
    Widget? leading,
    Widget? trailing,
    int? index,
    List<Widget>? children,
    Color? headerLeadingIconColor,
    Color? headerTextColor,
    Color? backgroundColor,
    bool? showIcon = false,
    void Function(bool)? onExpansionChanged}) {
  return ExpansionTile(
    dense: true,
    collapsedShape: const RoundedRectangleBorder(
      side: BorderSide.none,
    ),
    shape: const RoundedRectangleBorder(
      side: BorderSide.none,
    ),
    backgroundColor: backgroundColor,
    trailing: trailing,
    onExpansionChanged: onExpansionChanged,
    showTrailingIcon: showIcon ?? false,
    collapsedIconColor: Colors.white.withOpacity(0.50),
    iconColor: Colors.white.withOpacity(0.50),
    leading: leading ??
        Icon(
          Icons.menu,
          color: headerLeadingIconColor ?? Colors.white,
        ),
    title: CommonTextWidget(
        text: headerText ?? "Calender",
        fontSize: 13,
        textColor: headerTextColor ?? Colors.white.withOpacity(0.50)),
    children: children ??
        [
          // Child expandable menu 1
          ExpansionTile(
            showTrailingIcon: false,
            leading: Icon(
              Icons.inventory,
              color: Colors.white.withOpacity(0.50),
            ),
            title: CommonTextWidget(
                text: 'Inventory', textColor: Colors.white.withOpacity(0.50)),
          ),
          // Child expandable menu 2
          ExpansionTile(
            showTrailingIcon: false,
            leading: Icon(
              Icons.expand_sharp,
              color: Colors.white.withOpacity(0.50),
            ),
            title: CommonTextWidget(
                text: 'Expenses', textColor: Colors.white.withOpacity(0.50)),
          ),
          ExpansionTile(
            showTrailingIcon: false,
            leading: Icon(
              Icons.task,
              color: Colors.white.withOpacity(0.50),
            ),
            title: CommonTextWidget(
                text: 'Activities', textColor: Colors.white.withOpacity(0.50)),
          ),
        ],
  );
}

PopupMenuItem<int> buildPopupMenuItem(
    {required BuildContext context, required int index, required String text}) {
  return PopupMenuItem<int>(
    value: index,
    child: MouseRegion(
      onEnter: (_) {
        context.read<DashboardProvider>().setHoveredIndex(index);
      },
      onExit: (_) {
        context.read<DashboardProvider>().setHoveredIndex(null);
      },
      child: Consumer<DashboardProvider>(
        builder: (context, hoverProvider, child) {
          return Container(
            padding: const EdgeInsets.all(eight),
            child: commonText(
              text: text,
              fontSize: fourteen,
              fontWeight: FontWeight.w600,
              color: hoverProvider.hoveredIndex == index
                  ? AppColors.primary
                  : Colors.black,
            ),
          );
        },
      ),
    ),
  );
}

Widget buildPopupMenu() {
  return PopupMenuButton<String>(
    color: Colors.white,
    onSelected: (String value) {
      // Handle the selected option
      if (value == 'edit') {
        // Handle Active logic
        if (kDebugMode) {
          print('Active selected');
        }
      } else if (value == 'delete') {
        // Handle Inactive logic
        if (kDebugMode) {
          print('Inactive selected');
        }
      }
    },
    itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
      const PopupMenuItem<String>(
        value: 'edit',
        child: Text('Edit'),
      ),
      const PopupMenuItem<String>(
        value: 'delete',
        child: Text('Delete'),
      ),
    ],
    child: const Icon(
      Icons.more_vert,
      color: Colors.grey,
    ), // Icon to trigger the pop-up menu
  );
}
/*
Future<List<PlatformFile>?> pickFiles() async {
  List<PlatformFile>? _paths;

  try {
    if (kIsWeb) {
      _paths = (await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        onFileLoading: (FilePickerStatus status) => print(status),
        allowedExtensions: ['pdf'],
      ))
          ?.files;
    } else {
      var status = await Permission.manageExternalStorage.request();
      var status1 = await Permission.storage.request();
      if (status.isGranted || status1.isGranted) {
        _paths = (await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowMultiple: false,
          onFileLoading: (FilePickerStatus status) => print(status),
          allowedExtensions: ['pdf'],
        ))
            ?.files;
      } else if (status.isPermanentlyDenied) {
        openAppSettings();
      }
    }
  } on PlatformException catch (e) {
    print('-PlatformException${e.toString()}');
  } catch (e) {
    print('-error${e.toString()}');
  }

  return _paths;
}*/
