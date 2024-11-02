import 'package:doctor_app/core/app_constants.dart';
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
        width: forty,
        height: forty,
        decoration: BoxDecoration(
            color:
                provider.isHovered ? AppColors.colorBlue : AppColors.colorBgNew,
            /*color: AppColors.colorBgNew,*/
            shape: BoxShape.circle),
        duration: const Duration(milliseconds: 200),
        child: Center(
          child: Icon(
            size: eighteen,
            Icons.call_sharp,
            color: provider.isHovered ? Colors.white : Colors.grey,
          ),
        ),
      ),
    );
  }
}
