import 'package:attendencesheet/apis/putdataapi.dart';
import 'package:attendencesheet/controllers/pending_leaves_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../constants.dart';

class PendingApprovalPage extends StatelessWidget {

  final PendingLeavesController pendingLeavesController = Get.put(
      PendingLeavesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "PENDING APPROVAL",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Flexible(
            child: Obx(() {
              if(pendingLeavesController.isLoading.value){
                return const Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                itemCount: pendingLeavesController.pendingLeaveList.length,
                itemBuilder: (context, index){
                  return Container(
                    height: 90.0,
                    child: InkWell(
                      onTap: (){

                        Get.defaultDialog(
                          title: "Accept/Reject ?",
                          textCancel: "Reject",
                          textConfirm: "Accept",
                          barrierDismissible: true,
                          onConfirm: () async{
                            await ApiService.setLeaveAcceptReject(pendingLeavesController.pendingLeaveList[index].id, "Active");
                            pendingLeavesController.pendingLeaveList.removeAt(index);
                          },
                          onCancel: () async{
                            await ApiService.setLeaveAcceptReject(pendingLeavesController.pendingLeaveList[index].id, "Reject");
                            pendingLeavesController.pendingLeaveList.removeAt(index);
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
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(pendingLeavesController.pendingLeaveList[index].employeeFirstName,
                                            style: Ktextstylecarddate6),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          pendingLeavesController.pendingLeaveList[index].employeeLastName,
                                          style: Ktextstylecarddate6,
                                        ),
                                      ],
                                    ),
                                    Text("${DateFormat('dd-MM-yyyy').format(pendingLeavesController.pendingLeaveList[index].leaveDate)} (${pendingLeavesController.pendingLeaveList[index].leaveType} )",style: Ktextstylecarddate5)
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(pendingLeavesController.pendingLeaveList[index].comments,
                                        softWrap: true,
                                        style: Ktextstylecarddate5),
                                    Text(pendingLeavesController.pendingLeaveList[index].leaveCount
                                        .toString())
                                  ],
                                ),
                              ]),
                        ),
                      ),
                    ),
                  );
                });
            }),
          ),
        ],
      ),
    );
  }
}
