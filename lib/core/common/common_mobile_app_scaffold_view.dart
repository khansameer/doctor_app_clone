import 'package:doctor_app/screen/mobile_view/chat_screen/patient_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:doctor_app/core/color_utils.dart';

import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/responsive.dart';
import 'package:doctor_app/provider/dashboard_provider.dart';
import 'package:doctor_app/screen/mobile_view/home/home_screen.dart';
import 'package:doctor_app/screen/mobile_view/profile/edit_profile_screen.dart';
import 'package:provider/provider.dart';

import '../../BaseScreen.dart';

class CommonMobileAppScaffoldView extends StatefulWidget {
  const CommonMobileAppScaffoldView({super.key, this.page});
  final Widget? page;

  @override
  State<CommonMobileAppScaffoldView> createState() =>
      _CommonMobileAppScaffoldViewState();
}

class _CommonMobileAppScaffoldViewState
    extends State<CommonMobileAppScaffoldView> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(
      onSelectedPage: (value) {},
    ),
    Container(),
    const PatientListScreen(),
    const EditProfileScreen()
  ];

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: _screens[_selectedIndex],
      currentIndex: _selectedIndex,
      onTabSelected: _onTabSelected,
    );
  }
}
