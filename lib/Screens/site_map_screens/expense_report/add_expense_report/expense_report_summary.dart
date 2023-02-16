import 'package:attendencesheet/controllers/employee_expense_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../widgets/project_expense_widget.dart';

class ExpenseReportSummary extends StatelessWidget {
  final String startDate;
  final String endDate;
  final String projectName;
  final String description;
  final String reportName;

  ExpenseReportSummary(
      {Key? key,
      required this.startDate,
      required this.endDate,
      required this.projectName,
      required this.description,
      required this.reportName})
      : super(key: key);

  final employeeExpenseController = Get.put(EmployeeExpenseController());

  List filteredExpenses = [];

  void filterList(List expenses, String startDate, String endDate, String projectName) {
    for (int i = 0; i < expenses.length; i++) {
      if (expenses[i]["Project Name"] == projectName) {
        var newDate = DateTime.parse(DateFormat('yyyy-MM-dd').format(DateFormat('MM/dd/y').parse(expenses[i]["Expense Date"])));
        if ( newDate.isAfter(DateTime.parse(startDate)) && newDate.isBefore(DateTime.parse(endDate)) ) {
          filteredExpenses.add(expenses[i]);
        }
        // break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String startingDate = DateFormat("dd MMM yyyy").format(DateTime.parse(startDate));
    String endingDate = DateFormat("dd MMM yyyy").format(DateTime.parse(endDate));
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "EXPENSE REPORTS ${projectName}",
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                if (employeeExpenseController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  filterList(employeeExpenseController.expensesList, startDate, endDate, projectName);
                  return ListView.builder(

                    itemCount: filteredExpenses.length,
                    itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {},
                          child: PeojectExpenseWidget(
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
                          ),
                        );
                      });
                }
              }),
            ),
            SizedBox(
              height: 50,
              child: InkWell(
                onTap: () {},
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
