import 'package:attendencesheet/apis/api_service.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants.dart';
import 'package:intl/intl.dart';
class ProjectActivityUpdate extends StatefulWidget {

  final String date;
  final String  projectName;
  final String projectDescription;
  final String projectDuration;
  // final Function UpdateFunction;
  // final List projects;
  const ProjectActivityUpdate({
    super.key,
    required this.date,
    required this.projectDescription,
    required this.projectDuration,
    required this.projectName,
    // required this.UpdateFunction,
    // required this.projects
  });
  @override
  State<ProjectActivityUpdate> createState() => _ProjectActivityState();
}

class _ProjectActivityState extends State<ProjectActivityUpdate> {

  @override
  Widget build(BuildContext context) {
    TextEditingController description = TextEditingController(text:widget.projectDescription);
    TextEditingController duration = TextEditingController(text:widget.projectDuration);
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black,
        ),
        title: Text(DateFormat('d MMM EEE').format(DateFormat('MM/dd/y').parse(widget.date)), style: Ktextstyledaily),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 9),
                    child: Text(
                      'PROJECT',
                      style: KtextstyleActivity,
                    )),
                const SizedBox(height: 10),
                ///projectName
                TextField(
                  readOnly:true,
                  style:KtextstyleActivity1,
                  decoration: InputDecoration(
                    hintText: widget.projectName,
                    hintStyle: KtextstyleActivity1,
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                ),
                const SizedBox(height: 20),
                ///Activity description --- text
                const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 9),
                    child: Text(
                      'ACTIVITY DESCRIPTION',
                      style: KtextstyleActivity,
                    )),
                const SizedBox(height: 10),
                ///Activity descrtiption ----textfield
                TextField(
                  style:KtextstyleActivity1,
                  controller: description,
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
                /// Activity duration -------- text
                const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 9),
                    child: Text(
                      'ACTIVITY DURATION',
                      style: KtextstyleActivity,
                    )),
                const SizedBox(height: 10),
                /// Duration -------- textfield
                SizedBox(
                  height: 50,
                  child: TextField(
                    style:KtextstyleActivity1,
                    keyboardType:TextInputType.number,
                    controller: duration,

                    decoration: InputDecoration(
                      hintText: 'Enter Number of Hours',
                      hintStyle: KtextstyleActivity1,
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                  ),
                ),
              ],
            ),
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
                        // onTap: () async{
                        //   if(widget.projects.length == 0){
                        //     Navigator.pop(context);
                        //   }
                        //   else{
                        //     List<String> object1 = [widget.name, description.text, duration.text, widget.date];
                        //     widget.UpdateFunction(object1, widget.projects);
                        //     Navigator.pop(context);
                        //   }
                        // },
                        child: const Card(
                            color: Colors.orangeAccent,
                            child: Center(
                                child: Text(
                                  'Update',
                                  style: Ktextstylecardbutton,
                                ))),
                      )
                  )
              ),
            ])
          ],
        ),
      ),
    );
  }
}
