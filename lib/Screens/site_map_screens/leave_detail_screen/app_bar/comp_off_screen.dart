import 'package:attendencesheet/apis/api_service.dart';
import 'package:attendencesheet/controllers/query_employee_controller.dart';
import 'package:attendencesheet/controllers/reporting_manager_controller.dart';
import 'package:attendencesheet/widgets/drop_down_textfield.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../constants.dart';
import '../../../../models/employee_leave_model1.dart';


class CompOffScreen extends StatefulWidget {

  @override
  State<CompOffScreen> createState() => _CompOffScreenState();
}

class _CompOffScreenState extends State<CompOffScreen> {

  bool isLoading = false;

  final ReportingManagerController reportingManagerController = Get.find();
  final QueryEmployeeController queryEmployeeController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final ReportingManagerController reportingManagerController = Get.find();
    String reportingManagerName = "${reportingManagerController.reportingManagerFirstName} ${reportingManagerController.reporintManagerLastName}";
  }

  TextEditingController dateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final numberOfDaysController = SingleValueDropDownController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black,
        ),
        title: const Text(
            'LEAVES EDIT',
            style: Ktextstyledaily),
      ),
      body: (isLoading) ? const Center(child: CircularProgressIndicator()) :Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///Leave date
                  const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 9),
                      child: Text(
                        'LEAVE DATE',
                        style: KtextstyleActivity,
                      )),
                  const SizedBox(height: 10),
                  ///Calendar textfield
                  TextField(
                    controller: dateController,
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100));
                      if (pickedDate != null) {
                        String formatteddate = DateFormat('yyyy-MM-dd').format(pickedDate);
                        setState(() {
                          dateController.text = formatteddate;
                        });
                      }
                    },
                    decoration: InputDecoration(
                        hintText: 'Select Date',
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7))),
                  ),
                  const SizedBox(height: 20),
                  ///description text
                  const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 9),
                      child: Text(
                        'DESCRIPTION',
                        style: KtextstyleActivity,
                      )),
                  const SizedBox(height: 10),
                  ///description controller
                  TextFormField(
                    style:KtextstyleActivity1,
                    controller: descriptionController,
                    decoration: InputDecoration(
                      hintText: 'Enter Description',
                      hintStyle: KtextstyleActivity1,
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ///Number of days text
                  const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 9),
                      child: Text(
                        'NUMBER OF DAYS',
                        style: KtextstyleActivity,
                      )),
                  const SizedBox(height: 10),
                  ///Number of days textfield
                  DropDownTextFielD(
                      hintText: "Select Days",
                      controller: numberOfDaysController,
                      dropDownList: const [
                        DropDownValueModel(name: '0.5', value: '0.5'),
                        DropDownValueModel(name: '1', value: '1')
                      ]),

                  const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 9),
                      child: Text(
                        'APPROVING MANAGER',
                        style: KtextstyleActivity,
                      )),
                  const SizedBox(height: 10),
                  Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text("${queryEmployeeController.reportingManagerFirstName.value} ${queryEmployeeController.reportingManagerMiddleName.value} ${queryEmployeeController.reportingManagerLastName.value}",style: KtextstyleActivity1,),
                      )),
                ],
              ),
              Row(children: [
                Expanded(
                    flex: 4,
                    child: SizedBox(
                        height: 60,
                        child: GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: const Card(
                              color: Colors.grey,
                              child: Center(
                                  child: Text(
                                    'Cancel',
                                    style: Ktextstylecardbutton,
                                  ))),
                        ))),
                ///submit
                Expanded(
                  flex: 6,
                  child: SizedBox(
                      height: 60,
                      child: GestureDetector(
                          onTap: () async {
                            var typedDate = DateTime.parse(dateController.text.toString());
                            var earlyDate = DateTime.now().subtract(const Duration(days: 3));
                            if(typedDate.isAfter(DateTime.now())){
                              Get.snackbar("Unable to apply comp off",
                                  "You can't apply compOff 3 days after your working date or Future Date.");
                            }
                            else if(typedDate.isBefore(earlyDate)){
                              Get.snackbar("Unable to apply comp off",
                                  "You can't apply compOff 3 days after your working date or Future Date.");
                            }
                            else{
                              EmployeeLeaveModel1 employeeLeaveModel = await ApiService.setCompOffData(dateController.text, numberOfDaysController.dropDownValue!.value.toString(), descriptionController.text);
                              if(employeeLeaveModel.status == "1234567890"){
                                Get.snackbar("Unable to apply Comp Off", "You have alredy applied for given date",
                                  snackPosition: SnackPosition.TOP,
                                );
                              }
                              else{
                                Get.back();
                                Get.back();
                              }
                            }

                          },
                          child: const Card(
                              color: Colors.orangeAccent,
                              child: Center(
                                  child: Text(
                                    'SUBMIT',
                                    style: Ktextstylecardbutton,
                                  ))))),
                )
              ])
            ],
          ),
        ),
      ),
    );
  }
}
