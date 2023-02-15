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

  static final SubmitProjectExpenseController submitProjectExpenseController = Get.find();

  static var filePath = "";

  static void updatedList(List<PendingLeaveApprovalModel1> users){
    users.sort((a, b) => b.leaveDate.compareTo(a.leaveDate));
  }

  Future<UserModel> getData5(String description,String duration,String name,String date) async {
    var body1=json.encode({
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
        body: body1);
    var jsonResponse = jsonDecode(response.body);
    userModel = UserModel.fromJson(jsonResponse);
    return userModel;
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
      // employeeLeaveModel = EmployeeLeaveModel1(
      //     type: "Debit",
      //     approverMidName: "",
      //     approverId: "",
      //     leaveDate: DateTime.now(),
      //     leaveCount: "",
      //     id: "",
      //     employeeFirstName: "",
      //     employeeMidName: "",
      //     comments: "",
      //     employeeNumber: "",
      //     leaveType: "",
      //     status: "1234567890",
      //     approverFirstName: "",
      //     approverLastName: "",
      //     financialYearId: "",
      //     employeeLastName: ""
      // );
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
      print(response.statusCode);
      leaveApprovalModel = LeaveApprovalModel.fromJson(jsonResponse);
    }
    var jsonResponse = jsonDecode(response.body);
    print(response.statusCode);
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
      print(response.body);
      print(response.statusCode);
      throw Exception("Status code is not 200");
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
      print("Successfully ran");
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
  static Future getImage() async{
    final pickedFile1 = await FilePicker.platform.pickFiles();
    if(pickedFile1 != null){
      filePath = pickedFile1.paths.first!;
      print("---------------------- File has been selected -------------------------");
    }else{
      print("No image selected");
    }
  }

  //adding project expense
  static Future<void> uploadImage(String voucher, String voucherDate,String expenseType, String amount, String description, String projectId) async{
    //AddProjectExpenseModel? addProjectExpenseModel;
    submitProjectExpenseController.showSpinner.value = true;
    var headers = {
      'token': tokens
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://devxnet.cubastion.net/api/v1/expenses/upsertExpense'));
    request.fields.addAll({
      'voucher': voucher,
      'voucherDate': voucherDate,
      'expenseType': expenseType,
      'currency': 'INR',
      'amount': amount,
      'description': description,
      'projectId': projectId
    });
    request.files.add(await http.MultipartFile.fromPath('xnetFiles', filePath));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      submitProjectExpenseController.showSpinner.value = false;
      //addProjectExpenseModel = addProjectExpenseModelFromJson(await response.stream.bytesToString());
      print(await response.stream.bytesToString());
      print("image has been uploaded");
      // return addProjectExpenseModel;
    }
    else {
      submitProjectExpenseController.showSpinner.value = false;
      print(response.reasonPhrase);
      throw Exception("image is not uploaded");
    }

  }
}