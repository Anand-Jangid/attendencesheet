import 'package:attendencesheet/Screens/cardscreen.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
class ViewAllScreen extends StatefulWidget {
  static const String id = 'view_screen';


  @override
  State<ViewAllScreen> createState() => _ViewAllScreenState();
}

class _ViewAllScreenState extends State<ViewAllScreen> {
  List<dynamic> Users = [];
  Future<List> getData2() async {
    http.Response response = await http.post(
        Uri.parse(
            'https://devxnet.cubastion.net/api/v1/employee/queryEmployee'),
        headers: {
          'token':tokens

        });
    var data = jsonDecode(response.body.toString());
    var datas = data['SiebelMessage']['Employee']['CUBN Attendance'];
    if (response.statusCode == 200) {
      for (Map i in datas) {
        Users.add(i);
      }
      return Users;
    } else {
      return Users;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color:Colors.grey),
        title: Text('ATTENDANCE', style: Ktextstylecarddate4),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),

        child: Column(
          children: [
            Flexible(
              child: FutureBuilder(
                future: getData2(),
                  builder: (context, snapshot){
                  if(!snapshot.hasData){
                    return Text('Loading');
                  }
                  else
                    {
                      return ListView.builder(
                        itemCount: Users.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap:true,
                        itemBuilder:(context, index){
                          double hour1=0;
                          List <dynamic> timesheet1=Users[index]['CUBN Timesheet'];
                          if(timesheet1.length==0){
                            hour1=0;
                          }
                          else{
                            for(int i=0;i<timesheet1.length;i++){
                              hour1=hour1+double.parse(timesheet1[i]['Number of Hours']);
                            }
                          }
                          return Padding(
                            padding:EdgeInsets.all(0.0),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Container(
                                      height: 90.0,
                                      child: GestureDetector(
                                        onTap: (){
                                          Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => CardScreen(
                                            datess:DateFormat('d MMM').format(DateFormat('MM/dd/y').parse(Users[index]['Attendance Date'])) ,
                                            week:DateFormat('EEEE').format(DateFormat('MM/dd/y').parse(Users[index]['Attendance Date'])) ,
                                            inTime:Users[index]['Start Time'].toString(),
                                            OutTime:Users[index]['End Time'].toString(),
                                            indx:index,
                                            date:Users[index]['Attendance Date'],
                                            hour:hour1.toString(),
                                            User4: Users[index]['CUBN Timesheet'],

                                          ))).then((value) {
                                            getData2();
                                            setState(() {
                                              //refresh hoja
                                            });
                                          }
                                          );
                                        },
                                        child: Card(
                                          child: Padding(
                                            padding: EdgeInsets.all(18.0),
                                            child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(DateFormat('d MMM').format(DateFormat('MM/dd/y').parse(Users[index]['Attendance Date'])),
                                                          style: Ktextstylecarddate6),
                                                      SizedBox.fromSize(
                                                        child: SizedBox(width: 25.0),
                                                      ),
                                                      Text(
                                                        DateFormat('EEEE').format(DateFormat('MM/dd/y').parse(Users[index]['Attendance Date'])),
                                                        style: Ktextstylecarddate6,
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text('${Users[index]['Start Time'].toString()} - ${Users[index]['End Time'].toString()}', style: Ktextstylecarddate5),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            hour1.toString(),
                                                            style: Ktextstylecarddate5,
                                                          ),
                                                          Icon(Icons.keyboard_arrow_right,color:Colors.grey,)
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ]),
                                          ),
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                          );
                        }

                      );
                    }
                  }
              ),
            )
          ],
        ),
      ),
    );
  }
}
