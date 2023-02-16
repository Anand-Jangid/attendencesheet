import 'package:attendencesheet/Screens/site_map_screens/expense_report/add_expense_report/expense_report_summary.dart';
import 'package:attendencesheet/widgets/drop_down_textfield.dart';
import 'package:attendencesheet/widgets/text_field.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../widgets/date_text_field.dart';

class AddExpenseReport extends StatelessWidget {
  AddExpenseReport({Key? key}) : super(key: key);

  final projectController = SingleValueDropDownController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final descriptionController = TextEditingController();
  final currencyController = SingleValueDropDownController();
  final reportNameController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("EXPENSE REPORT"),
      ),
      body: Padding(
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
              controller: projectController,
              dropDownList: const [
                DropDownValueModel(name: 'Web Dev', value: 'Web Dev'),
                DropDownValueModel(name: "Cubastion Consulting Private Limited" , value: "Cubastion Consulting Private Limited"),
              ],
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
            TextFielD(hintText: "Enter Description", controller: descriptionController, textInputType: TextInputType.text,),
            const SizedBox(height: 10,),
            ///Currency
            const Text("CURRENCY", style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontWeight: FontWeight.w900),),
            DropDownTextFielD(
              controller: currencyController,
              dropDownList: [
                DropDownValueModel(name: 'INR', value: 'INR'),
                DropDownValueModel(name: 'USD', value: 'USD'),
                DropDownValueModel(name: 'EUR', value: 'EUR'),
                DropDownValueModel(name: 'OTH', value: 'OTH'),
                DropDownValueModel(name: 'JPY', value: 'JPY'),
              ],
              hintText: "Select Type",),
            const SizedBox(height: 10,),
            ///Report Name
            const Text("REPORT NAME", style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontWeight: FontWeight.w900),),
            TextFielD(hintText: "Enter Report Name", controller: reportNameController, textInputType: TextInputType.text,),

            const Spacer(),
            SizedBox(
              height: 50,
              child: InkWell(
                onTap: () {
                  Get.to( () => ExpenseReportSummary(
                    startDate: startDateController.text,
                    endDate: endDateController.text,
                    projectName: projectController.dropDownValue!.value,
                    description: descriptionController.text,
                    reportName: reportNameController.text,
                    currency: currencyController.dropDownValue!.value,
                  ));
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
    );
  }
}
