import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants.dart';

class AttendanceCard extends StatelessWidget {
  final String attendanceDate;
  final String startTime;
  final String endTime;
  final String hours;

  const AttendanceCard({Key? key,
    required this.attendanceDate,
    required this.startTime,
    required this.endTime,
    required this.hours,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
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
                  Text(DateFormat('d MMM').format(DateFormat('MM/dd/y').parse(attendanceDate)),
                      style: Ktextstylecarddate)
                ]),
                Row(children: [
                  Text(
                      DateFormat('EEEE').format(DateFormat('MM/dd/y').parse(attendanceDate)),
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
                  children: const [
                    Text('IN TIME',
                        style:
                        KtextstylecardIN),
                    Icon(Icons.arrow_right_alt,
                        color: Colors.green),
                    Text(
                      'OUT TIME',
                      style: KtextstylecardIN,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(startTime,style:  KtextstylecardIN),
                    Text(endTime, style: KtextstylecardIN,)
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
                      onPressed:(){}, child:Text('${hours} Hrs ',style:const TextStyle(fontSize:10 ),)
                  ),
                ),
                const Text('of Activity',style:KtextstylecardIN),],
            )

          ],
        ),
      ),
    );
  }
}
