import 'package:doctor_app/core/color_utils.dart';
import 'package:doctor_app/core/common/app_scaffold.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:flutter/material.dart';

class HealthFeedScreen extends StatelessWidget {
  const HealthFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.sizeOf(context);
    return AppScaffold(
        left: 0,

        right: 0,
        appBar: commonAppBar(title: "Health Feed".toUpperCase()),
        child: Container(
          width: size.width,
          height: size.height,
          color: Colors.white,
          child: ListView(
            children: [


              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonTextWidget(
                      text: "Hello Dr. Bhavesh Gohil",
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                    CommonTextWidget(
                      text:
                          "Welcome on-board Health Feed 1- a community of doctors, who create exclusive health articles and tips for millions of people.",
                      top: 15,
                      fontSize: 15,
                    ),
                    CommonTextWidget(
                      text: "1500+ doctors have written articles",
                      fontSize: 13,
                      top: 20,
                    ),
                    CommonTextWidget(
                      text: "6000+ articles published till date",
                      fontSize: 13,
                      top: 15,
                    ),
                    CommonTextWidget(
                      text: "1,500,000 lives touched in last 30 days",
                      fontSize: 13,
                      top: 15,
                    ),

                  ],
                ),
              ),
              const Divider(thickness: 0.3,),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(20.0),
                child: CommonTextWidget(
                  text:
                      "To post your first article, log on to our web publishing tool at fit.practo.com",
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                  padding: const EdgeInsets.all(15.0),
                  color: Colors.grey.withOpacity(0.20),
                  child: CommonTextWidget(
                    text: "YOUR STATS  ",
                    fontWeight: FontWeight.w600,
                    left: 5,
                  )),
              commonView(),
              const Divider(thickness: 0.3,),
              commonView(title: "Article Likes"),
              const Divider(thickness: 0.3,),
              commonView(title: "Profile Views (via Health Feed)"),

            ],
          ),
        ));
  }

  commonView({String ?title}) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          CommonTextWidget(text: "0",fontSize: 20,),
          CommonTextWidget(text:title?? "Article Views",fontSize: 14,top: 5,textColor: Colors.grey,fontWeight: FontWeight.w600,)
        ],
      ),
    );
  }
}
