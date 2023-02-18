import 'package:flutter/material.dart';
import '../constants.dart';
import '../Screens/project_activity_update.dart';

class ProjectActivityWidget extends StatelessWidget {
  final String projectName;
  final String projectDescription;
  final String projectDuration;
  // final String date;
  // final List Updatelist;
  // final Function UpdateF;
  const ProjectActivityWidget({Key? key,
    required this.projectName,
    required this.projectDescription,
    required this.projectDuration,
    // required this.Updatelist,
    // required this.UpdateF,
    // required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: (){
      //   Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ProjectActivityUpdate(name: projectName, projectDescription: projectDescription, projectDuration: projectDuration, date: date,UpdateFunction:UpdateF,projects:Updatelist)));
      // },
      child: Card(
        child: Padding(
          padding:EdgeInsets.all(7.0),
          child: Column(
            children: [
              ///name and duration
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ///project namte
                  Text(
                    projectName,
                    style:TextStyle(fontSize:15.0,color:Colors.black54,fontWeight:FontWeight.w600 )
                  ),
                  ///duration
                  Text(
                    '${projectDuration} Hrs',
                    style:Ktextstylecarddate,
                  )
                ],
              ),
              const SizedBox(height: 10,),
              ///project description and icon
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ///description
                  Expanded(
                    child: Text(
                      projectDescription,
                      style:Ktextstylecarddate,
                      softWrap: true,
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_right,color:Colors.grey,)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}