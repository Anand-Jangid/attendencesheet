import 'package:attendencesheet/Screens/project_activity_update.dart';
import 'package:attendencesheet/controllers/project_activity_controller.dart';
import 'package:attendencesheet/controllers/query_employee_controller.dart';
import 'package:attendencesheet/models/project_activity_model.dart';
import 'package:intl/intl.dart';
import 'add_project_activity.dart';
import 'package:attendencesheet/apis/api_service.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../widgets/project_activity_widget.dart';
import '../models/usermodel.dart';
import 'package:get/get.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key,
    // required this.datess,
    // required this.week,
    // required this.inTime,
    // required this.outTime,
    // required this.date,
    // required this.user4,
    required this.index,
    required this.hour,
  });

  // final String datess;
  // final String week;
  // final String inTime;
  // final String outTime;
  // final String date;
  // final String hour;
  // final List user4;
  final int index;
  final String hour;


  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {

  // List user2 = [];

  // void addElementsToTimeSheet(List<String> object) {
  //   ///List object = [projectName, projectDescription, projectDuration,attendance date]
  //   Map newObject = {
  //     'Project Name': object[0],
  //     "Description": object[1],
  //     "Number of Hours": object[2],
  //     "Attendance Date": object[3],
  //   };
  //   setState(() {
  //     user2.add(newObject);
  //   });
  // }

  /// UPDATE function
  void updateElementsToTimeSheet(List<String> object, List projects) {
    ///List object = [projectName, projectDescription, projectDuration,attendance date]

    Map newObject = {
      'Project Name': object[0],
      "Description": object[1],
      "Number of Hours": object[2],
      "Attendance Date": object[3],
    };
    for (int i = 0; i < projects.length; i++) {
      if (projects[i]['Project Name'] == object[0]) {
        setState(() {
          projects.removeAt(i);
          projects.insert(i, newObject);
        });
      }
    }
  }

  final QueryEmployeeController queryEmployeeController = Get.find();
  final projectActivityController = Get.put(ProjectActivityController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  void fetchData(){
    List projectList = queryEmployeeController.attendanceList[widget.index]["CUBN Timesheet"];
    for(int i=0; i< projectList.length; i++){
      projectActivityController.projectActivityList.add(ProjectActivityModel(
        projectName: projectList[i]["Project Name"],
        projectDescription: projectList[i]["Description"],
        projectDuration: projectList[i]["Number of Hours"],
        date: projectList[i]["Attendance Date"],
        )
      );
    }
  }

  bool isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    // ApiService apiService = ApiService();
    // user2 = widget.user4;
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.grey,),
        title: const Text('ATTENDANCE', style: Ktextstyledaily),
      ),
      body: (isSubmitting) ? const Center(child: CircularProgressIndicator()) : Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Obx(() {
                  if(queryEmployeeController.isLoading == true){
                    return const Center(child: CircularProgressIndicator());
                  }
                  else{
                    return Column(
                      children: [
                        Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  ///Date and day
                                  Column(
                                    children: [
                                      Text(DateFormat('d MMM').format(DateFormat('MM/dd/y').parse(queryEmployeeController.attendanceList[widget.index]["Attendance Date"])),
                                        style: Ktextstylecarddate2,),
                                      Text(DateFormat('EEEE').format(DateFormat('MM/dd/y').parse(queryEmployeeController.attendanceList[widget.index]["Attendance Date"])),
                                          style: Ktextstylecarddate)
                                    ],
                                  ),

                                  /// Hours of activity
                                  Column(
                                    children: [
                                      Text("${widget.hour} HRS",
                                          style: Ktextstylecarddate3),
                                      const Text('OF ACTIVITY',
                                          style: Ktextstylecarddate)
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(height: 20.0),
                              Row(
                                children: [

                                ///In time
                                Expanded(
                                  child: SizedBox(
                                      height: 55.0,
                                      child: Card(
                                        child: Center(
                                            child: Text(
                                              'In Time ${queryEmployeeController.attendanceList[widget.index]["Start Time"]}',
                                              style: Ktextstylecarddate,
                                            )),
                                      )),
                                ),

                                ///Outtime
                                Expanded(
                                  child: SizedBox(
                                      height: 55.0,
                                      child: Card(
                                        child: Center(
                                            child: Text(
                                              'Out Time ${queryEmployeeController.attendanceList[widget.index]["End Time"]}',
                                              style: Ktextstylecarddate,
                                            )),
                                      )),
                                ),
                              ]
                              ),
                            ],
                          ),
                        Column(
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: projectActivityController.projectActivityList.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: (){
                                          Get.to(() => ProjectActivityUpdate(
                                              date: queryEmployeeController.attendanceList[widget.index]["CUBN Timesheet"][index]["Attendance Date"],
                                              projectDescription: queryEmployeeController.attendanceList[widget.index]["CUBN Timesheet"][index]["Description"],
                                              projectDuration: queryEmployeeController.attendanceList[widget.index]["CUBN Timesheet"][index]["Number of Hours"],
                                              projectName: queryEmployeeController.attendanceList[widget.index]["CUBN Timesheet"][index]["Project Name"],
                                          )
                                          );
                                        },
                                  child: ProjectActivityWidget(
                                    projectName: projectActivityController.projectActivityList[index].projectName,
                                    projectDescription: projectActivityController.projectActivityList[index].projectDescription,
                                    projectDuration: projectActivityController.projectActivityList[index].projectDuration,
                                  ),
                                );
                              }
                            ),
                          ]
                        )
                      ]
                    );
                  }
                }),
              ),

              /// +project activity -------- submit
              SizedBox(
                height: 60,
                child: Row(children: [
                  ///project activity
                  Expanded(
                      flex: 4,
                      child: SizedBox(
                          height: 60,
                          child: GestureDetector(
                            onTap: () => Get.to(() => ProjectActivity(index: widget.index)),
                            child: const Card(
                                color: Colors.grey,
                                child: Center(
                                    child: Text(
                                      '+Project Activity',
                                      style: Ktextstylecardbutton,
                                    ))),
                          ))),
                  ///Submit
                  Expanded(
                      flex: 6,
                      child: SizedBox(
                          height: 60,
                          child: GestureDetector(
                            onTap: () async {
                              setState(() {
                                isSubmitting = true;
                              });
                              for (int i = 0; i < projectActivityController.projectActivityList.length; i++) {
                                await ApiService.upsertAttendance(
                                  projectActivityController.projectActivityList[i].projectDescription,
                                  projectActivityController.projectActivityList[i].projectDuration,
                                  projectActivityController.projectActivityList[i].projectDuration,
                                  projectActivityController.projectActivityList[i].date
                                );
                              }
                              setState(() {
                                isSubmitting = false;
                              });
                              Get.back();
                            },
                            child: const Card(
                                color: Colors.orangeAccent,
                                child: Center(
                                    child: Text('Submit',
                                        style: Ktextstylecardbutton))),
                          ))),
                ]),
              )
            ],
          )
      ),
    );
  }
}

