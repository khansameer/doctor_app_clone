import 'dart:math';

import 'package:doctor_app/core/common/CustomAlertDialog.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/common/common_textfield.dart';
import 'package:doctor_app/core/common/date_time_utils.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/context_extension.dart';
import 'package:doctor_app/core/responsive.dart';
import 'package:doctor_app/core/route/route.dart';
import 'package:doctor_app/provider/calender_provider.dart';
import 'package:doctor_app/provider/dashboard_provider.dart';
import 'package:doctor_app/screen/web_view/model/patient_details_model.dart';
import 'package:doctor_app/screen/web_view/screen/calender/add_appointments_widget.dart';
import 'package:doctor_app/service/gloable_status_code.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/common/file_picker_helper.dart';


class PatientProfilePage extends StatefulWidget {
  const PatientProfilePage({super.key, this.title});

  final String? title;

  @override
  State<PatientProfilePage> createState() => _PatientProfilePageState();
}

class _PatientProfilePageState extends State<PatientProfilePage> {
  List<Patients> patients = [];
  List<Patients> filteredPatients = [];
  TextEditingController _searchController = TextEditingController();

  bool hasFetchedData = false; // Track if data has been fetched
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {

      context.read<CalenderProvider>().getPatientDetails().then((value) {
        if(globalStatusCode==401){
          showCommonDialog(
            context: context,
            title: "Error",
            content: errorMessage??'',
            btnPositive: "Close",
            onPressPositive: () {
              pushNamedAndRemoveUntil(
                  context: context,
                  routeName: RouteName.loginScreen);
            },
            isMessage: true,
          );
        }
        _searchController.addListener(() {
          context.read<CalenderProvider>().searchPatients(_searchController.text);
        });
      });
    });
    super.initState();
  }




  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    var isMobile = Responsive.isMobile(context);
    var provider=context.watch<CalenderProvider>();
    WidgetsBinding.instance.addPostFrameCallback((_){

       if (widget.title == "all") {
         _searchController.text.isEmpty?provider.getAllPatientsData():();
      } else if (widget.title == "all_female") {
      provider.filterBYGenders(gender: 'female');
      } else if (widget.title == "all_male") {
      provider.filterBYGenders(gender: 'male');
      } else if (widget.title == "female_under30") {
      provider.filterByAges(age: 30, isUnder: true);
      } else if (widget.title == "female_over30") {
      provider.filterByAges(age: 30, isUnder: false);

      }
    });

    int defaultRows = 1;
  //  int rowsPerPage = provider.filteredPatients?.isNotEmpty ?? false ? min(defaultRows,  provider.filteredPatients!.length) : defaultRows;

    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(
              height: 10,
            ),
            isMobile
                ? Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: SizedBox(
                          height: 40,
                          child: CommonTextField(
                            hint:
                            "Search Patient Name / ID /Phone number",
                            colorFill: Colors.white,
                            //  hint: "Search Patient Name/ID/Phone number",
                          ),
                        )),
                    const SizedBox(
                      width: 10,
                    ),

                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            )
                : Row(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      height: 40,
                      width: 350,
                      child: CommonTextField(
                        fontSize: 12,
                        controller: _searchController,
                        colorFill: Colors.white,
                        hint: "Search Patient Name/ID/Phone number",
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ],
            ),
            const Divider(
              thickness: 0.3,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 8,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    color: Colors.white,
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        cardColor: Colors.white,
                        cardTheme: const CardTheme(
                          color: Colors.white,
                          elevation: 0,
                        ),
                        dataTableTheme: DataTableThemeData(
                          headingRowColor:
                          WidgetStateProperty.resolveWith<Color>(
                                  (Set<WidgetState> states) {
                                // Set color for heading row
                                //return Colors.blueGrey[200]!; // example color
                                return const Color.fromRGBO(
                                    48, 180, 128, 1); // example color
                              }),
                          dataRowColor:
                          WidgetStateProperty.resolveWith<Color>(
                                  (Set<WidgetState> states) {
                                // Set color for data rows
                                //   return Colors.grey[200]!; // example color
                                return const Color.fromARGB(
                                    255, 240, 242, 241); // example color
                              }),
                          // Add other customizations here
                        ),
                      ),
                      child: Container(
                        color: Colors.white,
                        width: size.width,
                        child:provider.filteredPatients == null || provider.filteredPatients!.isEmpty?Text("No patients found."):PaginatedDataTable(
                            showEmptyRows: false,
                            columns: [
                              DataColumn(
                                  label: CommonTextWidget(
                                    text: 'Name',
                                    textColor: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  )),
                              DataColumn(
                                  label: CommonTextWidget(
                                    text: 'Email',
                                    textColor: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  )),
                              DataColumn(
                                  label: CommonTextWidget(
                                    text: 'Phone Number',
                                    textColor: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  )),
                              DataColumn(
                                  label: CommonTextWidget(
                                    text: 'Gender',
                                    textColor: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  )),
                              DataColumn(
                                  label: CommonTextWidget(
                                    text: 'Age',
                                    textColor: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  )),
                              DataColumn(
                                numeric: true,
                                label: CommonTextWidget(
                                  text: 'Action',
                                  textColor: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                            source: MyData( provider.filteredPatients, context),
                          //  availableRowsPerPage: const <int>[5, 10, 15], // List of selectable values
                          rowsPerPage: (provider.filteredPatients != null && provider.filteredPatients!.isNotEmpty)
                              ? provider.filteredPatients!.length
                              : 1,  // Default value when the list is empty

                        )
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
        provider.isAdding ? showLoaderList() : const SizedBox.shrink()
      ],
    );
  }
}

class MyData extends DataTableSource {
  MyData(this.patients, this.context);

  List<Patients>? patients;
  BuildContext context;

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);

    final user = patients?[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(CommonTextWidget(
            fontSize: 12,
            text:
                '${user?.firstName.toString().toCapitalize()} ${user?.lastName.toString().toCapitalize()}')),
        DataCell(CommonTextWidget(fontSize: 12, text: user?.email.toString())),
        DataCell(
            CommonTextWidget(fontSize: 12, text: user?.phoneNumber.toString())),
        DataCell(CommonTextWidget(fontSize: 12, text: user?.gender.toString())),
        //DataCell(CommonTextWidget(fontSize: 12, text: user?.dateOfBirth.toString())),
        DataCell(CommonTextWidget(
            fontSize: 12,
            text:
                '${DateTimeUtils.calculateAge(date: user!.dateOfBirth.toString())}' /*DateFormat('yyyy-MM-dd')
                .format(DateTime.parse('${user?.dateOfBirth.toString()}'))*/
            )),
        DataCell(buildPopupMenu(id: user.sId.toString())),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => patients != null ? patients!.length : 1;

  @override
  int get selectedRowCount => 0;

  Widget buildPopupMenu({String? id}) {
    return PopupMenuButton<String>(
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
          String? filePath = await FilePickerHelper.pickFile();
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
          child: CommonTextWidget(text: 'Create An Appointments'),
        ),
        PopupMenuItem<String>(
          value: 'consultation',
          child: CommonTextWidget(text: 'Consult'),
        ),
        PopupMenuItem<String>(
          value: 'upload',
          child: CommonTextWidget(text: 'Upload File'),
        ),
        PopupMenuItem<String>(
          value: 'delete',
          child: CommonTextWidget(text: 'Delete'),
        ),
      ],
      child: const Icon(
        Icons.more_vert,
        color: Colors.grey,
      ), // Icon to trigger the pop-up menu
    );
  }
}
