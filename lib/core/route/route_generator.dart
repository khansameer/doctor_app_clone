import 'package:doctor_app/core/route/route.dart';
import 'package:doctor_app/screen/web_view/screen/admin_dashboard/admin_dashboard.dart';

import 'package:doctor_app/screen/authentication/forgot/forgot_password_opt_view.dart';
import 'package:doctor_app/screen/authentication/forgot/forgot_password_reset_view.dart';
import 'package:doctor_app/screen/authentication/forgot/forgot_screen.dart';
import 'package:doctor_app/screen/authentication/login/login_screen.dart';
import 'package:doctor_app/screen/authentication/login/view/signup_view.dart';
import 'package:doctor_app/screen/mobile_view/calender/calender_screen.dart';
import 'package:doctor_app/screen/mobile_view/chat_screen/chat_screen.dart';
import 'package:doctor_app/screen/mobile_view/consult/consult_screen.dart';
import 'package:doctor_app/screen/mobile_view/dashboard_screen.dart';
import 'package:doctor_app/screen/mobile_view/health_feed/health_feed_screen.dart';
import 'package:doctor_app/screen/mobile_view/notification/notificatio_screen.dart';
import 'package:doctor_app/screen/mobile_view/paitent_screen/patient_information_screen.dart';
import 'package:doctor_app/screen/mobile_view/paitent_screen/patients_screen.dart';

import 'package:doctor_app/screen/mobile_view/profile/add_clinic_screen.dart';
import 'package:doctor_app/screen/mobile_view/profile/edit_profile_screen.dart';

import 'package:doctor_app/screen/mobile_view/patient_stories/patient_stories_screen.dart';
import 'package:doctor_app/screen/mobile_view/prime/prime_screen.dart';

import 'package:doctor_app/screen/mobile_view/profile/profile_screen.dart';
import 'package:doctor_app/screen/mobile_view/report/report_screen.dart';
import 'package:doctor_app/screen/mobile_view/setting/setting_screen.dart';
import 'package:doctor_app/screen/mobile_view/weekly_earning/weekly_earning_screen.dart';
import 'package:doctor_app/screen/splash_screen.dart';
import 'package:flutter/material.dart';

import '../../screen/mobile_view/reach/reach_screen.dart';
import '../../screen/mobile_view/report_and_issue/report_and_issue_screen.dart';
import '../../screen/web_view/screen/invoice/invoice_screen.dart';
import '../../screen/web_view/screen/procedure_charges_screen.dart';

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
            settings: const RouteSettings(name: RouteName.dashboardScreen));
      case RouteName.adminDashboardScreen:
        return MaterialPageRoute(
            builder: (_) => const AdminDashboard(),
            settings:
                const RouteSettings(name: RouteName.adminDashboardScreen));
      case RouteName.notificationScreen:
        return MaterialPageRoute(
            builder: (_) => const NotificationScreen(),
            settings: const RouteSettings(name: RouteName.notificationScreen));
      case RouteName.settingScreen:
        return MaterialPageRoute(
            builder: (_) => const SettingScreen(),
            settings: const RouteSettings(name: RouteName.settingScreen));
      case RouteName.reportAndIssueScreen:
        return MaterialPageRoute(
            builder: (_) => const ReportAndIssueScreen(),
            settings:
                const RouteSettings(name: RouteName.reportAndIssueScreen));

      case RouteName.healthFeedScreen:
        return MaterialPageRoute(
            builder: (_) => const HealthFeedScreen(),
            settings: const RouteSettings(name: RouteName.healthFeedScreen));

      case RouteName.profileScreen:
        return MaterialPageRoute(
            builder: (_) => const ProfileScreen(),
            settings: const RouteSettings(name: RouteName.profileScreen));

      case RouteName.patientsScreen:
        return MaterialPageRoute(
            builder: (_) => const PatientsScreen(),
            settings: const RouteSettings(name: RouteName.patientsScreen));
      case RouteName.patientInfoScreen:
        return MaterialPageRoute(
          builder: (ctx) => const PatientInformationScreen(),
          settings: const RouteSettings(name: RouteName.patientInfoScreen),
        );
      case RouteName.calenderScreen:
        return MaterialPageRoute(
            builder: (_) => const CalenderScreen(),
            settings: const RouteSettings(name: RouteName.calenderScreen));
      case RouteName.chatScreen:
        return MaterialPageRoute(
            builder: (_) => const ChatScreen(),
            settings: const RouteSettings(name: RouteName.chatScreen));
      case RouteName.consultScreen:
        return MaterialPageRoute(
            builder: (_) => const ConsultScreen(),
            settings: const RouteSettings(name: RouteName.consultScreen));
      case RouteName.reportScreen:
        return MaterialPageRoute(
            builder: (_) => const ReportScreen(),
            settings: const RouteSettings(name: RouteName.reportScreen));
      case RouteName.editprofileScreen:
        return MaterialPageRoute(
          builder: (ctx) => const EditProfileScreen(),
          settings: const RouteSettings(name: RouteName.editprofileScreen),
        );
      case RouteName.addClinicScreen:
        return MaterialPageRoute(
          builder: (ctx) => const AddClinicScreen(),
          settings: const RouteSettings(name: RouteName.addClinicScreen),
        );

      case RouteName.primeScreen:
        return MaterialPageRoute(
            builder: (_) => const PrimeScreen(),
            settings: const RouteSettings(name: RouteName.primeScreen));

      case RouteName.patientStoriesScreen:
        return MaterialPageRoute(
            builder: (_) => const PatientStoriesScreen(),
            settings:
                const RouteSettings(name: RouteName.patientStoriesScreen));

      case RouteName.reachScreen:
        return MaterialPageRoute(
            builder: (_) => const ReachScreen(),
            settings: const RouteSettings(name: RouteName.reachScreen));

      case RouteName.weeklyEarningScreen:
        return MaterialPageRoute(
            builder: (_) => const WeeklyEarningScreen(),
            settings: const RouteSettings(name: RouteName.weeklyEarningScreen));

      case RouteName.procedureChargesScreen:
        return MaterialPageRoute(
            builder: (_) => InvoiceScreen(),
            settings:
                const RouteSettings(name: RouteName.procedureChargesScreen));
      default:
        return MaterialPageRoute(
            builder: (_) =>
                const Scaffold(body: SafeArea(child: Text('Route Error'))));
    }
  }
}
