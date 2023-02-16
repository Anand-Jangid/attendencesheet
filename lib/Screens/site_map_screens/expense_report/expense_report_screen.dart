import 'package:attendencesheet/Screens/site_map_screens/expense_report/add_expense_report/add_expense_report.dart';
import 'package:attendencesheet/controllers/expense_report_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/expense_report_widget.dart';

class ExpenseReportScreen extends StatelessWidget {
  ExpenseReportScreen({Key? key}) : super(key: key);

  final expenseReportController = Get.put(ExpenseReportController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("EXPENSE REPORTS"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [(expenseReportController.isLoading.value) ? const Center(child: CircularProgressIndicator()) :
            Expanded(
              child: ListView.builder(
                itemCount: expenseReportController.expenseReportList.length,
                itemBuilder: (context, index){
                  return ExpenseReportWidget(
                    expenseAmount: expenseReportController.expenseReportList[index]["Total Amount"],
                    expenseReportDescription: expenseReportController.expenseReportList[index]["Expense Report Description"],
                    projectName: expenseReportController.expenseReportList[index]["Project Name"],
                    status: expenseReportController.expenseReportList[index]["Status"],
                  );
                }),
            ),
            // const Spacer(),
            SizedBox(
              height: 50,
              child: InkWell(
                onTap: () => Get.to(() => AddExpenseReport()),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.yellow
                  ),
                  child: const Center(child: Text("+ ADD EXPENSE REPORT", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
