import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/employee_expense_controller.dart';
import '../../../widgets/project_expense_widget.dart';

class ProjectExpense extends StatelessWidget {
  ProjectExpense({Key? key}) : super(key: key);
  final employeeExpenseController = Get.put(EmployeeExpenseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PEOJECT EXPENSE"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Obx(() {
              if(employeeExpenseController.isLoading.value){
                return const Center(child: CircularProgressIndicator());
              }
              else{
                return Expanded(
                  child: ListView.builder(
                      itemCount: employeeExpenseController.expensesList.length,
                      itemBuilder: (context, index){
                        return PeojectExpenseWidget(
                          expenseAmount: employeeExpenseController.expensesList[index]["Expense Amount"],
                          expenseDate: employeeExpenseController.expensesList[index]["Expense Date"],
                          expenseDescription: employeeExpenseController.expensesList[index]["Expense Description"],
                          expenseType: employeeExpenseController.expensesList[index]["Expense Type"],
                          projectName: employeeExpenseController.expensesList[index]["Project Name"],
                        );
                      }),
                );
              }
            }),
            SizedBox(
              height: 50,
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.brown
                ),
                child: Center(child: Text("+ ADD NEW EXPENSE", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
