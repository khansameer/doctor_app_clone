import 'package:doctor_app/core/color_utils.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/image/image_path.dart';
import 'package:flutter/material.dart';

class SummaryViewScreen extends StatelessWidget {
  const SummaryViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Container(
      color: colorGreen.withOpacity(0.10),
      child: ListView(
        children: [
          commonBox(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(12.0),
                child: CommonTextWidget(
                  text: "Calender".toUpperCase(),
                  fontSize: 13,
                ),
              ),
              Container(
                  width: size.width,
                  color: Colors.grey.withOpacity(0.10),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: CommonTextWidget(
                        fontSize: 12,
                        text: "No upcoming appointment or events today",
                      ),
                    ),
                  )),
              Container(
                width: size.width,
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    commonInkWell(
                        child: CommonTextWidget(
                      fontWeight: FontWeight.w800,
                      text: "View All".toUpperCase(),
                      fontSize: 12,
                      textColor: colorAmber,
                    )),
                    const SizedBox(
                      width: 10,
                    ),
                    commonInkWell(
                        child: CommonTextWidget(
                      fontWeight: FontWeight.w800,
                      textColor: colorAmber,
                      text: "Add Appointment".toUpperCase(),
                      fontSize: 12,
                    ))
                  ],
                ),
              )
            ],
          )),
          commonBox(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: setAssetImage(
                            fit: BoxFit.scaleDown,
                            image: icLoginLogo,
                            width: 90,
                            height: 90)),
                    Expanded(
                      flex: 8,
                      child: Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(0.0),
                        child: CommonTextWidget(
                          text:
                              "Congrats! You have successfully published your profile on Practo.com",
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
          commonBox(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: setAssetImage(
                            fit: BoxFit.scaleDown,
                            image: icLoginLogo,
                            width: 90,
                            height: 90)),
                    Expanded(
                      flex: 8,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            color: Colors.white,
                            padding: const EdgeInsets.all(0.0),
                            child: CommonTextWidget(
                              text:
                                  "Increase the visibility of your practice amongst millions of patients on Practo. ",
                              fontSize: 13,
                            ),
                          ),
                          commonInkWell(
                              child: CommonTextWidget(
                            top: 10,
                            fontWeight: FontWeight.w800,
                            textColor: colorAmber,
                            text: "GET PRACTO REACH".toUpperCase(),
                            fontSize: 12,
                          ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
          commonBox(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(12.0),
                child: CommonTextWidget(
                  text: "Consult".toUpperCase(),
                  fontSize: 13,
                ),
              ),
              const Divider(
                thickness: 0.3,
              ),
              Container(
                  width: size.width,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: Column(
                        children: [
                          setAssetImage(
                              fit: BoxFit.scaleDown,
                              image: icLoginLogo,
                              width: 90,
                              height: 90),
                          CommonTextWidget(
                            top: 5,
                            textAlign: TextAlign.center,
                            fontSize: 12,
                            text:
                                "You have deactivated consult. No questions will be assigned to you till you activate it again",
                          ),
                        ],
                      ),
                    ),
                  )),
              const Divider(
                thickness: 0.3,
              ),
              Container(
                width: size.width,
                padding: const EdgeInsets.all(12.0),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              )
            ],
          )),
          commonBox(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(12.0),
                child: CommonTextWidget(
                  text: "Health Feed".toUpperCase(),
                  fontSize: 13,
                ),
              ),

              Container(
                  width: size.width,
                  color: Colors.grey.withOpacity(0.10),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: CommonTextWidget(
                        fontSize: 12,
                        text: "No Article data yet.",
                      ),
                    ),
                  )),
              
              Container(
                width: size.width,
                padding: const EdgeInsets.all(12.0),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 15,
                    )
                  ],
                ),
              )
            ],
          )),
        ],
      ),
    );
  }

  commonBox({Widget? child}) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: const EdgeInsets.all(10),
      decoration: commonBoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: child,
    );
  }
}
