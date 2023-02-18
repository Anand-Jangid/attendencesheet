import 'package:attendencesheet/apis/api_service.dart';
import 'package:get/get.dart';

class QueryEmployeeController extends GetxController{
  var attendanceList = [].obs;
  var projects = [].obs;
  var leaves = [].obs;
  var expenseData = [].obs;
  var currency = [].obs;
  var isLoading = false.obs;
  var reportingManagerFirstName = "".obs;
  var reportingManagerLastName = "".obs;
  var reportingManagerMiddleName = "".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchData();
  }

  void fetchData() async{
    isLoading(true);
    var data = await ApiService.queryEmployee();
    var data2 = await ApiService.LOVforExpense();
    attendanceList.value = data["CUBN Attendance"];
    projects.value = data["CUBN Employee Projects"];
    leaves.value = data["CUBN Leave Financial Year BC"];
    reportingManagerFirstName.value = data["Reporting Manager First Name"];
    reportingManagerLastName.value = data["Reporting Manager Last Name"];
    reportingManagerMiddleName.value = data["Reporting Manager Middle Name"];
    expenseData.value = data2["data"][0]["expenseData"];
    currency.value = data2["data"][0]["currencyData"];
    isLoading(false);
  }
}