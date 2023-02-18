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
  List<Map> user = [];

  String firstName = "";
  String lastName = "";

  final queryEmployeeController = Get.put(QueryEmployeeController());

  final ReportingManagerController reportingManagerController = Get.put(
      ReportingManagerController());

  Future<List<Map>> getData() async {
    user.clear();
    http.Response response = await http.post(
        Uri.parse(
            'https://devxnet.cubastion.net/api/v1/employee/queryEmployee'),
        headers: {'token': tokens});
    var data = jsonDecode(response.body.toString());
    var datas = data['SiebelMessage']['Employee']['CUBN Attendance'];
    if (response.statusCode == 200) {
      firstName =
      data['SiebelMessage']['Employee']["Reporting Manager First Name"];
      lastName =
      data['SiebelMessage']['Employee']["Reporting Manager Last Name"];
      for (Map i in datas) {
        user.add(i);
      }
      return user;
    } else {
      return user;
    }
  }

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
                // FutureBuilder(
                //     future: getData(),
                //     builder: (context, snapshot) {
                //       reportingManagerController.reportingManagerFirstName.value = firstName;
                //       reportingManagerController.reporintManagerLastName.value = lastName;
                //       if (snapshot.hasData) {
                //         if (snapshot.connectionState == ConnectionState.done) {
                //           return SizedBox(
                //             height: MediaQuery.of(context).size.height / 5,
                //             width: double.infinity,
                //             child: ListView.builder(
                //                 scrollDirection: Axis.horizontal,
                //                 itemCount: user.length,
                //                 reverse: true,
                //                 itemBuilder: (context, index) {
                //                   double hour = 0;
                //                   List<dynamic> Timesheet = user[index]['CUBN Timesheet'];
                //                   if (Timesheet.isEmpty) {
                //                     hour = 0;
                //                   }
                //                   else {
                //                     for (int i = 0; i < Timesheet.length; i++) {
                //                       hour = hour + double.parse(Timesheet[i]["Number of Hours"]);
                //                     }
                //                   }
                //                   return SizedBox(
                //                     height: 190,
                //                     width: 190,
                //                     child: GestureDetector(
                //                       onTap: () {
                //                         Navigator.push(
                //                             context,
                //                             MaterialPageRoute(builder: (
                //                                     BuildContext context) =>
                //                                     CardScreen(
                //                                       datess: DateFormat(
                //                                           'd MMM').format(
                //                                           DateFormat('MM/dd/y')
                //                                               .parse(user[index]
                //                                           ['Attendance Date'])),
                //                                       week: DateFormat('EEEE')
                //                                           .format(
                //                                           DateFormat('MM/dd/y')
                //                                               .parse(user[index]
                //                                           ['Attendance Date'])),
                //                                       inTime: user[index]
                //                                       ['Start Time']
                //                                           .toString(),
                //                                       outTime: user[index]['End Time']
                //                                           .toString(),
                //                                       indx: index,
                //                                       date: user[index]['Attendance Date'],
                //                                       hour: hour.toString(),
                //                                       user4: user[index]["CUBN Timesheet"],
                //                                     ))).then((value) {
                //                           getData();
                //                           setState(() {
                //                             //refresh hoja
                //                           });
                //                         });
                //                       },
                //                       // child: Card(
                //                       //   elevation: 2,
                //                       //   shape: RoundedRectangleBorder(
                //                       //       borderRadius:
                //                       //       BorderRadius.circular(10.0)),
                //                       //   child: Padding(
                //                       //     padding: const EdgeInsets.all(20.0),
                //                       //     child: Column(
                //                       //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                       //       crossAxisAlignment: CrossAxisAlignment.start,
                //                       //       children: [
                //                       //         Column(
                //                       //           children: [
                //                       //             Row(children: [
                //                       //               Text(
                //                       //                   DateFormat('d MMM').format(DateFormat('MM/dd/y').parse(user[index]['Attendance Date'])),
                //                       //                   style: Ktextstylecarddate)
                //                       //             ]),
                //                       //             Row(children: [
                //                       //               Text(DateFormat('EEEE').format(
                //                       //                       DateFormat('MM/dd/y').parse(user[index]['Attendance Date'])),
                //                       //                   style: Ktextstylecardweek)
                //                       //             ])
                //                       //           ],
                //                       //         ),
                //                       //         Column(
                //                       //           children: [
                //                       //             Row(
                //                       //               mainAxisAlignment:
                //                       //               MainAxisAlignment
                //                       //                   .spaceBetween,
                //                       //               children: const [
                //                       //                 Text('IN TIME',
                //                       //                     style:
                //                       //                     KtextstylecardIN),
                //                       //                 Icon(Icons.arrow_right_alt,
                //                       //                    color: Colors.green),
                //                       //                 Text(
                //                       //                   'OUT TIME',
                //                       //                   style: KtextstylecardIN,
                //                       //                 )
                //                       //               ],
                //                       //             ),
                //                       //             Row(
                //                       //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                       //               children: [
                //                       //                 Text(
                //                       //                     user[index]
                //                       //                     ['Start Time']
                //                       //                         .toString(),
                //                       //                     style:
                //                       //                     KtextstylecardIN),
                //                       //                 Text(
                //                       //                   user[index]['End Time']
                //                       //                       .toString(),
                //                       //                   style: KtextstylecardIN,
                //                       //                 )
                //                       //               ],
                //                       //             ),
                //                       //           ],
                //                       //         ),
                //                       //         Row(
                //                       //           mainAxisAlignment:MainAxisAlignment.spaceBetween,
                //                       //           children: [
                //                       //             SizedBox(
                //                       //               height:25,
                //                       //               child: ElevatedButton(
                //                       //                   onPressed:(){}, child:Text('${hour.toString()} Hrs ',style:const TextStyle(fontSize:10 ),)
                //                       //               ),
                //                       //             ),
                //                       //             const Text('of Activity',style:KtextstylecardIN),],
                //                       //         )
                //                       //
                //                       //       ],
                //                       //     ),
                //                       //   ),
                //                       // ),
                //                       ///
                //                       child: AttendanceCard(
                //                         attendanceDate: user[index]['Attendance Date'],
                //                         startTime: user[index]['Start Time'].toString(),
                //                         endTime: user[index]['End Time'].toString(),
                //                         hours: hour.toString(),
                //                       ),
                //                     ),
                //                   );
                //                 }),
                //           );
                //         }
                //         return Container(height: 180,
                //             child: const Center(
                //                 child: CircularProgressIndicator()));
                //       }
                //       else {
                //         return Container(
                //             height: 180,
                //             child: const Center(
                //                 child: CircularProgressIndicator()));
                //       }
                //     }),
                Obx(() {
                  return SizedBox(
                      height: MediaQuery.of(context).size.height / 5,
                      width: double.infinity,
                      child: (queryEmployeeController.isLoading == true) ?
                      const Center(child: CircularProgressIndicator()) :
                      // Container(height: 20, color: Colors.red,)
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
                                // onTap: () {
                                //   Navigator.push(
                                //       context,
                                //       MaterialPageRoute(
                                //           builder: (
                                //               BuildContext context) =>
                                //               CardScreen(
                                //                 datess: DateFormat(
                                //                     'd MMM').format(
                                //                     DateFormat('MM/dd/y')
                                //                         .parse(user[index]
                                //                     ['Attendance Date'])),
                                //                 week: DateFormat('EEEE')
                                //                     .format(
                                //                     DateFormat('MM/dd/y')
                                //                         .parse(user[index]
                                //                     ['Attendance Date'])),
                                //                 inTime: user[index]
                                //                 ['Start Time']
                                //                     .toString(),
                                //                 outTime: user[index]['End Time']
                                //                     .toString(),
                                //                 indx: index,
                                //                 date: user[index]['Attendance Date'],
                                //                 hour: hour.toString(),
                                //                 user4: user[index]["CUBN Timesheet"],
                                //               ))).then((value) {
                                //     getData();
                                //     setState(() {
                                //       //refresh hoja
                                //     });
                                //   });
                                // },
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


