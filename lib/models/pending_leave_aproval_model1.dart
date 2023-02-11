// To parse this JSON data, do
//
//     final pendingLeaveApprovalModel1 = pendingLeaveApprovalModel1FromJson(jsonString);

import 'dart:convert';

List<PendingLeaveApprovalModel1> pendingLeaveApprovalModel1FromJson(String str) => List<PendingLeaveApprovalModel1>.from(json.decode(str).map((x) => PendingLeaveApprovalModel1.fromJson(x)));

String pendingLeaveApprovalModel1ToJson(List<PendingLeaveApprovalModel1> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PendingLeaveApprovalModel1 {
  PendingLeaveApprovalModel1({
    required this.approverFirstName,
    required this.approverId,
    required this.leaveDate,
    required this.financialYearId,
    required this.employeeFirstName,
    required this.comments,
    required this.employeeNumber,
    required this.type,
    required this.leaveType,
    required this.status,
    required this.id,
    this.employeeMidName,
    required this.approverLastName,
    required this.employeeLastName,
    required this.financialYear,
    required this.leaveCount,
    required this.approverNumber,
    required this.employeeId,
    this.approverMidName,
  });

  String approverFirstName;
  String approverId;
  DateTime leaveDate;
  String financialYearId;
  String employeeFirstName;
  String comments;
  String employeeNumber;
  String type;
  String leaveType;
  String status;
  String id;
  dynamic employeeMidName;
  String approverLastName;
  String employeeLastName;
  String financialYear;
  int leaveCount;
  String approverNumber;
  String employeeId;
  dynamic approverMidName;

  factory PendingLeaveApprovalModel1.fromJson(Map<String, dynamic> json) => PendingLeaveApprovalModel1(
    approverFirstName: json["Approver First Name"],
    approverId: json["Approver Id"],
    leaveDate: DateTime.parse(json["Leave Date"]),
    financialYearId: json["Financial Year Id"],
    employeeFirstName: json["Employee First Name"],
    comments: json["Comments"],
    employeeNumber: json["Employee Number"],
    type: json["Type"],
    leaveType: json["Leave Type"],
    status: json["Status"],
    id: json["Id"],
    employeeMidName: json["Employee Mid Name"],
    approverLastName: json["Approver Last Name"],
    employeeLastName: json["Employee Last Name"],
    financialYear: json["Financial Year"],
    leaveCount: json["Leave Count"],
    approverNumber: json["Approver Number"],
    employeeId: json["Employee Id"],
    approverMidName: json["Approver Mid Name"],
  );

  Map<String, dynamic> toJson() => {
    "Approver First Name": approverFirstName,
    "Approver Id": approverId,
    "Leave Date": "${leaveDate.year.toString().padLeft(4, '0')}-${leaveDate.month.toString().padLeft(2, '0')}-${leaveDate.day.toString().padLeft(2, '0')}",
    "Financial Year Id": financialYearId,
    "Employee First Name": employeeFirstName,
    "Comments": comments,
    "Employee Number": employeeNumber,
    "Type": type,
    "Leave Type": leaveType,
    "Status": status,
    "Id": id,
    "Employee Mid Name": employeeMidName,
    "Approver Last Name": approverLastName,
    "Employee Last Name": employeeLastName,
    "Financial Year": financialYear,
    "Leave Count": leaveCount,
    "Approver Number": approverNumber,
    "Employee Id": employeeId,
    "Approver Mid Name": approverMidName,
  };
}
