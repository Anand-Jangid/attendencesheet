import 'package:attendencesheet/apis/api_service.dart';
import 'package:attendencesheet/controllers/employee_expense_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../widgets/project_expense_widget.dart';

class ExpenseReportSummary extends StatefulWidget {
  final String startDate;
  final String endDate;
  final String projectName;
  final String description;
  final String reportName;
  final String currency;

  ExpenseReportSummary(
      {Key? key,
      required this.currency,
      required this.startDate,
      required this.endDate,
      required this.projectName,
      required this.description,
      required this.reportName})
      : super(key: key);

  @override
  State<ExpenseReportSummary> createState() => _ExpenseReportSummaryState();
}

class _ExpenseReportSummaryState extends State<ExpenseReportSummary> {

  bool isUploading = false;
  final employeeExpenseController = Get.put(EmployeeExpenseController());
  List filteredExpenses = [];
  List<Map> projectId = [];

  void addProjectId(List expenses){
    for(int i=0; i<expenses.length; i++){
      projectId.add({
        "Id" : expenses[i]["Id"]
      });
    }
    //
  }

  void filterList(List expenses, String startDate, String endDate, String projectName) {

    for (int i = 0; i < expenses.length; i++) {
      if (expenses[i]["Project Name"] == projectName) {

        var newDate = DateTime.parse(DateFormat('yyyy-MM-dd').format(DateFormat('MM/dd/y').parse(expenses[i]["Expense Date"])));

        if ( newDate.isAfter(DateTime.parse(startDate)) && newDate.isBefore(DateTime.parse(endDate)) ) {
          filteredExpenses.add(expenses[i]);
        }

      }
    }
  }


  @override
  Widget build(BuildContext context) {
    String startingDate = DateFormat("dd MMM yyyy").format(DateTime.parse(widget.startDate));
    String endingDate = DateFormat("dd MMM yyyy").format(DateTime.parse(widget.endDate));
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "EXPENSE REPORTS ${widget.projectName}",
          softWrap: true,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
              fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w900),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(20),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "$startingDate- $endingDate",
                  style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.w900),
                ),
                Text(
                  "Total 123456789",
                  style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ),
        ),
        leading: const BackButton(
            color: Colors.black
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: (isUploading) ? const Center(child: CircularProgressIndicator()):Column(
          children: [
            Expanded(
              child: Obx(() {
                if (employeeExpenseController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  filterList(employeeExpenseController.expensesList.value, widget.startDate, widget.endDate, widget.projectName);
                  addProjectId(filteredExpenses);
                  return ListView.builder(
                    itemCount: filteredExpenses.length,
                    itemBuilder: (context, index) {
                        return PeojectExpenseWidget(
                          expenseAmount: filteredExpenses[index]
                              ["Expense Amount"],
                          expenseDate: filteredExpenses[index]
                              ["Expense Date"],
                          expenseDescription: filteredExpenses[index]
                              ["Expense Description"],
                          expenseType: filteredExpenses[index]
                              ["Expense Type"],
                          projectName: filteredExpenses[index]
                              ["Project Name"],
                        );
                      });
                }
              }),
            ),
            SizedBox(
              height: 50,
              child: InkWell(
                onTap: () async{
                  setState(() {
                    isUploading = true;
                  });
                  await ApiService.uploadExpenseReport(
                      endDate: widget.endDate,
                      startDate: widget.startDate,
                      projectName: widget.projectName,
                      expenseList: projectId,
                      currency: widget.currency,
                      reportName: widget.reportName,
                      reportDescription: widget.description);
                  setState(() {
                    isUploading = false;
                  });
                  Get.back();
                  Get.back();
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.yellow),
                  child: const Center(
                      child: Text(
                    "SUBMIT",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
