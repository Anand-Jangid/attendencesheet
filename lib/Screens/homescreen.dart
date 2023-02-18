import 'package:attendencesheet/Screens/site_map_screens/expense_report/expense_report_screen.dart';
import 'package:attendencesheet/Screens/site_map_screens/leave_detail_screen/leave_detail_screen.dart';
import 'package:attendencesheet/Screens/site_map_screens/pending_approval/pending_approval_page.dart';
import 'package:attendencesheet/Screens/site_map_screens/project_expense/project_expense_screen/project_expense_screen.dart';
import 'package:attendencesheet/controllers/query_employee_controller.dart';
import 'package:attendencesheet/controllers/reporting_manager_controller.dart';
import 'package:attendencesheet/models/site_map_card_model.dart';
import 'package:attendencesheet/widgets/attendance_card.dart';
import 'package:attendencesheet/widgets/site_map_card.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:attendencesheet/Screens/cardscreen.dart';
import 'package:attendencesheet/Screens/site_map_screens/salary_screen/salaryscreen.dart';
import 'package:attendencesheet/Screens/viewallscreen.dart';
import 'package:flutter/material.dart';
import 'package:attendencesheet/constants.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  final queryEmployeeController = Get.put(QueryEmployeeController());
  final ReportingManagerController reportingManagerController = Get.put(ReportingManagerController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'HOME',
              style: KtextStylesignhome,
            ),
            TextButton(onPressed: () {}, child: const Text('SIGN OUT'))
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          ///daily attendance and view all
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('DAILY ATTENDANCE', style: Ktextstyledaily),
                    TextButton(
                        onPressed: () {
                          Get.to(ViewAllScreen());
                        },
                        child: const Text(
                          'View All',
                          style: Ktextstyleview,
                        ))
                  ],
                ),
              ],
            ),
          ),

          ///attendance cards
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Column(
              children: [
                Obx(() {
                  return SizedBox(
                      height: MediaQuery.of(context).size.height / 5,
                      width: double.infinity,
                      child: (queryEmployeeController.isLoading == true) ?
                      const Center(child: CircularProgressIndicator()) :
                      ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: queryEmployeeController.attendanceList.length,
                          reverse: true,
                          itemBuilder: (context, index) {
                            double hour = 0;
                            List Timesheet = queryEmployeeController.attendanceList[index]["CUBN Timesheet"];
                            if (Timesheet.isEmpty) {
                              hour = 0;
                            }
                            else {
                              for (int i = 0; i < Timesheet.length; i++) {
                                hour = hour + double.parse(Timesheet[i]["Number of Hours"]);
                              }
                            }
                            return SizedBox(
                              height: 190,
                              width: 190,
                              child: GestureDetector(
                                onTap: () => Get.to(CardScreen(index: index, hour: hour.toString())),
                                child: AttendanceCard(
                                  attendanceDate: queryEmployeeController.attendanceList[index]["Attendance Date"],
                                  startTime: queryEmployeeController.attendanceList[index]["Start Time"],
                                  endTime: queryEmployeeController.attendanceList[index]["End Time"],
                                  hours: hour.toString(),
                                ),
                              ),
                            );
                          }),
                    );
                })
              ],
            ),
          ),

          ///sitemap
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
                children: const [ Text('SITE MAP', style: Ktextstyledaily)]),
          ),

          ///sitemap cards
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [

                ///Salary Screen
                SiteMapCard(siteMapCardModel: SiteMapCardModel(
                    leadingIcon: const Icon(Icons.currency_rupee),
                    title: 'Salary and Benefits',
                    page: SalaryScreen())),

                ///Project Expense
                SiteMapCard(siteMapCardModel: SiteMapCardModel(
                    leadingIcon: const Icon(Icons.currency_rupee),
                    title: 'Project Expense',
                    page: ProjectExpenseScreen())),

                ///leaves
                SiteMapCard(siteMapCardModel: SiteMapCardModel(
                    leadingIcon: const Icon(Icons.file_copy),
                    title: 'Leaves',
                    page: LeaveDetailScreen())),

                ///Expense Report
                SiteMapCard(siteMapCardModel: SiteMapCardModel(
                    leadingIcon: const Icon(Icons.currency_rupee),
                    title: 'Expense Report',
                    page: ExpenseReportScreen())),

                ///Pending approval page
                SiteMapCard(siteMapCardModel: SiteMapCardModel(
                    leadingIcon: const Icon(Icons.person),
                    title: 'Pending Approval',
                    page: PendingApprovalPage())),

              ],
            ),
          )
        ],
      ),
    );
  }
}


