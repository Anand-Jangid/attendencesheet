import 'package:attendencesheet/Screens/site_map_screens/project_expense/project_expense_screen/add_expense_screen.dart';
import 'package:attendencesheet/Screens/site_map_screens/project_expense/project_expense_screen/edit_expense_screen.dart';
import 'package:attendencesheet/models/add_expense_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/employee_expense_controller.dart';
import '../../../../widgets/project_expense_widget.dart';

class ProjectExpenseScreen extends StatefulWidget {
  ProjectExpenseScreen({Key? key}) : super(key: key);

  @override
  State<ProjectExpenseScreen> createState() => _ProjectExpenseScreenState();
}

class _ProjectExpenseScreenState extends State<ProjectExpenseScreen> {
  final employeeExpenseController = Get.put(EmployeeExpenseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PEOJECT EXPENSE", style: TextStyle(color: Colors.black),),
        leading: const BackButton(
            color: Colors.black
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                if(employeeExpenseController.isLoading.value){
                  return const Center(child: CircularProgressIndicator());
                }
                else{
                  return ListView.builder(
                      itemCount: employeeExpenseController.expensesList.length,
                      itemBuilder: (context, index)=> InkWell(
                          onTap: () {
                            Get.to(() => EditExpenseScreen(addExpenseModel: AddExpenseModel(
                              date: employeeExpenseController.expensesList[index]["Expense Date"],
                              projectName: employeeExpenseController.expensesList[index]["Project Name"],
                              expenseType: employeeExpenseController.expensesList[index]["Expense Type"],
                              expenseDescription: employeeExpenseController.expensesList[index]["Expense Description"],
                              projectAmount: employeeExpenseController.expensesList[index]["Expense Amount"],
                              projectInvoice: employeeExpenseController.expensesList[index]["Voucher #"],
                              attachment: employeeExpenseController.expensesList[index]["attachment"],
                              Id: employeeExpenseController.expensesList[index]["Id"],
                            ),))!.then((value) {
                              employeeExpenseController.fetchExpenseData();
                              setState(() {
                              });
                            });
                          },
                          child: IgnorePointer(
                            child: PeojectExpenseWidget(
                              expenseAmount: employeeExpenseController.expensesList[index]["Expense Amount"],
                              expenseDate: employeeExpenseController.expensesList[index]["Expense Date"],
                              expenseDescription: employeeExpenseController.expensesList[index]["Expense Description"],
                              expenseType: employeeExpenseController.expensesList[index]["Expense Type"],
                              projectName: employeeExpenseController.expensesList[index]["Project Name"],
                            ),
                          ),
                        ));
                }
              }),
            ),
            SizedBox(
              height: 50,
              child: InkWell(
                onTap: () => Get.to(() => AddExpenseScreen())!.then((value) {
                  employeeExpenseController.fetchExpenseData();
                  setState(() {
                  });
                }),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.yellow
                  ),
                  child: const Center(child: Text("+ ADD NEW EXPENSE", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
