import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants.dart';

class ViewAllAttendanceCard extends StatelessWidget {
  final String attendanceDate;
  final String startTime;
  final String endTime;
  final String hours;

  const ViewAllAttendanceCard({Key? key,
    required this.attendanceDate,
    required this.endTime,
    required this.startTime,
    required this.hours,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(18.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(DateFormat('d MMM').format(DateFormat('MM/dd/y').parse(attendanceDate)),
                      style: Ktextstylecarddate6),
                  SizedBox.fromSize(
                    child: SizedBox(width: 25.0),
                  ),
                  Text(
                    DateFormat('EEEE').format(DateFormat('MM/dd/y').parse(attendanceDate)),
                    style: Ktextstylecarddate6,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${startTime} - ${endTime}', style: Ktextstylecarddate5),
                  Row(
                    children: [
                      Text(
                        hours,
                        style: Ktextstylecarddate5,
                      ),
                      Icon(Icons.keyboard_arrow_right,color:Colors.grey,)
                    ],
                  )
                ],
              ),
            ]),
      ),
    );
  }
}
