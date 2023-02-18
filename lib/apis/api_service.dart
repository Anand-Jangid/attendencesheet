import 'dart:io';

import 'package:attendencesheet/controllers/submit_project_expense_controller.dart';
import 'package:attendencesheet/models/add_project_expense_model.dart';
import 'package:attendencesheet/models/leave_approval_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../constants.dart';
import '../models/employee_leave_model1.dart';
import '../models/pending_leave_aproval_model1.dart';
import '../models/usermodel.dart';

class ApiService{

  /// query Employee
  static Future<Map> queryEmployee() async {
    http.Response response = await http.post(
        Uri.parse(
            '$baseURL/employee/queryEmployee'),
        headers: {'token': tokens});
    var data = jsonDecode(response.body.toString());
    var datas = data['SiebelMessage']['Employee'];
    if (response.statusCode == 200) {
      return datas;
    } else {
      throw Exception("Query Employee API--Status code is not 200. \n Status code is ${response.statusCode}");
    }
  }

  static final SubmitProjectExpenseController submitProjectExpenseController = Get.find();

  static void updatedList(List<PendingLeaveApprovalModel1> users){
    users.sort((a, b) => b.leaveDate.compareTo(a.leaveDate));
  }

  static Future<UserModel> upsertAttendance(String description,String duration,String name,String date) async {
    var body=json.encode({
      "body": {
        "SiebelMessage": {
          "IntObjectFormat": "Siebel Hierarchical",
          "IntObjectName": "CUBNAttendance",
          "ListOfCUBNAttendance": {
            "CUBN Attendance": {
              "Start Time": "09:30",
              "End Time": "18:30",
              "Attendance Date": date,
              "ListOfCubnTimesheet": {
                "CUBN Timesheet": [{
                  "Description":description ,
                  "Number of Hours":duration ,
                  "Project Name":name
                }
                ]
              }
            }
          },
          "MessageType": "Integration Object"
        }
      }
    });
    var headers = {
      'token': tokens,
      'Content-Type': 'application/json'
    };
    UserModel? userModel;
    http.Response response = await http.post(
        Uri.parse('$baseURL/attendance/upsertAttendance'),
        headers: headers,
        body: body);
    if(response.statusCode == 200){
      var jsonResponse = jsonDecode(response.body);
      userModel = UserModel.fromJson(jsonResponse);
      return userModel;
    }
    else{
      print(response.body);
      throw Exception("upsertAttendance API \n status code is not 200 \n status code is ${response.statusCode}");
    }
  }

  /// API for applying leave
  static Future<EmployeeLeaveModel1> setLeaveData(String date, String leaveCount, String comment) async{
    var body = jsonEncode({
      "body": {
        "SiebelMessage": {
          "IntObjectName": "CUBN Employee Leave Apply IO",
          "ListOfCUBN Employee Leave Apply IO": {
            "CUBN Employee Leave Apply BC": {
              "Comments": comment,
              "Financial Year Id": "yirqzdpcqt22uzj",
              "Leave Count": leaveCount,      // 1 or 0.5
              "Leave Date": date,             //   MM/DD/YYYY
              "Leave Type": "Leave",
              "Type": "Debit"
            }
          }
        }
      }
    });
    var headers = {
      'token': tokens,
      'Content-Type': 'application/json'
    };
    EmployeeLeaveModel1? employeeLeaveModel;
    http.Response response = await http.post(
      Uri.parse("$baseURL/leavesLedger/applyForLeaveByApplication"),
      headers: headers,
      body: body,
    );
    var jsonResponse = jsonDecode(response.body);
    if(response.statusCode == 200){
      employeeLeaveModel = EmployeeLeaveModel1.fromJson(jsonResponse["SiebelMessage"]["CUBN Employee Leave Apply BC"]);
      return employeeLeaveModel;
    }
    else if(response.statusCode == 203){

      employeeLeaveModel = EmployeeLeaveModel1(
          type: "",
          approverMidName: "",
          approverId: "",
          leaveDate: DateTime.now(),
          leaveCount: "",
          id: "",
          employeeFirstName: "",
          employeeMidName: "",
          comments: "",
          employeeNumber: "",
          leaveType: "",
          status: "1234567890",
          approverFirstName: "",
          approverLastName: "",
          financialYearId: "",
          employeeLastName: "");
      return employeeLeaveModel;
    }
    else{
      throw Exception("Something is wrong \n Status code is ${response.statusCode}");
    }

  }

