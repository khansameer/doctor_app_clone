import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/image/image_path.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key,this.message});

  final String? message;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      width: size.width,
      padding: const EdgeInsets.all(16),
      height: size.height,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center ,
          children: [
            setAssetImage(image: icNoDataFound,width: 200,height: 200),
            CommonTextWidget(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              top: 20,
              text:"Page Not Found",
            ),
            CommonTextWidget(
              fontWeight: FontWeight.w400,

              textStyle: GoogleFonts.mulish(
                  fontSize: 13,
                color: AppColors.colorTextNew
              ),


              text:message?? "Sorry, the page you’re looking for does not exist or has been moved please go back to the Home page",
            ),
          ],
        ),
      ),
    );
  }
}
