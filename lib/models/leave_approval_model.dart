// To parse this JSON data, do
//
//     final leaveApprovalModel = leaveApprovalModelFromJson(jsonString);

import 'dart:convert';

LeaveApprovalModel leaveApprovalModelFromJson(String str) => LeaveApprovalModel.fromJson(json.decode(str));

String leaveApprovalModelToJson(LeaveApprovalModel data) => json.encode(data.toJson());

class LeaveApprovalModel {
  LeaveApprovalModel({
    required this.siebelMessage,
  });

  SiebelMessage siebelMessage;

  factory LeaveApprovalModel.fromJson(Map<String, dynamic> json) => LeaveApprovalModel(
    siebelMessage: SiebelMessage.fromJson(json["SiebelMessage"]),
  );

  Map<String, dynamic> toJson() => {
    "SiebelMessage": siebelMessage.toJson(),
  };
}

class SiebelMessage {
  SiebelMessage({
    required this.intObjectFormat,
    required this.messageId,
    required this.intObjectName,
    required this.messageType,
    required this.cubnEmployeeLeaveApplyBc,
  });

  String intObjectFormat;
  String messageId;
  String intObjectName;
  String messageType;
  CubnEmployeeLeaveApplyBc cubnEmployeeLeaveApplyBc;

  factory SiebelMessage.fromJson(Map<String, dynamic> json) => SiebelMessage(
    intObjectFormat: json["IntObjectFormat"],
    messageId: json["MessageId"],
    intObjectName: json["IntObjectName"],
    messageType: json["MessageType"],
    cubnEmployeeLeaveApplyBc: CubnEmployeeLeaveApplyBc.fromJson(json["CUBN Employee Leave Apply BC"]),
  );

  Map<String, dynamic> toJson() => {
    "IntObjectFormat": intObjectFormat,
    "MessageId": messageId,
    "IntObjectName": intObjectName,
    "MessageType": messageType,
    "CUBN Employee Leave Apply BC": cubnEmployeeLeaveApplyBc.toJson(),
  };
}

class CubnEmployeeLeaveApplyBc {
  CubnEmployeeLeaveApplyBc({
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

  factory CubnEmployeeLeaveApplyBc.fromJson(Map<String, dynamic> json) => CubnEmployeeLeaveApplyBc(
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
