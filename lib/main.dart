import 'dart:io';

import 'package:doctor_app/core/route/route.dart';
import 'package:doctor_app/core/route/route_generator.dart';

import 'package:doctor_app/core/string/string_utils.dart';
import 'package:doctor_app/provider/admin_dashboard_provider.dart';

import 'package:doctor_app/provider/auth_provider.dart';
import 'package:doctor_app/provider/appointments_provider.dart';
import 'package:doctor_app/provider/billing_provider.dart';
import 'package:doctor_app/provider/chat_provider.dart';
import 'package:doctor_app/provider/dashboard_provider.dart';
import 'package:doctor_app/provider/patient_provider.dart';
import 'package:doctor_app/provider/procedure_provider.dart';
import 'package:doctor_app/provider/report_provier.dart';
import 'package:doctor_app/screen/agora_video_call.dart';
import 'package:doctor_app/screen/call_demo.dart';
import 'package:doctor_app/screen/web_view/admin_dashboard_view/feedback/provider/feedback_provider.dart';
import 'package:doctor_app/screen/web_view/admin_dashboard_view/notification/provider/setting_notification_provider.dart';
import 'package:doctor_app/screen/web_view/video_call/CallScreen.dart';

import 'package:doctor_app/shared_preferences/preference_helper.dart';
import 'package:doctor_app/video_skd/JoinScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:window_manager/window_manager.dart';
import 'core/firebase/firebase_options.dart';
import 'provider/address_provider.dart';
import 'provider/prescription_provider.dart';
import 'provider/profile_provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

List<SingleChildWidget> providers = [
  ChangeNotifierProvider<AuthProviders>(create: (_) => AuthProviders()),
  ChangeNotifierProvider<DashboardProvider>(create: (_) => DashboardProvider()),
  ChangeNotifierProvider<ChatProvider>(create: (_) => ChatProvider()),
  ChangeNotifierProvider<ProfileProvider>(create: (_) => ProfileProvider()),
  ChangeNotifierProvider<AppointmentsProvider>(
      create: (_) => AppointmentsProvider()),
  ChangeNotifierProvider<ProcedureProvider>(create: (_) => ProcedureProvider()),
  ChangeNotifierProvider<AdminDashboardProvider>(
      create: (_) => AdminDashboardProvider()),
  ChangeNotifierProvider<PatientProvider>(create: (_) => PatientProvider()),
  ChangeNotifierProvider<ReportProvider>(create: (_) => ReportProvider()),
  ChangeNotifierProvider<AddressProvider>(create: (_) => AddressProvider()),
  ChangeNotifierProvider<PrescriptionProvider>(
      create: (_) => PrescriptionProvider()),
  ChangeNotifierProvider<SettingNotificationProvider>(
      create: (_) => SettingNotificationProvider()),
  ChangeNotifierProvider<FeedbackProvider>(create: (_) => FeedbackProvider()),
  ChangeNotifierProvider<BillingProvider>(create: (_) => BillingProvider()),
];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb && (Platform.isMacOS || Platform.isWindows)) {
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = const WindowOptions(
      size: Size(900, 700),
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });

    windowManager.setResizable(false);
    windowManager.setMaximizable(false);
  }

  PreferenceHelper.load().then((value) {});
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        navigatorKey: navigatorKey, // Set the navigatorKey
        title: appName,
/*        initialRoute: RouteName.splashScreen,
        onGenerateRoute: RouteGenerator.generateRoute,*/
          home: CallScreen(meetingId: ''),
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: const TextScaler.linear(1.0)),
            child: child ?? Container(),
          );
        },
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
      ),
    );
  }
}
