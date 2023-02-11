import 'package:flutter/material.dart';
import '../../constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class SalaryScreen extends StatefulWidget {
  static const String id = 'salary_screen';
  @override
  State<SalaryScreen> createState() => _SalaryScreenState();
}

class _SalaryScreenState extends State<SalaryScreen> {
  List<dynamic> User3 = [];
  bool ontapp=true;
  Future<List> getData3() async {
    User3.clear();
    http.Response response = await http.post(
        Uri.parse(
            'https://devxnet.cubastion.net/api/v1/employee/queryEmployee'),
        headers: {
          'token':tokens

        });
    var data = jsonDecode(response.body.toString());
    var datas = data['SiebelMessage']['Employee']['CUBN Employee Salary FY'][0]
    ['CUBN Employee Salary Detail'];
    if (response.statusCode == 200) {
      for (Map i in datas) {
        User3.add(i);
      }
      return User3;
    } else {
      return User3;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color:Colors.grey),
        title: Text('SALARY DETAILS', style: Ktextstylecarddates),
      ),
      body: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: [
                 FutureBuilder(
                    future: getData3(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Text('Loading');
                      } else {
                        return Flexible(
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: User3.length,
                            itemBuilder: (context, index) =>
                              Row(
                                children: [
                                  Expanded(
                                      child: Container(
                                        height: 105.0,
                                        child: Card(
                                          child: Padding(
                                            padding: EdgeInsets.all(12.0),
                                            child: Column(children: [
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                      DateFormat('MMMM').format(
                                                          DateFormat('MM').parse(
                                                              User3[index]['Month'])),
                                                      style: Ktextstylecarddate5),
                                                  Text(
                                                    'CREDITED SALARY:  ${User3[index]['Total Amount Payable'].toString()}',
                                                    style: Ktextstylecarddate4,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 10.0),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.end,
                                                children: [
                                                  Icon(
                                                    Icons.keyboard_arrow_down,
                                                    size: 30,
                                                    color:Colors.grey,
                                                  )
                                                ],
                                              )
                                            ]),
                                          ),
                                        ),
                                      ))
                                ],
                              ),
                          ),
                        );
                      }
                    }),

            ],
          )),
    );
  }
}