  /// API for applying Comp Off
  static Future<EmployeeLeaveModel1> setCompOffData(String date, String leaveCount, String comment) async  {
    var body = jsonEncode({
      "body": {
        "SiebelMessage": {
          "IntObjectName": "CUBN Employee Leave Apply IO",
          "ListOfCUBN Employee Leave Apply IO": {
            "CUBN Employee Leave Apply BC": {
              "Comments": comment,
              "Financial Year Id": "yirqzdpcqt22uzj",
              "Leave Count": leaveCount,      // 1 or 0.5
              "Leave Date": date,             //   MM/DD/YYYY
              "Leave Type": "Comp-Off",
              "Type": "Credit"
            }
          }
        }
      }
    });
    var headers = {
      'token': tokens,
      'Content-Type': 'application/json'
    };
    EmployeeLeaveModel1? compOffModel;
    http.Response response = await http.post(
      Uri.parse("${baseURL}/leavesLedger/applyForLeaveByApplication"),
      headers: headers,
      body: body,
    );
    if(response.statusCode == 200){
      var jsonResponse = jsonDecode(response.body);
      compOffModel = EmployeeLeaveModel1.fromJson(jsonResponse["SiebelMessage"]["CUBN Employee Leave Apply BC"]);
    }
    else if(response.statusCode == 203){
      compOffModel = EmployeeLeaveModel1(
          type: "",
          approverMidName: "",
          approverId: "",
          leaveDate: DateTime.now(),
          leaveCount: "",
          id: "",
          employeeFirstName: "",
          employeeMidName: "",
          comments: "",
          employeeNumber: "",
          leaveType: "",
          status: "1234567890",
          approverFirstName: "",
          approverLastName: "",
          financialYearId: "",
          employeeLastName: ""
      );
    }
    else{
      throw Exception("Something is wrong \n Status code is ${response.statusCode}");
    }

    return compOffModel;
  }

  static Future<LeaveApprovalModel> setLeaveAcceptReject(String ID, String status) async{
    var body = json.encode({
      "body": {
        "SiebelMessage": {
          "IntObjectName": "CUBN Employee Leave Apply IO",
          "ListOfCUBN Employee Leave Apply IO": {
            "CUBN Employee Leave Apply BC": {
              "Id": ID,
              "Status": status
            }
          }
        }
      }
    });
    LeaveApprovalModel? leaveApprovalModel;
    http.Response response = await http.post(
      Uri.parse("https://devxnet.cubastion.net/api/v1/leavesLedger/leaveApprovalForApplication"),
      headers: {
        'token': tokens,
        'Content-Type': 'application/json'
      },
      body: body,
    );
    if(response.statusCode == 200){
      var jsonResponse = jsonDecode(response.body);
      leaveApprovalModel = LeaveApprovalModel.fromJson(jsonResponse);
    }
    var jsonResponse = jsonDecode(response.body);
    leaveApprovalModel = LeaveApprovalModel.fromJson(jsonResponse);
    return leaveApprovalModel;
  }

  static Future<List<PendingLeaveApprovalModel1>> getPendingLeaveData() async {
    List<PendingLeaveApprovalModel1> leavesList = [];
    var body = json.encode({
      "body": {"emailAddress": "anand.jangid@cubastion.com"}
    });
    var response = await http.post(
        Uri.parse('$baseURL/leavesLedger/getLeavesByRMApplication'),
        headers: {'token': tokens, 'Content-Type': 'application/json'},
        body: body);
    if(response.statusCode == 200){
      var jsonData = jsonDecode(response.body);
      var leavesList1 = jsonData["SiebelMessage"]["CUBN Employee Leave Apply BC"];
      for(int i=0; i<leavesList1.length; i++){
        leavesList.add(PendingLeaveApprovalModel1(
            approverFirstName: leavesList1[i]["Approver First Name"],
            approverId: leavesList1[i]["Approver Id"],
            leaveDate: DateTime.parse(leavesList1[i]["Leave Date"]),
            financialYearId: leavesList1[i]["Financial Year Id"],
            employeeFirstName: leavesList1[i]["Employee First Name"],
            comments: leavesList1[i]["Comments"],
            employeeNumber: leavesList1[i]["Employee Number"],
            type: leavesList1[i]["Type"],
            leaveType: leavesList1[i]["Leave Type"],
            status: leavesList1[i]["Status"],
            id: leavesList1[i]["Id"],
            approverLastName: leavesList1[i]["Approver Last Name"],
            employeeLastName: leavesList1[i]["Employee Last Name"],
            financialYear: leavesList1[i]["Financial Year"],
            leaveCount: leavesList1[i]["Leave Count"],
            approverNumber: leavesList1[i]["Approver Number"],
            employeeId: leavesList1[i]["Employee Id"]));
      }
      updatedList(leavesList);
      return leavesList;
    }
    else{
      throw Exception("Status code is not 200");
    }

  }

