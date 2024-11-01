import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/provider/admin_dashboard_provider.dart';
import 'package:flutter/material.dart';

class CommonCallButton extends StatelessWidget {
  const CommonCallButton({super.key, required this.provider});
  final AdminDashboardProvider provider;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => provider.setHover(true),
      onExit: (_) => provider.setHover(false),
      child: AnimatedContainer(
        alignment: Alignment.topLeft,
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            color:
                provider.isHovered ? AppColors.colorBlue : AppColors.colorBgNew,
            /*color: AppColors.colorBgNew,*/
            shape: BoxShape.circle),
        duration: Duration(milliseconds: 200),
        child: Center(
          child: Icon(
            size: 18,
            Icons.call_sharp,
            color: provider.isHovered ? Colors.white : Colors.grey,
          ),
        ),
      ),
    );
  }
}
