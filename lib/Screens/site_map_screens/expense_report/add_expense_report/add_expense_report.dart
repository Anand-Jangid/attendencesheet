import 'package:attendencesheet/Screens/site_map_screens/expense_report/add_expense_report/expense_report_summary.dart';
import 'package:attendencesheet/controllers/query_employee_controller.dart';
import 'package:attendencesheet/widgets/drop_down_textfield.dart';
import 'package:attendencesheet/widgets/text_field.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../widgets/date_text_field.dart';

class AddExpenseReport extends StatefulWidget {
  AddExpenseReport({Key? key}) : super(key: key);

  @override
  State<AddExpenseReport> createState() => _AddExpenseReportState();
}

class _AddExpenseReportState extends State<AddExpenseReport> {
  final QueryEmployeeController queryEmployeeController = Get.find();
  final projectController = SingleValueDropDownController();
  final GlobalKey<FormState> _formkey=GlobalKey<FormState>();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final descriptionController = TextEditingController();
  final currencyController = SingleValueDropDownController();
  final reportNameController = TextEditingController();
  List<DropDownValueModel> dropDownListProjects = [];
  List<DropDownValueModel> dropDownListCurrency = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for(int i=0; i<queryEmployeeController.projects.length; i++){
      dropDownListProjects.add(DropDownValueModel(
          name: queryEmployeeController.projects[i]["Project Name"],
          value: queryEmployeeController.projects[i]["Project Id"])
      );
    }

    for(int i=0; i<queryEmployeeController.currency.length; i++){
      dropDownListCurrency.add(DropDownValueModel(
          name: queryEmployeeController.currency[i],
          value: queryEmployeeController.currency[i])
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("EXPENSE REPORT", style: TextStyle(color: Colors.black),),
        leading: const BackButton(
            color: Colors.black
        ),
      ),
      body: Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///Project
              const Text("Project", style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w900),),
              DropDownTextFielD(
                valText: "Please Select the Project",
                controller: projectController,
                dropDownList: dropDownListProjects,
                hintText: "Select Project",),
              const SizedBox(height: 10,),
              ///start date
              const Text("START DATE", style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w900),),
              DateTextField(dateController: startDateController),
              const SizedBox(height: 10,),
              ///end date
              const Text("END DATE", style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w900),),
              DateTextField(dateController: endDateController),
              const SizedBox(height: 10,),
              ///Description
              const Text("DESCRIPTION", style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w900),),
              TextFielD(
                valText: "Please Enter the Description",
                hintText: "Enter Description",
                controller: descriptionController,
                textInputType: TextInputType.text,),
              const SizedBox(height: 10,),
              ///Currency
              const Text("CURRENCY", style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w900),),
              DropDownTextFielD(
                valText: "Please Select Currency Type",
                controller: currencyController,
                dropDownList: dropDownListCurrency,
                hintText: "Select Type",),
              const SizedBox(height: 10,),
              ///Report Name
              const Text("REPORT NAME", style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w900),),
              TextFielD(
                valText: "Please Enter Report Name",
                hintText: "Enter Report Name", controller: reportNameController, textInputType: TextInputType.text,),

              const Spacer(),
              SizedBox(
                height: 50,
                child: InkWell(
                  onTap: () {
                    final FormState? form = _formkey.currentState;
                    if (form!.validate()) {
                      Get.to(() {
                        return ExpenseReportSummary(
                          startDate: startDateController.text,
                          endDate: endDateController.text,
                          projectName: projectController.dropDownValue!.value,
                          description: descriptionController.text,
                          reportName: reportNameController.text,
                          currency: currencyController.dropDownValue!.value,
                        );
                      });
                    }
                    else {
                      print('Form is invalid');
                    }
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.yellow
                    ),
                    child: const Center(child: Text("SUBMIT", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
