import 'package:attendencesheet/apis/api_service.dart';
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

}