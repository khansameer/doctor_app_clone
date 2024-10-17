import 'package:doctor_app/core/route/route.dart';
import 'package:doctor_app/core/route/route_generator.dart';
import 'package:doctor_app/core/string/string_utils.dart';
import 'package:doctor_app/provider/auth_provider.dart';
import 'package:doctor_app/provider/chat_provider.dart';
import 'package:doctor_app/provider/dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'shared_preferences/preference_helper.dart';
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

List<SingleChildWidget> providers = [
  ChangeNotifierProvider<AuthProviders>(create: (_) => AuthProviders()),
  ChangeNotifierProvider<DashboardProvider>(create: (_) => DashboardProvider()),
  ChangeNotifierProvider<ChatProvider>(create: (_) => ChatProvider()),
];

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  PreferenceHelper.load().then((value) {});
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
          initialRoute: RouteName.splashScreen,
        onGenerateRoute: RouteGenerator.generateRoute,
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
