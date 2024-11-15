import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/common/common_textfield.dart';
import 'package:doctor_app/core/common/custom_alert_dialog.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/provider/patient_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/responsive.dart';
import 'chat/web_chat_screen.dart';

class CommunicationScreen extends StatefulWidget {
  const CommunicationScreen({super.key});

  @override
  State<CommunicationScreen> createState() => _CommunicationScreenState();
}

class _CommunicationScreenState extends State<CommunicationScreen> {
  String? chatRoomId;
  int selectedUserIndex = -1; // Track the selected index

  String ?username;
  String ?userPhoto;
  @override
  void initState() {
    super.initState();


    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PatientProvider>(context, listen: false)
          .getDoctorList(context: context).then((value){

        getUserData('${context.read<PatientProvider>().doctorDetailsList[0].email}');
        username='${context.read<PatientProvider>().doctorDetailsList[0].firstName} ${context.read<PatientProvider>().doctorDetailsList[0].lastName}';
        userPhoto='${context.read<PatientProvider>().doctorDetailsList[0].profilePicture}';

      });
    });


  }
  void getUserData(String doctorEmail) async {
    String patientID = await getDoctorEmail(); // Fetch patient ID
    String doctorID = doctorEmail;

    // Generate the consistent chat room ID
    List<String> sortedEmails = [patientID, doctorID]..sort();
    setState(() {
      chatRoomId = '${sortedEmails[0]}_${sortedEmails[1]}';
    });
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    var isMobile = Responsive.isMobile(context);
    var isTablet = Responsive.isTablet(context);

    return SizedBox(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: isTablet ? 3 : 2,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3), //color of shadow
                      spreadRadius: 2, //spread radius
                      blurRadius: 3, // blur radius
                      offset: const Offset(0, 2),
                    )
                  ],
                  borderRadius: BorderRadius.circular(8)),
              height: size.height,
              margin: EdgeInsets.all(isMobile ? 0 : 30),
            //  margin: const EdgeInsets.only(left: 10, right: 10),
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: _commonUserList(isMobile: isMobile),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: chatRoomId==null
                  ? Center(child: Text('Select a doctor to chat')): WebChatScreen(
                name: username,
                profilePic: userPhoto,
                chatRoomId: chatRoomId,
                communication: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _commonUserList({required bool isMobile}) {
    var provider = context.watch<PatientProvider>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(10),
            shrinkWrap: true,
            itemCount: provider.doctorDetailsList.length,
            itemBuilder: (context, index) {
              var data = provider.doctorDetailsList[index];
              bool isSelected = index == provider.selectedUserIndex;
              return Container(
                margin: EdgeInsets.only(top: 0),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: isSelected ? AppColors.colorBgNew : Colors.transparent, // Set background color for selected item
                      borderRadius: BorderRadius.circular(8)),
                  child:
                      ListTile(
                    onTap: () {
                      if (isMobile) {
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) {
                              return CustomAlertDialog(
                                insetPadding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                content: WebChatScreen(
                                  chatRoomId: chatRoomId,
                                  communication: false,
                                ),
                              );
                            });
                      } else {
                        getUserData(data.email.toString());
                        provider.selectUser(index);
                        setState(() {
                          username='${data.firstName.toString()} ${data.lastName.toString()}';
                          userPhoto=data.profilePicture;
                        });


                      }
                    },
                    leading: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        commonImageNetworkWidget(
                            width: 40, height: 40, path: data.profilePicture)
                      ],
                    ),
                    title: CommonTextWidget(
                      text: '${data.firstName} ${data.lastName}',
                    ),
                    subtitle: CommonTextWidget(
                      text: '${data.email}',
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const Divider(
          thickness: 0.3,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            height: 40,
            child: CommonTextField(
              onChange: (query) {
                // context.read<AdminDashboardProvider>().updateSearchQuery(query);
              },
              hint: "Search",
              colorFill: AppColors.colorListView,
              //  hint: "Search Patient Name/ID/Phone number",
            ),
          ),
        ),
      ],
    );
  }
}
