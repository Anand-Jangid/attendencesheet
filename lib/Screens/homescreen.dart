import 'package:attendencesheet/Screens/site_map_screens/expense_report.dart';
import 'package:attendencesheet/Screens/site_map_screens/leave_detail_screen/leave_detail_screen.dart';
import 'package:attendencesheet/Screens/site_map_screens/pending_approval_page.dart';
import 'package:attendencesheet/Screens/site_map_screens/project_expense.dart';
import 'package:attendencesheet/controllers/reporting_manager_controller.dart';
import 'package:attendencesheet/models/site_map_card_model.dart';
import 'package:attendencesheet/widgets/site_map_card.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:attendencesheet/Screens/cardscreen.dart';
import 'package:attendencesheet/Screens/site_map_screens/salaryscreen.dart';
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
  List<Map> User = [];

  String firstName = "";
  String lastName = "";

  final ReportingManagerController reportingManagerController = Get.put(ReportingManagerController());

  Future<List<Map>> getData() async {
    User.clear();
    http.Response response = await http.post(
        Uri.parse(
            'https://devxnet.cubastion.net/api/v1/employee/queryEmployee'),
        headers: {'token': tokens});
    var data = jsonDecode(response.body.toString());
    var datas = data['SiebelMessage']['Employee']['CUBN Attendance'];
    if (response.statusCode == 200) {
      firstName = data['SiebelMessage']['Employee']["Reporting Manager First Name"];
      lastName = data['SiebelMessage']['Employee']["Reporting Manager Last Name"];
      for (Map i in datas) {
        User.add(i);
      }
      return User;
    } else {
      return User;
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
            padding: const EdgeInsets.symmetric(vertical:15,horizontal:10  ),
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
            padding:const EdgeInsets.only(bottom:15),
            child: Column(
              children: [
                FutureBuilder(
                    future: getData(),
                    builder: (context, snapshot) {
                      print(firstName);
                      reportingManagerController.reportingManagerFirstName.value = firstName;
                      reportingManagerController.reporintManagerLastName.value = lastName;
                      if (snapshot.hasData) {
                        if(snapshot.connectionState == ConnectionState.done){
                          return SizedBox(
                            height: MediaQuery.of(context).size.height/5,
                            width:double.infinity,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: User.length,
                                reverse: true,
                                itemBuilder: (context, index) {
                                  double hour = 0;
                                  List<dynamic> Timesheet = User[index]['CUBN Timesheet'];
                                  if (Timesheet.length == 0) {
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
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (BuildContext context) => CardScreen(
                                                  datess: DateFormat('d MMM').format(
                                                      DateFormat('MM/dd/y').parse(User[index]
                                                      ['Attendance Date'])),
                                                  week: DateFormat('EEEE').format(
                                                      DateFormat('MM/dd/y').parse(User[index]
                                                      ['Attendance Date'])),
                                                  inTime: User[index]
                                                  ['Start Time']
                                                      .toString(),
                                                  OutTime: User[index]['End Time'].toString(),
                                                  indx: index,
                                                  date: User[index]['Attendance Date'],
                                                  hour:hour.toString(),
                                                  User4:User[index]["CUBN Timesheet"],
                                                ))).then((value){
                                          getData();
                                          setState(() {
                                            //refresh hoja
                                          });
                                        });
                                      },
                                      child: Card(
                                        elevation: 2,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(10.0)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                children: [
                                                  Row(children: [
                                                    Text(
                                                        DateFormat('d MMM')
                                                            .format(DateFormat(
                                                            'MM/dd/y')
                                                            .parse(User[index]
                                                        [
                                                        'Attendance Date'])),
                                                        style: Ktextstylecarddate)
                                                  ]),
                                                  Row(children: [
                                                    Text(
                                                        DateFormat('EEEE').format(
                                                            DateFormat('MM/dd/y')
                                                                .parse(User[index]
                                                            [
                                                            'Attendance Date'])),
                                                        style: Ktextstylecardweek)
                                                  ])
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      const Text('IN TIME',
                                                          style:
                                                          KtextstylecardIN),
                                                      const Icon(Icons.arrow_right_alt,
                                                          color: Colors.green),
                                                      const Text(
                                                        'OUT TIME',
                                                        style: KtextstylecardIN,
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Text(
                                                          User[index]
                                                          ['Start Time']
                                                              .toString(),
                                                          style:
                                                          KtextstylecardIN),
                                                      Text(
                                                        User[index]['End Time']
                                                            .toString(),
                                                        style: KtextstylecardIN,
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    height:25,
                                                    child: ElevatedButton(
                                                        onPressed:(){}, child:Text('${hour.toString()} Hrs ',style:const TextStyle(fontSize:10 ),)
                                                    ),
                                                  ),
                                                  const Text('of Activity',style:KtextstylecardIN),],
                                              )

                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          );
                        }
                        return Container(height:180 ,
                            child: const Center(child: CircularProgressIndicator()));
                      }
                      else {
                        return Container(
                          height: 180,
                            child: const Center(child: CircularProgressIndicator()));
                      }
                    })
              ],
            ),
          ),
          ///sitemap
          Padding(
            padding:  const EdgeInsets.symmetric(horizontal:10,vertical: 10 ),
            child: Row(children: [const Text('SITE MAP', style: Ktextstyledaily)]),
          ),
          ///sitemap cards
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Column(
               children: [
                 ///Salary Screen
                 SiteMapCard(siteMapCardModel: SiteMapCardModel(leadingIcon: const Icon(Icons.currency_rupee), title: 'Salary and Benefits', page: SalaryScreen())),
                 ///Project Expense
                 SiteMapCard(siteMapCardModel: SiteMapCardModel(leadingIcon: const Icon(Icons.currency_rupee), title: 'Project Expense', page: const ProjectExpense())),
                 ///leaves
                 SiteMapCard(siteMapCardModel: SiteMapCardModel(leadingIcon: const Icon(Icons.file_copy), title: 'Leaves', page: LeaveDetailScreen())),
                 ///Expense Report
                 SiteMapCard(siteMapCardModel: SiteMapCardModel(leadingIcon: const Icon(Icons.currency_rupee), title: 'Expense Report', page: const ExpenseReport())),
                 ///Pending approval page
                 SiteMapCard(siteMapCardModel: SiteMapCardModel(leadingIcon: const Icon(Icons.person), title: 'Pending Approval', page: PendingApprovalPage())),

               ],
             ),
           )
        ],
      ),
    );
  }
}


