// To parse this JSON data, do
//
//     final addProjectExpenseModel = addProjectExpenseModelFromJson(jsonString);

import 'dart:convert';

AddProjectExpenseModel addProjectExpenseModelFromJson(String str) => AddProjectExpenseModel.fromJson(json.decode(str));

String addProjectExpenseModelToJson(AddProjectExpenseModel data) => json.encode(data.toJson());

class AddProjectExpenseModel {
  AddProjectExpenseModel({
    required this.siebelMessage,
  });

  SiebelMessage siebelMessage;

  factory AddProjectExpenseModel.fromJson(Map<String, dynamic> json) => AddProjectExpenseModel(
    siebelMessage: SiebelMessage.fromJson(json["SiebelMessage"]),
  );

  Map<String, dynamic> toJson() => {
    "SiebelMessage": siebelMessage.toJson(),
  };
}

class SiebelMessage {
  SiebelMessage({
    required this.cubnExpenses,
  });

  CubnExpenses cubnExpenses;

  factory SiebelMessage.fromJson(Map<String, dynamic> json) => SiebelMessage(
    cubnExpenses: CubnExpenses.fromJson(json["CUBN Expenses"]),
  );

  Map<String, dynamic> toJson() => {
    "CUBN Expenses": cubnExpenses.toJson(),
  };
}

class CubnExpenses {
  CubnExpenses({
    required this.id,
  });

  String id;

  factory CubnExpenses.fromJson(Map<String, dynamic> json) => CubnExpenses(
    id: json["Id"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
  };
}
