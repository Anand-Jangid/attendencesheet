import 'package:attendencesheet/apis/putdataapi.dart';
import 'package:attendencesheet/models/employee_leave_model1.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../constants.dart';


class ApplyLeaveScreen extends StatefulWidget {

  @override
  State<ApplyLeaveScreen> createState() => _ApplyLeaveScreenState();
}

class _ApplyLeaveScreenState extends State<ApplyLeaveScreen> {

  TextEditingController dateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final numberOfDaysController = SingleValueDropDownController();
  TextEditingController manager =TextEditingController(text:'Akshay Sir');

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
      body: Padding(
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
                  DropDownTextField(
                    textFieldDecoration: InputDecoration(
                        hintText: 'Select Days',
                        hintStyle: KtextstyleActivity,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10.0)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10.0))),
                    controller: numberOfDaysController,
                    clearOption: true,
                    dropdownRadius: 10.0,
                    textStyle: KtextstyleActivity1,
                    listTextStyle: KtextstyleActivity1,
                    dropDownList: const [
                      DropDownValueModel(name: '0.5', value: '0.5'),
                      DropDownValueModel(name: '1', value: '1')
                    ],
                    onChanged: (val) {},
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 9),
                      child: Text(
                        'APPROVING MANAGER',
                        style: KtextstyleActivity,
                      )),
                  SizedBox(height: 10),
                  TextFormField(
                    style:KtextstyleActivity1,
                    controller: manager,
                    readOnly: true,
                    decoration: InputDecoration(
                      hintStyle: KtextstyleActivity1,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                  ),
                ],
              ),
              Row(children: [
                Expanded(
                    flex: 4,
                    child: SizedBox(
                        height: 60,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
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
                          onTap: () async{
                            EmployeeLeaveModel1 employeeLeaveModel
                              = await ApiService.setLeaveData(
                                dateController.text,
                                numberOfDaysController.dropDownValue!.value.toString(),
                                descriptionController.text);
                            if(employeeLeaveModel.status == "1234567890"){
                              Get.snackbar("Unable to apply leave", "You have alredy applied for given date",
                                snackPosition: SnackPosition.TOP,
                              );
                            }
                            else{
                              Get.back();
                            }
                          },
                          child: const Card(
                              color: Colors.orangeAccent,
                              child: Center(
                                  child: Text(
                                    'SUBMIT',
                                    style: Ktextstylecardbutton,
                                  )))
                      )),
                )])
            ],
          ),
        ),
      ),
    );
  }
}
