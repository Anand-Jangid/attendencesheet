import '../controllers/projectactivity.dart';
import 'package:attendencesheet/apis/api_service.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../widgets/projectwidget.dart';
import '../models/usermodel.dart';

class CardScreen extends StatefulWidget {
  static const id = 'card_screen';
  const CardScreen(
      {super.key, required this.datess,
        required this.week,
        required this.inTime,
        required this.outTime,
        required this.indx,
        required this.date,
        required this.hour,
        required this.user4,

      });
  final String datess;
  final String week;
  final String inTime;
  final String outTime;
  final int indx;
  final String date;
  final String hour;
  final List user4;




  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {

  List user2=[];

  void addElementsToTimeSheet(List<String> object){
    ///List object = [projectName, projectDescription, projectDuration,attendance date]
    Map newObject = {
      'Project Name' : object[0],
      "Description" : object[1],
      "Number of Hours" : object[2],
      "Attendance Date" :object[3],
    };
    setState(() {
      user2.add(newObject);
    });
  }

  /// UPDATE function
  void updateElementsToTimeSheet(List<String> object, List projects){
    ///List object = [projectName, projectDescription, projectDuration,attendance date]

    Map newObject = {
      'Project Name' : object[0],
      "Description" : object[1],
      "Number of Hours" : object[2],
      "Attendance Date" :object[3],
    };
    for(int i=0; i<projects.length; i++){

      if(projects[i]['Project Name'] == object[0]){
        setState(() {

          projects.removeAt(i);
          projects.insert(i, newObject);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ApiService apiService=ApiService();
    user2=widget.user4;
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(color: Colors.grey,
              onPressed:(){
        Navigator.pop(context);
        },
          ),
          title: const Text('ATTENDANCE', style: Ktextstyledaily),
        ),
        body: Padding(
            padding: const EdgeInsets.all(20.0),

          child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 6,
              child: Column(children: [

                Column(
                  children: [ Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            widget.datess,
                            style: Ktextstylecarddate2,
                          ),
                          Text(widget.week, style: Ktextstylecarddate)
                        ],
                      ),
                      Column(
                        children: [
                          Text(widget.hour , style: Ktextstylecarddate3),
                          const Text('OF ACTIVITY', style: Ktextstylecarddate)
                        ],
                      )
                    ],
                  ),
                    const SizedBox(height: 20.0),
                    Row(children: [
                      Expanded(
                        child: SizedBox(
                            height: 55.0,
                            child: Card(
                              child: Center(
                                  child: Text(
                                    'In Time ${widget.inTime}',
                                    style: Ktextstylecarddate,
                                  )),
                            )),
                      ),
                      Expanded(
                        child: SizedBox(
                            height: 55.0,
                            child: Card(
                              child: Center(
                                  child: Text(
                                    'Out Time ${widget.outTime}',
                                    style: Ktextstylecarddate,
                                  )),
                            )),
                      ),
                    ]),],
                ),
                Column(children: [
                  ListView.builder(
                      shrinkWrap: true,
                      scrollDirection:Axis.vertical,
                      itemCount: user2.length,
                      itemBuilder: (context, index) {
                        return ProjectActivityWidget(
                          date: widget.date,
                          projectName: user2[index]["Project Name"],
                          projectDescription: user2[index]["Description"],
                          projectDuration: user2[index]["Number of Hours"],
                          Updatelist: user2,
                          UpdateF: (object,projects){
                            updateElementsToTimeSheet(object, projects);
                          },
                        )
                        ;
                      }),
                ],)
              ]),
            ),
            /// +project activity -------- submit
            Column(
              children: [
                Row(children: [
                  ///project activity
                  Expanded(
                      flex: 4,
                      child: SizedBox(
                          height: 60,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          ProjectActivity(
                                            projects:user2,
                                            indx: widget.indx,
                                            date:widget.date,
                                            addFunction:(List<String> object){
                                              addElementsToTimeSheet(object);
                                          },
                                          )));
                            },
                            child: const Card(
                                color: Colors.grey,
                                child: Center(
                                    child: Text(
                                      '+Project Activity',
                                      style: Ktextstylecardbutton,
                                    ))),
                          ))),
                  Expanded(
                      flex: 6,
                      child: SizedBox(
                          height: 60,
                          child: GestureDetector(
                            onTap: () async{

                              for(int i=0; i<user2.length; i++){

                               UserModel user = await apiService.getData5( user2[i]["Description"], user2[i]["Number of Hours"],user2[i]["Project Name"], user2[i]["Attendance Date"]);
                                       }

                                     Navigator.pop(context);
                            },
                            child: const Card(
                                color: Colors.orangeAccent,
                                child: Center(
                                    child: Text('Submit',
                                        style: Ktextstylecardbutton))),
                          ))),
                ])
              ],
            )
          ],
        )),
            );
  }
}

