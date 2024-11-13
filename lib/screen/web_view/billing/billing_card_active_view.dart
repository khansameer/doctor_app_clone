import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/common_button_widget.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/image/image_path.dart';
import 'package:doctor_app/provider/billing_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BillingCardActiveView extends StatelessWidget {
  const BillingCardActiveView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BillingProvider>(
      builder: (context,provider,child) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.separated(
                  shrinkWrap: true,

                  itemCount: provider.cards.length,
                  itemBuilder: (context,index){
                bool isSelected = provider.selectedIndex == index;
                var data= provider.cards[index];
                return ListTile(
                  contentPadding: EdgeInsets.all(5),
                  leading: Container(
                    width: 60,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black,width: 1),
                      borderRadius: BorderRadius.circular(8)
                    ),
                    height: 60,

                    child: Center(
                      child: setAssetImage(image: data['icon']??icVisa),
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        CommonTextWidget(text: "Edit",fontSize: 12,textColor: AppColors.colorBlue,),
                        SizedBox(width: 20,),
                        CommonTextWidget(text: "Archived",fontSize: 12,textColor: AppColors.colorBlue,)
                      ],
                    ),
                  ),
                  title: CommonTextWidget(text:data['name']??'',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,),
                  trailing: isSelected
                      ? Icon(
                      size: 28,
                      Icons.check_circle, color: Colors.green)
                      : Icon(
                    size: 28,
                    Icons.check_circle,color: Colors.grey.withOpacity(0.40),),
                  onTap: () {
                    provider.selectCard(index);
                  },
                );

              }, separatorBuilder: (BuildContext context, int index) { return Divider(thickness: 0.3,); },),
            ),
            Spacer(),
            Divider(thickness: 0.3,),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: CommonButtonWidget(text: "Add new card",
              left: 30,
              radius: 8,

              right: 30,
              height: 40,),
            )
          ],
        );
      }
    );
  }
}
