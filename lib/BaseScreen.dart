import 'package:doctor_app/core/color_utils.dart';
import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:flutter/material.dart';

class BaseScreen extends StatelessWidget {
  final Widget child;
  final int currentIndex;
  final Function(int) onTabSelected;

  const BaseScreen({
    super.key,
    required this.child,
    required this.currentIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text('App Title'),
      ),
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 2,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: colorAmber,
        selectedLabelStyle: commonTextStyle(fontSize: 11),
        unselectedLabelStyle: commonTextStyle(fontSize: 11),
        unselectedItemColor: Colors.grey,
        currentIndex: currentIndex,
        onTap: onTabSelected,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.question_answer), label: 'Q&A'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
