import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/custom_alert_dialog.dart';
import 'package:doctor_app/core/common/app_scaffold.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/common/common_textfield.dart';
import 'package:doctor_app/core/common/file_picker_helper.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/context_extension.dart';
import 'package:doctor_app/core/route/route.dart';
import 'package:doctor_app/provider/patient_provider.dart';
import 'package:doctor_app/screen/web_view/screen/calender/add_appointments_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PatientsScreen extends StatefulWidget {
  const PatientsScreen({super.key});

  @override
  State<PatientsScreen> createState() => _PatientsScreenState();
}

class _PatientsScreenState extends State<PatientsScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<PatientProvider>()
          .getPatientDetails(context: context)
          .then((value) {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<PatientProvider>();
    return AppScaffold(
        right: 0,
        left: 0,
        color: Colors.white,
        appBar: commonAppBar(title: "Patient".toUpperCase()),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 6,
                    child: CommonTextField(
                      right: 20,
                      height: 36,
                      padding: 0,
                      onChange: (query) {
                        context
                            .read<PatientProvider>()
                            .updateSearchQuery(query);
                      },
                      fontSize: 12,
                      colorFill: Colors.white,
                      hint: "Search Patient Name/ID/Phone number",
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: buildPopupMenuFilter()),
                  ),
                  const SizedBox(
                    width: 15,
                  )
                ],
              ),
            ),
            const Divider(
              height: 2,
              thickness: 0.3,
            ),
            Expanded(
              child: Stack(
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: provider.patients?.length ?? 0,
                    itemBuilder: (context, index) {
                      var data = provider.patients?[index];
                      return Container(
                        margin: const EdgeInsets.all(0),
                        child: ListTile(
                          dense: true,
                          onTap: () {
                            pushScreen(
                              context: context,
                              routeName: RouteName.patientInfoScreen,
                            );
                          },
                          trailing: buildPopupMenu(id: data?.toString()),
                          leading: Container(
                            height: 40,
                            width: 40,
                            decoration: commonBoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primary,
                              border: Border.all(color: Colors.grey, width: 0),
                            ),
                            child: Center(
                              child: CommonTextWidget(
                                textColor: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                text:
                                    data?.firstName.toString().toUpperCase()[0],
                              ),
                            ),
                          ),
                          title: CommonTextWidget(
                            text:
                                '${data?.firstName?.toString().toCapitalize()} ${data?.lastName.toString()}',
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                          ),
                          subtitle: CommonTextWidget(
                            text: data?.gender.toString(),
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(
                        thickness: 0.3,
                      );
                    },
                  ),
                  provider.isAdding ? showLoaderList() : const SizedBox.shrink()
                ],
              ),
            ),
          ],
        ));
  }

  Widget buildPopupMenu({String? id}) {
    return PopupMenuButton<String>(
      offset: const Offset(-0, 30),
      color: Colors.white,
      onSelected: (String value) async {
        // Handle the create option
        if (value == 'create') {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return CustomAlertDialog(
                  content: AddAppointmentsWidget(
                    dateTime: DateTime.now(),
                    patientID: id,
                  ),
                );
              });
        } else if (value == 'upload') {
          FilePickerResult? filePath = await FilePickerHelper.pickFile();
          if (filePath != null) {
            // Handle the selected file path
            if (kDebugMode) {
              print('Selected file: $filePath');
            }
            // You can also display it in a dialog or another widget
          } else {
            // Handle the case when no file is selected
            if (kDebugMode) {
              print('No file selected or permission denied');
            }
          }

          // Handle Inactive logic
          if (kDebugMode) {
            print('Inactive selected');
          }
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'create',
          child: commonMenuWidget(
              text: 'Create An Appointments', icon: Icons.person_add),
        ),
        PopupMenuItem<String>(
          value: 'Consultation',
          child: commonMenuWidget(text: 'Consult', icon: Icons.video_call),
        ),
        PopupMenuItem<String>(
          value: 'upload',
          child: commonMenuWidget(text: 'Upload File', icon: Icons.upload_file),
        ),
        PopupMenuItem<String>(
          value: 'delete',
          child: commonMenuWidget(text: 'Delete', icon: Icons.delete),
        ),
      ],
      child: const Icon(
        Icons.more_vert,
        color: Colors.grey,
      ), // Icon to trigger the pop-up menu
    );
  }

  Widget buildPopupMenuFilter({String? id}) {
    return PopupMenuButton<String>(
      menuPadding: EdgeInsets.zero,
      constraints: const BoxConstraints.tightFor(width: 200),
      offset: const Offset(-0, 30),
      color: Colors.white,
      onSelected: (String value) async {
        if (value == 'All') {
          context.read<PatientProvider>().clearFilter();
        } else if (value == 'all_female') {
          context.read<PatientProvider>().filterByGender("female");
        } else if (value == 'all_male') {
          context.read<PatientProvider>().filterByGender("male");
        } else if (value == 'female_under30') {
          //  provider.filterByAges(age: 30, isUnder: true);
        } else if (value == 'female_over30') {
          // provider.filterByAges(age: 30, isUnder: false);
        }
      },

      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'All',
          child: commonMenuWidget(
              text: "All Patients", icon: Icons.personal_injury_outlined),
        ),

        //
        PopupMenuItem<String>(
          value: 'all_female',
          child:
              commonMenuWidget(text: "All Female Customer", icon: Icons.female),
        ),
        PopupMenuItem<String>(
          value: 'all_male',
          child: commonMenuWidget(text: "All Male Customer", icon: Icons.male),
        ),
        PopupMenuItem<String>(
          value: 'female_under30',
          child: commonMenuWidget(
              text: "Female Customer under 30", icon: Icons.female),
        ),
        PopupMenuItem<String>(
          value: 'female_over30',
          child: commonMenuWidget(),
        ),
      ],
      child: const Icon(
        Icons.filter_alt_outlined,
        color: Colors.grey,
      ), // Icon to trigger the pop-up menu
    );
  }

  commonMenuWidget({
    String? text,
    IconData? icon,
  }) {
    return Row(
      children: [
        Icon(
          icon ?? Icons.female,
          color: Colors.black.withOpacity( 0.6),
        ),
        Flexible(
            child: CommonTextWidget(
          text: text ?? 'Female Customer Over 30',
          fontSize: 11,
          left: 5,
          fontWeight: FontWeight.w600,
          textColor: Colors.black.withOpacity( 0.6),
        )),
      ],
    );
  }
}
