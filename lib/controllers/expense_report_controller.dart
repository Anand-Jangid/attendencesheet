import 'package:attendencesheet/apis/api_service.dart';
import 'package:get/get.dart';

class ExpenseReportController extends GetxController{

  var isLoading = true.obs;
  var expenseReportList = [].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchExpenseReportList();
  }

  void fetchExpenseReportList() async{
    isLoading(true);
    expenseReportList.value = await ApiService.getExpenseReport();
    isLoading(false);
  }

}