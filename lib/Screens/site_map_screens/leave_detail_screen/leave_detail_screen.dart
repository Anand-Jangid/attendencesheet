import 'package:attendencesheet/Screens/site_map_screens/leave_detail_screen/app_bar/apply_leave_screen.dart';
import 'package:attendencesheet/Screens/site_map_screens/leave_detail_screen/app_bar/comp_off_screen.dart';
import 'package:flutter/material.dart';
import 'package:attendencesheet/constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class LeaveDetailScreen extends StatelessWidget {
  List<dynamic> UserLeave = [];

  LeaveDetailScreen({super.key});
  Future<List> getDataLeave() async {

    http.Response response = await http.post(
        Uri.parse(
            'https://devxnet.cubastion.net/api/v1/employee/queryEmployee'),
        headers: {
          'token': tokens
        });
    var data = jsonDecode(response.body.toString());
    var datas = data['SiebelMessage']['Employee']['CUBN Leave Financial Year BC'];
    if (response.statusCode == 200) {
      for (Map i in datas) {
        UserLeave.add(i);
      }

      return UserLeave;
    } else {
      return UserLeave;
    }
  }

    var size, height, width;
    @override
    Widget build(BuildContext context) {
      size = MediaQuery.of(context).size;
      height = size.height;
      width = size.width;
      return Scaffold(
        appBar: AppBar(
          leading: const BackButton(
            color: Colors.grey,
          ),
          title: const Text('LEAVES DETAILS', style: TextStyle(
              color: Colors.black54,
              fontSize: 15,
              fontWeight: FontWeight.w700)),
          actions: [
            TextButton(onPressed: () => Get.to(() => CompOffScreen()), child: const Text('Earn Comp Off', style: TextStyle(fontSize: 10.0),)),
            TextButton(onPressed: () => Get.to(() => ApplyLeaveScreen()), child: const Text('Apply Leave', style: TextStyle(fontSize: 10.0),))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [

                    FutureBuilder(
                      future:getDataLeave(),
                      builder:(context,snapshot){
                        if(!snapshot.hasData){
                          return const Text('');
                        }
                        else{
                          return Column(children: [
                            SizedBox(
                              height:height/14,
                              child: Row(
                                children: [SizedBox(
                                  height: height / 14,
                                  width: width / 4,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            color: Color(0xFF01579B)
                                        ),
                                        borderRadius: BorderRadius.circular(20.0)
                                    ),

                                    child: const Center(child: Text('2022-2023', style: TextStyle(
                                        color: Color(0xFF01579B),
                                        fontWeight: FontWeight.bold),)),
                                  ),
                                )
                                ],
                              ),
                            ),
                            const SizedBox(height:20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Leaves',style:KtextstyleLeaves),
                                Text('${UserLeave[0]['Remaining Leaves']} balance of ${UserLeave[0]['Credit Count']}',style:KtextstyleComp)
                              ],
                            ),
                            const SizedBox(height:15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Comp Off',style:KtextstyleLeaves),
                                Text('${UserLeave[0]['Comp Off Debit']} balance of ${UserLeave[0]['Comp Off Credit']}', style:KtextstyleComp,)
                              ],
                            ),
                            const SizedBox(height:20)]);
                        }
                      },
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [Text('TRANSACTION DETAILS',style:KtextstyleComp2),],
                    ),
                    const SizedBox(height:20),
                    Column(
                      children: [
                        FutureBuilder(
                          future: getDataLeave(),
                            builder:(context,snapshot){
                            if(!snapshot.hasData){
                              return const Center(child: CircularProgressIndicator());
                            }
                            else{
                              return SizedBox(
                                height:height/2,
                                width:width,
                                child:ListView.builder(
                                  shrinkWrap: true,
                                  itemCount:UserLeave[0]['CUBN Fianacial Year Register BC'].length,
                                    itemBuilder:(context,index){
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:CrossAxisAlignment.start,
                                          children:[
                                        Text('${DateFormat('dd MMM y').format(DateFormat('MM/dd/y').parse(UserLeave[0]['CUBN Fianacial Year Register BC'][UserLeave[0]['CUBN Fianacial Year Register BC'].length-1-index]['Leave Date']))} (${UserLeave[0]['CUBN Fianacial Year Register BC'][UserLeave[0]['CUBN Fianacial Year Register BC'].length-1-index]['Leave Type']})',style:KtextstyleLeaves ,),
                                        Text('${UserLeave[0]['CUBN Fianacial Year Register BC'][UserLeave[0]['CUBN Fianacial Year Register BC'].length-1-index]['Type']}'=='Credit'?'+ ${UserLeave[0]['CUBN Fianacial Year Register BC'][UserLeave[0]['CUBN Fianacial Year Register BC'].length-1-index]['Leave Count']}':'- ${UserLeave[0]['CUBN Fianacial Year Register BC'][UserLeave[0]['CUBN Fianacial Year Register BC'].length-1-index]['Leave Count']}',style:KtextstyleComp),
                                      ]),
                                    );
                                    }
                                    ) ,
                              );
                            }
                            }
                        )
                      ],
                    )
                  ],
          )
        ),
      );
    }
  }
