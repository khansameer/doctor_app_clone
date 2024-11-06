import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_app/core/app_constants.dart';
import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/common_button_widget.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/common/common_textfield.dart';
import 'package:doctor_app/core/common/custom_alert_dialog.dart';
import 'package:doctor_app/core/image/image_path.dart';
import 'package:doctor_app/core/route/route.dart';
import 'package:doctor_app/main.dart';
import 'package:doctor_app/provider/dashboard_provider.dart';
import 'package:doctor_app/provider/procedure_provider.dart';
import 'package:doctor_app/screen/web_view/admin_dashboard_view/patient_profile_dialog.dart';
import 'package:doctor_app/service/gloable_status_code.dart';
import 'package:doctor_app/shared_preferences/preference_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:popover/popover.dart';
import 'package:provider/provider.dart';

void showProfileDialog(BuildContext context) {
  var size = MediaQuery.sizeOf(context);
  showGeneralDialog(
    context: context,
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.6),
    transitionDuration: const Duration(milliseconds: 800),
    pageBuilder: (_, __, ___) {
      return Center(
        child: SizedBox(
          width: size.width * 0.2,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: const PatientProfileDialog()),
        ),
      );
    },
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

commonBackRedirectButton({String? page, Color? color, VoidCallback? onTap}) {
  return IconButton(
      onPressed: onTap ??
          () {
            final dashboardProvider = Provider.of<DashboardProvider>(
                navigatorKey.currentState!.context,
                listen: false);
            dashboardProvider.updateAppPage = page ?? "Home";
          },
      icon: Icon(
        Icons.arrow_back_ios,
        color: color ?? AppColors.colorText,
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

  if (kDebugMode) {
    print('=================token$token');
  }
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

  if (kDebugMode) {
    print('=================userID$userID');
  }
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
  TextInputAction? textInputAction,
  double? textFontSize,
  double? fontSize,
  TextInputType? keyboardType,
  FocusNode? focusNode,
  TextEditingController? controller,
  int? maxLines,
  Color? borderColor,
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
        borderColor: borderColor,
        hint: hint,
        focusNode: focusNode,
        onTap: onTap,
        textInputAction: textInputAction,
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
    color: AppColors.colorGreen,
  );
}

Widget commonInkWell({
  Widget? child,
  VoidCallback? onTap,
  void Function(bool)? onHover,
  void Function(PointerEnterEvent)? onEnter,
  void Function(PointerExitEvent)? onExit,
}) {
  return MouseRegion(
    onEnter: onEnter,
    onExit: onExit,
    child: InkWell(
      focusNode: FocusNode(skipTraversal: true),
      onHover: onHover,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: onTap,
      child: child,
    ),
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
    bool? centerTitle,
    Widget? leading,
    Widget? titleWidget,
    double? leadingWidth,
    double? titleSpacing,
    double? toolbarHeight,
    PreferredSizeWidget? bottom}) {
  return AppBar(
    leadingWidth: leadingWidth,
    backgroundColor: color ?? AppColors.colorGreen,
    centerTitle: centerTitle ?? true,
    bottom: bottom,
    titleSpacing: titleSpacing,
    toolbarHeight: toolbarHeight,
    leading: leading,
    iconTheme: IconThemeData(color: iconColor ?? Colors.white),
    actions: actions,
    title: titleWidget ??
        CommonTextWidget(
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
      Navigator.of(context, rootNavigator: false).context,
      routeName,
      (route) => true);
}

commonProfileIcon({double? width, double? height, String? path}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(100),
    child: setAssetImage(
      width: width ?? 60,
      height: height ?? 60,
      fit: BoxFit.cover,
      image: path ?? icPatientUser4,
    ) /*commonImageNetworkWidget(path: provider.patients[index].photo)*/,
  );
}

commonProfileNetUrl({double? width, double? height, String? path}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(100),
    child: CachedNetworkImage(
      width: width ?? 60,
      height: height ?? 60,
      fit: BoxFit.cover,
      imageUrl: path ?? '',
    ) /*commonImageNetworkWidget(path: provider.patients[index].photo)*/,
  );
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

commonSessionError({required BuildContext context, bool isAuth = false}) {
  showCommonDialog(
    context: context,
    title: "Error",
    content: errorMessage ?? '',
    btnPositive: "Close",
    onPressPositive: () {
      if (!isAuth) {
        PreferenceHelper.clear();
        pushNamedAndRemoveUntil(
            context: context, routeName: RouteName.loginScreen);
      } else {
        Navigator.of(context).pop();
      }
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

appBarView({required BuildContext context, String? title}) {
  return commonAppBar(
      title: title,
      leading: const Icon(
        Icons.dashboard_rounded,
        color: Colors.white,
      ),
      color: AppColors.colorGreen,
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
      child: CommonTextWidget(
          text: text ?? '',
          textAlign: textAlign,
          textColor: color,
          fontWeight: fontWeight ?? FontWeight.w500,
          fontSize: fontSize ?? fourteen));
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

Widget buildPopupMenu({required ProcedureProvider provider, String? id}) {
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
        //  provider.deleteProcedureCharges(context: context)
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

commonLogoutDialog(
    {required BuildContext contextAd,
    required bool isMobile,
    double? width,
    required bool isDesktop}) {
  showDialog(
      barrierDismissible: false,
      context: contextAd,
      builder: (BuildContext context) {
        var size = MediaQuery.sizeOf(contextAd);
        return CustomAlertDialog(
          content: SizedBox(
            width: width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CommonTextWidget(
                        text: "Are you sure you want to sign out?",
                        fontSize: 16,
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.w700,
                        top: 20,
                      ),
                      CommonTextWidget(
                        text:
                            "You are also logged out from local data apps open in this browser.",
                        fontSize: 14,
                        textAlign: TextAlign.center,
                        top: 20,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Flexible(
                            child: CommonButtonWidget(
                              height: 40,
                              width: isMobile ? size.width : size.width * 0.08,
                              radius: 8,
                              onPressed: () async {
                                await PreferenceHelper.clear();
                                pushNamedAndRemoveUntil(
                                    context: context,
                                    routeName: RouteName.loginScreen);
                              },
                              colorButton: Colors.red,
                              fontSize: 11,
                              padding: EdgeInsets.only(
                                  left: isMobile ? 0 : 40,
                                  right: isMobile ? 0 : 40,
                                  top: 10,
                                  bottom: 10),
                              text: "Logout",
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: CommonButtonWidget(
                              text: "Cancel",
                              height: 40,
                              width: isMobile ? size.width : size.width * 0.08,
                              radius: 8,
                              colorBorder: Colors.black,
                              colorButton: Colors.white,
                              colorText: Colors.black,
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              fontSize: 11,
                              padding: EdgeInsets.only(
                                  left: isMobile ? 0 : 40,
                                  right: isMobile ? 0 : 40),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      });
}

showPopoverMenu(
    {required BuildContext context,
    required Size size,
    Color? colorBg,
    required Widget child,
    double? width,
    double? height}) {
  showPopover(
    barrierColor: Colors.transparent,
    context: context,

    transition: PopoverTransition.scale,
    backgroundColor: colorBg ?? AppColors.colorBgNew,
    bodyBuilder: (context) {
      return Container(
        // color: colorBg??Colors.white,

        child: child,
      );
    },
    onPop: () => print('Popover was popped!'),
    direction: PopoverDirection.bottom,
    width: width ?? size.width * 0.15,
   // height: height ?? size.height * 0.4,
    arrowHeight: 15,
    arrowWidth: 30,
  );
}
