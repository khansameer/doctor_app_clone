import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/provider/dashboard_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminNotificationScreen extends StatelessWidget {
  const AdminNotificationScreen({super.key, required this.isDialog});

  final bool isDialog;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);

    return Consumer<DashboardProvider>(builder: (context, provider, child) {
      return Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 12.0),
        child: Container( width: double.infinity,
          constraints: BoxConstraints(
            maxWidth: MediaQuery.sizeOf(context).width*0.3,maxHeight: MediaQuery.sizeOf(context).width*0.5
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Triangle at the top of the popup
              CustomPaint(
                size: Size(20, 10), // Adjust size as needed
                painter: TrianglePainter(color: AppColors.colorActive),
              ),
              // Notification List
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10.0,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: provider.doctorNotifications.length,
                    itemBuilder: (context, index) {
                      var data = provider.doctorNotifications[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CommonTextWidget(
                          text: data.toString(),
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(
                        thickness: 0.3,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
// Custom painter to draw the triangle
class TrianglePainter extends CustomPainter {
  final Color color;

  TrianglePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width / 2, 0); // Start at top center
    path.lineTo(0, size.height); // Bottom left
    path.lineTo(size.width, size.height); // Bottom right
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}


