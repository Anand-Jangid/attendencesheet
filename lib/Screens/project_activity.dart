import 'package:attendencesheet/controllers/project_activity_controller.dart';
import 'package:attendencesheet/controllers/query_employee_controller.dart';
import 'package:attendencesheet/models/project_activity_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import '../constants.dart';


class ProjectActivity extends StatefulWidget {
  final int index;

  const ProjectActivity({
    super.key,
    required this.index,
  });

  @override
  State<ProjectActivity> createState() => _ProjectActivityState();
}

class _ProjectActivityState extends State<ProjectActivity> {


  final QueryEmployeeController queryEmployeeController = Get.find();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  SingleValueDropDownController projectNameController = SingleValueDropDownController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  final ProjectActivityController projectActivityController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black,
        ),
        title: Text(DateFormat('d MMM EEE').format(DateFormat('MM/dd/y').parse(
          queryEmployeeController.attendanceList[widget.index]["Attendance Date"]
        )),
            style: Ktextstyledaily),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key:_formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 9),
                  child: Text(
                    'PROJECT',
                    style: KtextstyleActivity,
                  )),
              const SizedBox(height: 10),
              ///Projects ---- textfield
              DropDownTextField(

                textFieldDecoration:InputDecoration(
                  hintText:'Select Project Name' ,
                  hintStyle: KtextstyleActivity,
                  enabledBorder:OutlineInputBorder(
                    borderSide:const BorderSide(color: Colors.grey),
                    borderRadius:BorderRadius.circular(10.0)
                  ),
                  focusedBorder:OutlineInputBorder(
                      borderSide:const BorderSide(color: Colors.grey),
                      borderRadius:BorderRadius.circular(10.0)
                  )
                ),
                controller: projectNameController,
                clearOption: true,
                dropdownRadius: 10.0,
                textStyle:KtextstyleActivity1,
                listTextStyle:KtextstyleActivity1,
                dropDownList: const [
                  DropDownValueModel(
                      name: 'Cubastion Consulting Private Limited',
                      value: 'Cubastion Consulting Private Limited'),
                  DropDownValueModel(name: 'Web Dev', value: 'Web Dev')
                ],
                onChanged: (val) {},
              ),
              const SizedBox(height: 20),
              ///ActivityDescription ---- text
              const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 9),
                  child: Text(
                    'ACTIVITY DESCRIPTION',
                    style: KtextstyleActivity,
                  )),
              const SizedBox(height: 10),
              /// ActivityDescription -------textfield
              TextFormField(
                style:KtextstyleActivity1,
                controller: descriptionController,
                decoration: InputDecoration(

                  hintText: 'Enter Project Description',
                  hintStyle: KtextstyleActivity1,
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                ),
              ),
              const SizedBox(height: 20),
              /// Activity duration ------ text
              const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 9),
                  child: Text(
                    'ACTIVITY DURATION',
                    style: KtextstyleActivity,
                  )),
              const SizedBox(height: 10),
              /// Activity Duration ----textfield
              TextFormField(
                style:KtextstyleActivity1,
                keyboardType:TextInputType.number,
                controller: durationController,
                decoration: InputDecoration(
                  hintText: 'Enter Number of Hours',
                  hintStyle: KtextstyleActivity1,
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                ),
              ),
              const Spacer(),

              Row(children: [
                Expanded(
                    flex: 4,
                    child: SizedBox(
                        height: 60,
                        child: GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: const Card(
                              color: Colors.grey,
                              child: Center(
                                  child: Text(
                                    'Cancel',
                                    style: Ktextstylecardbutton,
                                  ))),
                        ))),
                Expanded(
                  flex: 6,
                  child: SizedBox(
                      height: 60,
                      child: GestureDetector(
                          onTap: () {
                            _formKey.currentState!.validate();
                            bool available = false;

                            if(queryEmployeeController.attendanceList[widget.index]["CUBN Timesheet"].isEmpty){
                              projectActivityController.projectActivityList.add(ProjectActivityModel(
                                  projectName: projectNameController.dropDownValue!.value.toString(),
                                  projectDescription: descriptionController.text,
                                  projectDuration: durationController.text,
                                  date: queryEmployeeController.attendanceList[widget.index]["Attendance Date"],
                              ));
                              Get.back();
                              Get.snackbar(
                                "Entry Added Successfully",
                                "",
                              );
                            }
                            else{
                              /// Checking for availability
                              for(int i=0; i < queryEmployeeController.attendanceList[widget.index]["CUBN Timesheet"].length; i++){
                                if(projectNameController.dropDownValue!.value.toString() == queryEmployeeController.attendanceList[widget.index]["CUBN Timesheet"][i]["Project Name"]){
                                  available = true;
                                }
                              }
                              /// if available --> Show snack-bar
                              if(available == true){
                                Get.snackbar("Entry Already Exist", "");
                              }
                              else{
                                projectActivityController.projectActivityList.add(ProjectActivityModel(
                                  projectName: projectNameController.dropDownValue!.value,
                                  projectDescription: descriptionController.text,
                                  projectDuration: durationController.text,
                                  date: queryEmployeeController.attendanceList[widget.index]["Attendance Date"]
                                ));
                                Get.back();
                                Get.snackbar("Entry Added", "");
                              }
                            };
                          },
                          child: const Card(
                              color: Colors.orangeAccent,
                              child: Center(
                                  child: Text(
                                    '+Add',
                                    style: Ktextstylecardbutton,
                                  )))
                      )
                  ),
                )]),

            ],
          ),
        ),
      ),
    );
  }
}
