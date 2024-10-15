import 'package:doctor_app/core/route/route.dart';
import 'package:doctor_app/screen/authentication/forgot/forgot_password_opt_view.dart';
import 'package:doctor_app/screen/authentication/forgot/forgot_password_reset_view.dart';
import 'package:doctor_app/screen/authentication/forgot/forgot_screen.dart';
import 'package:doctor_app/screen/authentication/login/login_screen.dart';
import 'package:doctor_app/screen/authentication/login/view/signup_view.dart';
import 'package:doctor_app/screen/dashboard/calender/calender_screen.dart';
import 'package:doctor_app/screen/dashboard/chat_screen/chat_screen.dart';
import 'package:doctor_app/screen/dashboard/dashboard_screen.dart';
import 'package:doctor_app/screen/dashboard/health_feed/health_feed_screen.dart';
import 'package:doctor_app/screen/dashboard/notification/notificatio_screen.dart';
import 'package:doctor_app/screen/dashboard/paitent_screen/patients_screen.dart';
import 'package:doctor_app/screen/dashboard/profile/profile_screen.dart';
import 'package:doctor_app/screen/dashboard/setting/setting_screen.dart';
import 'package:doctor_app/screen/splash_screen.dart';
import 'package:flutter/material.dart';

import '../../screen/dashboard/report_and_issue/report_and_issue_screen.dart';


class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case RouteName.splashScreen:
        return MaterialPageRoute(
            builder: (_) => const SplashScreen(),
            settings: const RouteSettings(name: RouteName.splashScreen));
      case RouteName.loginScreen:
        return MaterialPageRoute(
            builder: (_) => const LoginScreen(),
            settings: const RouteSettings(name: RouteName.loginScreen));
      case RouteName.signUPScreen:
        return MaterialPageRoute(
            builder: (_) => const SignupView(),
            settings: const RouteSettings(name: RouteName.signUPScreen));
      case RouteName.forgotPasswordScreen:
        return MaterialPageRoute(
            builder: (_) => const ForgotScreen(),
            settings:
                const RouteSettings(name: RouteName.forgotPasswordScreen));
      case RouteName.forgotPasswordOptView:
        return MaterialPageRoute(
            builder: (_) => const ForgotPasswordOptView(),
            settings:
                const RouteSettings(name: RouteName.forgotPasswordOptView));

      case RouteName.forgotPasswordResetView:
        return MaterialPageRoute(
            builder: (_) => const ForgotPasswordResetView(),
            settings:
                const RouteSettings(name: RouteName.forgotPasswordResetView));
      case RouteName.dashboardScreen:
        return MaterialPageRoute(
            builder: (_) => const DashboardScreen(),
            settings:
            const RouteSettings(name: RouteName.dashboardScreen));
      case RouteName.notificationScreen:
        return MaterialPageRoute(
            builder: (_) => const NotificationScreen(),
            settings:
            const RouteSettings(name: RouteName.notificationScreen));
      case RouteName.settingScreen:
        return MaterialPageRoute(
            builder: (_) => const SettingScreen(),
            settings:
            const RouteSettings(name: RouteName.settingScreen));


      case RouteName.reportAndIssueScreen:
        return MaterialPageRoute(
            builder: (_) => const ReportAndIssueScreen(),
            settings:
            const RouteSettings(name: RouteName.reportAndIssueScreen));

      case RouteName.healthFeedScreen:
        return MaterialPageRoute(
            builder: (_) => const HealthFeedScreen(),
            settings:
            const RouteSettings(name: RouteName.healthFeedScreen));

      case RouteName.profileScreen:
        return MaterialPageRoute(
            builder: (_) => const ProfileScreen(),
            settings:
            const RouteSettings(name: RouteName.profileScreen));

      case RouteName.patientsScreen:
        return MaterialPageRoute(
            builder: (_) => const PatientsScreen(),
            settings:
            const RouteSettings(name: RouteName.patientsScreen));
      case RouteName.calenderScreen:
        return MaterialPageRoute(
            builder: (_) => const CalenderScreen(),
            settings:
            const RouteSettings(name: RouteName.calenderScreen));
      case RouteName.chatScreen:
        return MaterialPageRoute(
            builder: (_) => const ChatScreen(),
            settings:
            const RouteSettings(name: RouteName.chatScreen));

      default:
        return MaterialPageRoute(
            builder: (_) =>
                const Scaffold(body: SafeArea(child: Text('Route Error'))));
    }
  }
}
