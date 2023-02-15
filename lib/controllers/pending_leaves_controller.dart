import 'package:attendencesheet/apis/api_service.dart';
import 'package:get/get.dart';
import '../models/pending_leave_aproval_model1.dart';

class PendingLeavesController extends GetxController{
  var isLoading = true.obs;
  var pendingLeaveList = <PendingLeaveApprovalModel1>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchLeaveList();
  }

  void fetchLeaveList() async{
    try{
      isLoading(true);
      var leaves = await ApiService.getPendingLeaveData();
      if( leaves != null){
        pendingLeaveList.value = leaves;
      }
    }
    finally{
      isLoading(false);
    }
  }
}