  static Future LOVforExpense() async{
    var headers = {
      'token': tokens
    };  
    var response = await http.get(
      Uri.parse("$baseURL/expenses/LOVForExpense"),
      headers: headers
    );
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      return data;
    }
    else{
      throw Exception("LOV for expense API \n ${response.body}");
    }
  }

  /// API for getting list of expenses
  static Future<List> getExpenses() async{
    var headers = {
      'token': tokens
    };
    var response = await http.post(
      Uri.parse("$baseURL/expenses/queryExpense"),
      headers: headers
    );
    if(response.statusCode == 200){
      var jsonResponse = jsonDecode(response.body);
      var employeeExpensesList = jsonResponse["SiebelMessage"]["CUBN Expenses"];
      return employeeExpensesList;
    }
    else{
      throw Exception("Status code is not 200");
    }

  }
  //getting expense report List
  static Future<List> getExpenseReport() async{
    var headers = {
      'token': tokens
    };
    var response = await http.post(
      Uri.parse("$baseURL/expenseReport/queryExpenseReport"),
      headers: headers
    );
    if(response.statusCode == 200){
      var jsonData = jsonDecode(response.body);
      var expenseReportList = jsonData["SiebelMessage"]["CUBN Expense Report"];
      return expenseReportList;
    }
    else{
      throw Exception("Satus code is not 200 \n it is ${response.statusCode}");
    }
  }

  //adding project expense
  static Future getFile() async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();
      return files;
    } else {
      // User canceled the picker
    }
  }

  //adding project expense
  static Future<void> uploadImage({required String voucher,
        required String voucherDate,
        required String expenseType,
        required String amount,
        required String description,
        required String projectId,
        required List filePaths}) async{

    submitProjectExpenseController.showSpinner.value = true;
    var headers = {
      'token': tokens
    };
    var request = http.MultipartRequest('POST', Uri.parse('$baseURL/expenses/upsertExpense'));
    request.fields.addAll({
      'voucher': voucher,
      'voucherDate': voucherDate,
      'expenseType': expenseType,
      'currency': 'INR',
      'amount': amount,
      'description': description,
      'projectId': projectId
    });
    for(int i=0; i< filePaths.length; i++){
      request.files.add(await http.MultipartFile.fromPath('xnetFiles', filePaths[i].path));
    }
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      submitProjectExpenseController.showSpinner.value = false;
    }
    else {
      submitProjectExpenseController.showSpinner.value = false;
      throw Exception("image is not uploaded");
    }

  }

  /// uploading expense report
  static Future uploadExpenseReport ({required String endDate, required String startDate, required String projectName, required List expenseList, required String currency, required String reportName, required String reportDescription}) async{
    var headers = {
      'token': tokens,
      'Content-Type': 'application/json'
    };
    var body = json.encode({
      "body": {
        "SiebelMessage": {
          "IntObjectFormat": "Siebel Hierarchical",
          "IntObjectName": "CUBNExpenseReportUpsert",
          "ListOfCUBNExpenseReportUpsert": {
            "CUBN Expense Report": {
              "End Date": endDate,
              "Expense Report Description": reportDescription,
              "Expense Report Name": reportName,
              "Currency Code": currency,
              "ListOfCUBNExpenses": {
                "CUBN Expenses": expenseList
              },
              "Project Name": projectName,
              "Start Date": startDate
            }
          },
          "MessageType": "Integration Object"
        }
      }
    });
    var response = await http.post(
      Uri.parse("$baseURL/expenseReport/upsertExpenseReport"),
      body: body,
      headers: headers,
    );

    if(response.statusCode == 200){
      var jsonData = jsonDecode(response.body);
      return jsonData;
    }
    else{
      throw Exception(response.statusCode);
    }

  }

  /// updating projectExpense
  static Future updateExpense({
  required String invoice,
    required String date,
    required String type,
    required String amount,
    required String description,
    required String Id,}) async{

    submitProjectExpenseController.showSpinner.value = true;
    var headers = {
      'token': tokens
    };
    var request = http.MultipartRequest('POST', Uri.parse('$baseURL/expenses/upsertExpense'));
    request.fields.addAll({
      'voucher': invoice,
      'voucherDate': date,
      'expenseType': type,
      'currency': 'INR',
      'amount': amount,
      'description': description,
      'Id': Id,
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      submitProjectExpenseController.showSpinner.value = false;
      print(await response.stream.bytesToString());
    }
    else {
      submitProjectExpenseController.showSpinner.value = false;
      print(response.reasonPhrase);
    }
  }
}