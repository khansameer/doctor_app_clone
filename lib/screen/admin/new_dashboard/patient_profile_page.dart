import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/CustomAlertDialog.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/common/common_textfield.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/context_extension.dart';
import 'package:doctor_app/core/responsive.dart';
import 'package:doctor_app/provider/calender_provider.dart';
import 'package:doctor_app/screen/admin/model/patient_details_model.dart';
import 'package:doctor_app/screen/admin/new_dashboard/calender/add_appointments_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PatientProfilePage extends StatefulWidget {
  const PatientProfilePage({super.key,this.title});

 final String ?title;
  @override
  State<PatientProfilePage> createState() => _PatientProfilePageState();
}

class _PatientProfilePageState extends State<PatientProfilePage> {
  List<Patients> patients=[];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CalenderProvider>().getPatientDetails();




    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    var isMobile = Responsive.isMobile(context);
    return Consumer<CalenderProvider>(
      builder: (context,provider,child) {

      if(widget.title=="all"){

        patients=context.read<CalenderProvider>().patientDetailsModel?.patients??[];
        print('====filterByAge====${ Provider.of<CalenderProvider>(context, listen: false).filterByAge(age: 30, isUnder: true)?.length}');
      }
      else if(widget.title=="all_female"){
        patients=context.read<CalenderProvider>().filterBYGender(gender: 'female')??[];
      }
      else if(widget.title=="all_male"){
        patients=context.read<CalenderProvider>().filterBYGender(gender: 'male')??[];
      }
      else if(widget.title=="female_under30"){
        patients=context.read<CalenderProvider>().filterByAge(age: 30, isUnder: true)??[];
      }
      else if(widget.title=="female_over30"){
        patients=context.read<CalenderProvider>().filterByAge(age: 30, isUnder: false)??[];
      }


        return Stack(
          children: [
            ListView(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    isMobile?Column(children: [
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
                                  colorFill: Colors.white,
                                  hint: "Search Patient Name/ID/Phone number",
                                ),
                              )),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: CommonTextWidget(
                                  text: "Advance Search",
                                  textColor: AppColors.primary,
                                  fontSize: 12))
                        ],
                      ),
                      const SizedBox(height: 20,),
                     /* Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(child:  commonButton(
                            colorText: Colors.black,
                            isShowBorder: true,

                            fontSize: 10,
                            btnText: "Print Label",
                            onPressed: () {},
                          ),),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(child: commonButton(
                            colorText: Colors.black,
                            isShowBorder: true,
                            fontSize: 10,
                            btnText: "Marge Patients",
                            onPressed: () {},
                          ),),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(child:   commonButton(
                            colorText: Colors.black,
                            isShowBorder: true,
                            fontSize: 10,
                            btnText: "Add new patients",
                            onPressed: () {},
                          ),),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      )*/
                    ],): Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  height: 40,
                                  width: 350,
                                  child: CommonTextField(
                                    colorFill: Colors.white,
                                    hint: "Search Patient Name/ID/Phone number",
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: CommonTextWidget(
                                        text: "Advance Search",
                                        textColor: AppColors.primary,
                                        fontSize: 12))
                              ],
                            )),

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
                            child:     Theme(
                              data: Theme.of(context).copyWith(
                                cardColor: Colors.white,
                                cardTheme: const CardTheme(
                                  color: Colors.white,
                                  elevation: 0,
                                ),
                                dataTableTheme: DataTableThemeData(
                                  headingRowColor: WidgetStateProperty.resolveWith<Color>(
                                          (Set<WidgetState> states) {
                                        // Set color for heading row
                                        return Colors.blueGrey[200]!; // example color
                                      }),
                                  dataRowColor: WidgetStateProperty.resolveWith<Color>(
                                          (Set<WidgetState> states) {
                                        // Set color for data rows
                                        return Colors.grey[200]!; // example color
                                      }),
                                  // Add other customizations here
                                ),
                              ),
                              child: Container(
                                color: Colors.white,
                                width: size.width,
                                child: PaginatedDataTable(
                                  showEmptyRows: false,

                                  columns: [
                                    DataColumn(
                                        label: CommonTextWidget(
                                          text: 'Name',
                                          fontWeight: FontWeight.w600,
                                        )),
                                    DataColumn(
                                        label: CommonTextWidget(
                                          text: 'Email',

                                          fontWeight: FontWeight.w600,
                                        )),
                                    DataColumn(
                                        label: CommonTextWidget(
                                          text: 'Phone Number',
                                          fontWeight: FontWeight.w600,
                                        )),
                                    DataColumn(
                                        label: CommonTextWidget(
                                          text: 'Gender',
                                          fontWeight: FontWeight.w600,
                                        )),
                                    DataColumn(
                                        label: CommonTextWidget(
                                          text: 'Date Of Birth',
                                          fontWeight: FontWeight.w600,
                                        )),
                                    DataColumn(
                                      numeric: true,
                                      label: CommonTextWidget(
                                        text: 'Action',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],

                                  source: MyData(patients,context),
                                  rowsPerPage: patients.length > 0 ? patients.length : 1//patients?.length??1,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
            provider.isFetching?showLoaderList():const SizedBox.shrink()
          ],
        );
      }
    );
  }


}
class MyData extends DataTableSource {

  MyData(this.patients,this.context);
  List<Patients>? patients;
  BuildContext context;


  @override
  DataRow? getRow(int index) {
    assert(index >= 0);

    final user = patients?[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(CommonTextWidget(fontSize: 12, text: '${user?.firstName.toString().toCapitalize()} ${user?.lastName.toString().toCapitalize()}')),
        DataCell(CommonTextWidget(fontSize: 12, text: user?.email.toString())),
        DataCell(CommonTextWidget(fontSize: 12, text: user?.phoneNumber.toString())),
        DataCell(CommonTextWidget(fontSize: 12, text: user?.gender.toString())),
        //DataCell(CommonTextWidget(fontSize: 12, text: user?.dateOfBirth.toString())),
        DataCell(CommonTextWidget(fontSize: 12, text: DateFormat('yyyy-MM-dd').format(DateTime.parse('${user?.dateOfBirth.toString()}')))),
        DataCell(buildPopupMenu()),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => patients!=null?patients!.length:1;

  @override
  int get selectedRowCount => 0;

  Widget buildPopupMenu() {
    return PopupMenuButton<String>(
      color: Colors.white,
      onSelected: (String value) {
        // Handle the create option
        if (value == 'create') {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return  CustomAlertDialog(
                  content: AddAppointmentsWidget(dateTime: DateTime.now(),),
                );
              });
        } else if (value == 'delete') {
          // Handle Inactive logic
          if (kDebugMode) {
            print('Inactive selected');
          }
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'create',
          child: Text('Create An Appointments'),
        ),
        const PopupMenuItem<String>(
          value: 'delete',
          child: Text('Delete'),
        ),
      ],
      child: const Icon(
        Icons.more_vert,
        color: Colors.grey,
      ), // Icon to trigger the pop-up menu
    );
  }
}
