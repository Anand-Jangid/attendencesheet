import 'package:attendencesheet/apis/putdataapi.dart';
import 'package:attendencesheet/controllers/pending_leaves_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../constants.dart';

class PendingApprovalPage extends StatefulWidget {

  @override
  State<PendingApprovalPage> createState() => _PendingApprovalPageState();
}

class _PendingApprovalPageState extends State<PendingApprovalPage> {
  bool isLoading = false;
  final PendingLeavesController pendingLeavesController = Get.put(PendingLeavesController());
     
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
          Expanded(
            child: Obx(() {
              if(pendingLeavesController.isLoading.value){
                return const Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                itemCount: pendingLeavesController.pendingLeaveList.length,
                itemBuilder: (context, index){
                  return InkWell(
                    onTap: (){
                      Get.defaultDialog(
                        title: "Accept/Reject ?",
                        // textCancel: "Reject",
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                            onPressed: () async{
                              setState(() {
                                isLoading = true;
                              });
                              await ApiService.setLeaveAcceptReject(pendingLeavesController.pendingLeaveList[index].id, "Active");
                              pendingLeavesController.pendingLeaveList.removeAt(index);
                              Get.back();
                              setState(() {
                                isLoading = false;
                              });
                            }, child: (isLoading) ? const Center(child: CircularProgressIndicator()) : const Text("Accept")),
                            const SizedBox(width: 10,),
                            ElevatedButton(onPressed: () async{
                              setState(() {
                                isLoading = true;
                              });
                              await ApiService.setLeaveAcceptReject(pendingLeavesController.pendingLeaveList[index].id, "Rejected");
                              pendingLeavesController.pendingLeaveList.removeAt(index);
                              Get.back();
                            }, child: (isLoading) ? const Center(child: CircularProgressIndicator()) : const Text("Reject")),
                          ],
                        ),
                        // textConfirm: "Accept",
                        barrierDismissible: true,
                        // onConfirm: () async{
                        //   await ApiService.setLeaveAcceptReject(pendingLeavesController.pendingLeaveList[index].id, "Active");
                        //   pendingLeavesController.pendingLeaveList.removeAt(index);
                        //   // Get.back();
                        // },
                        // onCancel: () async{
                        //   await ApiService.setLeaveAcceptReject(pendingLeavesController.pendingLeaveList[index].id, "Rejected");
                        //   pendingLeavesController.pendingLeaveList.removeAt(index);
                        //   // Get.back();
                        // }
                      );
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
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
                                  Expanded(
                                    child: Text(pendingLeavesController.pendingLeaveList[index].comments,
                                        softWrap: false,
                                        maxLines: 999,
                                        overflow: TextOverflow.ellipsis,
                                        style: Ktextstylecarddate5),
                                  ),
                                  Text(pendingLeavesController.pendingLeaveList[index].leaveCount
                                      .toString())
                                ],
                              ),
                            ]),
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
