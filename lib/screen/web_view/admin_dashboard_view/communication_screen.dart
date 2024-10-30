import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/image/image_path.dart';
import 'package:doctor_app/provider/admin_dashboard_provider.dart';
import 'package:doctor_app/screen/web_view/admin_dashboard_view/chat/revice_message_view.dart';
import 'package:doctor_app/screen/web_view/admin_dashboard_view/chat/sender_message_view.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/common/common_textfield.dart';

class CommunicationScreen extends StatefulWidget {
  const CommunicationScreen({super.key});

  @override
  State<CommunicationScreen> createState() => _CommunicationScreenState();
}

class _CommunicationScreenState extends State<CommunicationScreen> {
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.sizeOf(context);
    return Row(
      children: [
        Expanded(
          flex: 2,
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
              borderRadius: BorderRadius.circular(8)
            ),
            height: size.height*0.8,
            margin: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      Container(  padding: const EdgeInsets.all(10.0),

                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                            color: const Color.fromRGBO(250, 251, 253,1),
                          ),
                          child: TabBar(

                            unselectedLabelStyle: commonTextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                            isScrollable: false,
                            dividerColor: Colors.white,
                            indicatorSize: TabBarIndicatorSize.tab,
                            tabAlignment: TabAlignment.fill,

                            indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color:  AppColors.colorBgNew
                            ),
                            labelStyle: commonTextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500),
                            labelColor: AppColors.colorBlue,
                           // indicatorColor: AppColors.colorTextNew,
                            unselectedLabelColor: AppColors.colorBlue,

                            tabs: const [
                              Tab(text: 'Patients'),
                              Tab(text: 'Doctors'),

                            ],
                          ),
                        ),
                      ),
                       Expanded(
                        child: TabBarView(
                          children: [

                            _commonUserList(),
                            _commonUserList()
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Container(
            margin: const EdgeInsets.all(10),

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
                borderRadius: BorderRadius.circular(8)
            ),
            height: size.height*0.8,
            child: Consumer<AdminDashboardProvider>(
              builder: (context, chatModel, child) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [

                          Expanded(child: Row(
                            children: [
                              commonProfileIcon(
                                width: 45,
                                height: 45
                              ),
                              CommonTextWidget(text: "John Doe",fontSize: 16,fontWeight: FontWeight.w600,left: 10,)
                            ],
                          )),
                          Expanded(child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [

                              Container(
                                padding: const EdgeInsets.only(left: 25.0, right: 25,top: 10,bottom: 10),
                                margin: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: AppColors.colorBgNew,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Center(
                                  child: CommonTextWidget(
                                    text:"Case History",
                                    textColor:  AppColors.colorTextNew,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10,),
                              Flexible(
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  width: 40,
                                  decoration: const BoxDecoration(
                                      color: AppColors.colorBgNew,
                                      shape: BoxShape.circle),
                                  height: 40,
                                  child: const Center(
                                    child: Icon(
                                      size: 20,
                                      Icons.call_sharp,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10,),
                            ],
                          ))

                        ],
                      ),
                    ),
                    const Divider(thickness: 0.3,),
                    Expanded(
                      child: ListView.builder(
                        itemCount: chatModel.chatMessages.length,

                        itemBuilder: (context, index) {

                          if(chatModel.chatMessages[index].sentByUser){
                            return SenderMessageView(chatMessage: chatModel.chatMessages[index],);
                          }
                          else
                            {

                              return ReviceMessageView(chatMessage: chatModel.chatMessages[index],);
                            }
                        
                        },
                      ),
                    ),
                    const Divider(thickness: 0.3,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const SizedBox(width: 10,),
                          const Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,

                                //border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          Container(
                            width: 50,
                            height: 50,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.colorBgNew
                            ),
                            child:  Center(
                              child: setAssetImage(image: icSend, width: 20, height: 20),
                            ),
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
    );
  }

  _commonUserList(){
    return  Consumer<AdminDashboardProvider>(
      builder: (context, chatModel, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(10),
                shrinkWrap: true,
                itemCount: chatModel.dummyChatUsers.length,
                itemBuilder: (context, index) {
                  var data = chatModel.dummyChatUsers[index];
                  return Container(
                    padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(top: 0),
                    decoration: BoxDecoration(
                      color: index == chatModel.selectedUserIndex
                          ? AppColors.colorBgNew
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8)
                    ),
              
                    child: ListTile(
              
                      trailing: data.messageCount==0?const SizedBox.shrink():Container(
                        width: 30,
                        height: 30,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.colorNotification
                        ),
                        child: Center(
                          child: CommonTextWidget(text: '${data.messageCount}',fontSize: 10,
                          fontWeight: FontWeight.w700,),
                        ),
                      ),
                      titleAlignment: ListTileTitleAlignment.center,
                      leading: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: setAssetImage(
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                              image: icDummyUser,
                            ) /*commonImageNetworkWidget(path: provider.patients[index].photo)*/,
                          ),
                          data.messageCount==0?const SizedBox.shrink(): Positioned(
                              right: -5,

                              top: -3,
                              child: Container(width: 10,
                         decoration: const BoxDecoration(
                           color: Colors.green,
                           shape: BoxShape.circle
                         ),
                          height: 10,))
                        ],
                      ),
                      title: CommonTextWidget(
                        text: data.name,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                      subtitle: CommonTextWidget(
                        text: data.latestMessage,
                        fontSize: 11,
                        textColor:AppColors.colorBlue,
                      ),
                      onTap: () {
                        chatModel.selectUser(index);
                      },
                    ),
                  );
                },
              ),
            ),
            const Divider(thickness: 0.3,),
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
      },
    );
  }
}
