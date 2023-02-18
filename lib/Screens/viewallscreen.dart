import 'package:attendencesheet/Screens/cardscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

import '../controllers/query_employee_controller.dart';
import '../widgets/view_all_attendance_card.dart';

class ViewAllScreen extends StatefulWidget {
  const ViewAllScreen({super.key});

  @override
  State<ViewAllScreen> createState() => _ViewAllScreenState();
}

class _ViewAllScreenState extends State<ViewAllScreen> {

  final QueryEmployeeController queryEmployeeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.grey),
        title: const Text('ATTENDANCE', style: Ktextstylecarddate4),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Obx(() {
              if(queryEmployeeController.isLoading == true){
                return const Center(child: CircularProgressIndicator());
              }
              else{
                return Expanded(
                  child: ListView.builder(
                      itemCount: queryEmployeeController.attendanceList.length,
                      itemBuilder: (context, index) {
                        double hours = 0;
                        List timesheet = queryEmployeeController.attendanceList[index]['CUBN Timesheet'];
                        if (timesheet.isEmpty) {
                          hours = 0;
                        }
                        else {
                          for (int i = 0; i < timesheet.length; i++) {
                            hours = hours + double.parse(timesheet[i]['Number of Hours']);
                          }
                        }
                        return Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: SizedBox(
                            height: 90.0,
                            child: GestureDetector(
                              // onTap: () {
                              //   Navigator.push(context,
                              //       MaterialPageRoute(builder: (
                              //           BuildContext context) =>
                              //           CardScreen(
                              //             datess: DateFormat(
                              //                 'd MMM').format(
                              //                 DateFormat('MM/dd/y')
                              //                     .parse(
                              //                     Users[index]['Attendance Date'])),
                              //             week: DateFormat('EEEE')
                              //                 .format(
                              //                 DateFormat('MM/dd/y')
                              //                     .parse(
                              //                     Users[index]['Attendance Date'])),
                              //             inTime: Users[index]['Start Time']
                              //                 .toString(),
                              //             outTime: Users[index]['End Time']
                              //                 .toString(),
                              //             indx: index,
                              //             date: Users[index]['Attendance Date'],
                              //             hour: hour1.toString(),
                              //             user4: Users[index]['CUBN Timesheet'],
                              //
                              //           ))).then((value) {
                              //     getData2();
                              //     setState(() {
                              //       //refresh hoja
                              //     });
                              //   }
                              //   );
                              // },
                              child: ViewAllAttendanceCard(
                                  attendanceDate: queryEmployeeController.attendanceList[index]["Attendance Date"],
                                  endTime: queryEmployeeController.attendanceList[index]["End Time"],
                                  startTime: queryEmployeeController.attendanceList[index]["Start Time"],
                                  hours: hours.toString()),
                            ),
                          ),
                        );
                      }

                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
