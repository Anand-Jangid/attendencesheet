import 'package:attendencesheet/apis/putdataapi.dart';

import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:intl/intl.dart';
class ProjectActivityUpdate extends StatefulWidget {
  static String id = 'project_activity';
  final String date;
  final String  name;
  final String projectDescription;
  final String projectDuration;
  final Function UpdateFunction;
  final List projects;
  ProjectActivityUpdate({required this.date,required this.projectDescription,required this.projectDuration,required this.name,required this.UpdateFunction,required this.projects});
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
        leading: BackButton(
          color: Colors.black,
        ),
        title: Text(DateFormat('d MMM EEE').format(DateFormat('MM/dd/y').parse(widget.date)), style: Ktextstyledaily),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 9),
                    child: Text(
                      'PROJECT',
                      style: KtextstyleActivity,
                    )),
                SizedBox(height: 10),
                TextField(
                  // controller:name2,
                  readOnly:true,
                  style:KtextstyleActivity1,
                  decoration: InputDecoration(
                    hintText: widget.name,
                    hintStyle: KtextstyleActivity1,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 9),
                    child: Text(
                      'ACTIVITY DESCRIPTION',
                      style: KtextstyleActivity,
                    )),
                SizedBox(height: 10),
                TextField(
                  style:KtextstyleActivity1,
                  controller: description,
                  decoration: InputDecoration(
                    hintText: 'Enter Project Description',
                    hintStyle: KtextstyleActivity1,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 9),
                    child: Text(
                      'ACTIVITY DURATION',
                      style: KtextstyleActivity,
                    )),
                SizedBox(height: 10),
                SizedBox(
                  height: 50,
                  child: TextField(
                    style:KtextstyleActivity1,
                    keyboardType:TextInputType.number,
                    controller: duration,

                    decoration: InputDecoration(
                      hintText: 'Enter Number of Hours',
                      hintStyle: KtextstyleActivity1,
                      focusedBorder: OutlineInputBorder(
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
                          Navigator.pop(context);
                        },
                        child: Card(
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
                        onTap: () async{
                          if(widget.projects.length == 0){
                            Navigator.pop(context);
                          }
                          else{
                            List<String> object1 = [widget.name, description.text, duration.text, widget.date];
                            widget.UpdateFunction(object1, widget.projects);
                            Navigator.pop(context);
                          }
                        },
                        child: Card(
                            color: Colors.orangeAccent,
                            child: Center(
                                child: Text(
                                  'Update',
                                  style: Ktextstylecardbutton,
                                ))),
                      ))),
            ])
          ],
        ),
      ),
    );
  }
}
