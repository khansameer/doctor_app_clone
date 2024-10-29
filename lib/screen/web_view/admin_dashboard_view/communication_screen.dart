import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/image/image_path.dart';
import 'package:doctor_app/provider/admin_dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommunicationScreen extends StatefulWidget {
  const CommunicationScreen({super.key});

  @override
  State<CommunicationScreen> createState() => _CommunicationScreenState();
}

class _CommunicationScreenState extends State<CommunicationScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.grey[200],
              child: Consumer<AdminDashboardProvider>(
                builder: (context, chatModel, child) {
                  return ListView.builder(
                    itemCount: chatModel.patients.length,
                    itemBuilder: (context, index) {
                      var data = chatModel.patients[index];
                      return Container(
                        color: index == chatModel.selectedUserIndex
                            ? AppColors.primaryLight1
                            : Colors.transparent,
                        child: ListTile(
                          titleAlignment: ListTileTitleAlignment.center,
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: setAssetImage(
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                              image: icDummyUser,
                            ) /*commonImageNetworkWidget(path: provider.patients[index].photo)*/,
                          ),
                          title: CommonTextWidget(
                            text: data.name,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                          subtitle: CommonTextWidget(
                            text: "Typing...",
                            fontSize: 11,
                            textColor: Colors.blue,
                          ),
                          onTap: () {
                            chatModel.selectUser(index);
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              color: Colors.white,
              child: Consumer<AdminDashboardProvider>(
                builder: (context, chatModel, child) {
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: chatModel.messages.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Align(
                                alignment: index % 2 == 0
                                    ? Alignment.centerLeft
                                    : Alignment.centerRight,
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: index % 2 == 0
                                        ? Colors.grey[300]
                                        : AppColors.primaryLight1,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    chatModel.messages[index],
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "Type a message",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.send),
                              onPressed: () {
                                // Add functionality to send message
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
