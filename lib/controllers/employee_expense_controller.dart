import 'package:attendencesheet/apis/putdataapi.dart';
import 'package:get/get.dart';

class EmployeeExpenseController extends GetxController{

  var isLoading = true.obs;
  var expensesList = [].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchExpenseData();
  }

  void fetchExpenseData() async{
    try{
      isLoading(true);
      var expense = await ApiService.getExpenses();
      if(expense != null){
        expensesList.value = expense;
      }
    }
    finally{
      isLoading(false);
    }
  }
  // void fetchLeaveList() async{
  //   try{
  //     isLoading(true);
  //     var leaves = await ApiService.getPendingLeaveData();
  //     if( leaves != null){
  //       pendingLeaveList.value = leaves;
  //     }
  //   }
  //   finally{
  //     isLoading(false);
  //   }
  // }

}