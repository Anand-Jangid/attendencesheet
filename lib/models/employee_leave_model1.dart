import 'dart:convert';

EmployeeLeaveModel1 employeeLeaveModel1FromJson(String str) => EmployeeLeaveModel1.fromJson(json.decode(str));

String employeeLeaveModel1ToJson(EmployeeLeaveModel1 data) => json.encode(data.toJson());

class EmployeeLeaveModel1 {
  EmployeeLeaveModel1({
    required this.type,
    required this.approverMidName,
    required this.approverId,
    required this.leaveDate,
    required this.leaveCount,
    required this.id,
    required this.employeeFirstName,
    required this.employeeMidName,
    required this.comments,
    required this.employeeNumber,
    required this.leaveType,
    required this.status,
    required this.approverFirstName,
    required this.approverLastName,
    required this.financialYearId,
    required this.employeeLastName,
  });

  String type;
  String approverMidName;
  String approverId;
  DateTime leaveDate;
  String leaveCount;
  String id;
  String employeeFirstName;
  String employeeMidName;
  String comments;
  String employeeNumber;
  String leaveType;
  String status;
  String approverFirstName;
  String approverLastName;
  String financialYearId;
  String employeeLastName;

  factory EmployeeLeaveModel1.fromJson(Map<String, dynamic> json) => EmployeeLeaveModel1(
    type: json["Type"],
    approverMidName: json["Approver Mid Name"],
    approverId: json["Approver Id"],
    leaveDate: DateTime.parse(json["Leave Date"]),
    leaveCount: json["Leave Count"],
    id: json["Id"],
    employeeFirstName: json["Employee First Name"],
    employeeMidName: json["Employee Mid Name"],
    comments: json["Comments"],
    employeeNumber: json["Employee Number"],
    leaveType: json["Leave Type"],
    status: json["Status"],
    approverFirstName: json["Approver First Name"],
    approverLastName: json["Approver Last Name"],
    financialYearId: json["Financial Year Id"],
    employeeLastName: json["Employee Last Name"],
  );

  Map<String, dynamic> toJson() => {
    "Type": type,
    "Approver Mid Name": approverMidName,
    "Approver Id": approverId,
    "Leave Date": "${leaveDate.year.toString().padLeft(4, '0')}-${leaveDate.month.toString().padLeft(2, '0')}-${leaveDate.day.toString().padLeft(2, '0')}",
    "Leave Count": leaveCount,
    "Id": id,
    "Employee First Name": employeeFirstName,
    "Employee Mid Name": employeeMidName,
    "Comments": comments,
    "Employee Number": employeeNumber,
    "Leave Type": leaveType,
    "Status": status,
    "Approver First Name": approverFirstName,
    "Approver Last Name": approverLastName,
    "Financial Year Id": financialYearId,
    "Employee Last Name": employeeLastName,
  };
}
