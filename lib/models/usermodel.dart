
class UserModel {
  UserModel({
    Body? body,}){
    _body = body;
  }

  UserModel.fromJson(dynamic json) {
    _body = json['body'] != null ? Body.fromJson(json['body']) : null;
  }
  Body? _body;
  UserModel copyWith({  Body? body,
  }) => UserModel(  body: body ?? _body,
  );
  Body? get body => _body;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_body != null) {
      map['body'] = _body?.toJson();
    }
    return map;
  }

}

/// SiebelMessage : {"IntObjectFormat":"Siebel Hierarchical","IntObjectName":"CUBNAttendance","ListOfCUBNAttendance":{"CUBN Attendance":{"Start Time":"09:31","End Time":"18:01","Attendance Date":"11/28/2022","ListOfCubnTimesheet":{"CUBN Timesheet":[{"Description":"abcdefg","Number of Hours":"9","Project Name":"Cubastion Consulting Private Limited"}]}}},"MessageType":"Integration Object"}

class Body {
  Body({
    SiebelMessage? siebelMessage,}){
    _siebelMessage = siebelMessage;
  }

  Body.fromJson(dynamic json) {
    _siebelMessage = json['SiebelMessage'] != null ? SiebelMessage.fromJson(json['SiebelMessage']) : null;
  }
  SiebelMessage? _siebelMessage;
  Body copyWith({  SiebelMessage? siebelMessage,
  }) => Body(  siebelMessage: siebelMessage ?? _siebelMessage,
  );
  SiebelMessage? get siebelMessage => _siebelMessage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_siebelMessage != null) {
      map['SiebelMessage'] = _siebelMessage?.toJson();
    }
    return map;
  }

}

/// IntObjectFormat : "Siebel Hierarchical"
/// IntObjectName : "CUBNAttendance"
/// ListOfCUBNAttendance : {"CUBN Attendance":{"Start Time":"09:31","End Time":"18:01","Attendance Date":"11/28/2022","ListOfCubnTimesheet":{"CUBN Timesheet":[{"Description":"abcdefg","Number of Hours":"9","Project Name":"Cubastion Consulting Private Limited"}]}}}
/// MessageType : "Integration Object"

class SiebelMessage {
  SiebelMessage({
    String? intObjectFormat,
    String? intObjectName,
    ListOfCubnAttendance? listOfCUBNAttendance,
    String? messageType,}){
    _intObjectFormat = intObjectFormat;
    _intObjectName = intObjectName;
    _listOfCUBNAttendance = listOfCUBNAttendance;
    _messageType = messageType;
  }

  SiebelMessage.fromJson(dynamic json) {
    _intObjectFormat = json['IntObjectFormat'];
    _intObjectName = json['IntObjectName'];
    _listOfCUBNAttendance = json['ListOfCUBNAttendance'];
    _messageType = json['MessageType'];
  }
  String? _intObjectFormat;
  String? _intObjectName;
  ListOfCubnAttendance? _listOfCUBNAttendance;
  String? _messageType;
  SiebelMessage copyWith({  String? intObjectFormat,
    String? intObjectName,
    ListOfCubnAttendance? listOfCUBNAttendance,
    String? messageType,
  }) => SiebelMessage(  intObjectFormat: intObjectFormat ?? _intObjectFormat,
    intObjectName: intObjectName ?? _intObjectName,
    listOfCUBNAttendance: listOfCUBNAttendance ?? _listOfCUBNAttendance,
    messageType: messageType ?? _messageType,
  );
  String? get intObjectFormat => _intObjectFormat;
  String? get intObjectName => _intObjectName;
  ListOfCubnAttendance? get listOfCUBNAttendance => _listOfCUBNAttendance;
  String? get messageType => _messageType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['IntObjectFormat'] = _intObjectFormat;
    map['IntObjectName'] = _intObjectName;
    map['ListOfCUBNAttendance'] = _listOfCUBNAttendance;
    map['MessageType'] = _messageType;
    return map;
  }

}

/// CUBN Attendance : {"Start Time":"09:31","End Time":"18:01","Attendance Date":"11/28/2022","ListOfCubnTimesheet":{"CUBN Timesheet":[{"Description":"abcdefg","Number of Hours":"9","Project Name":"Cubastion Consulting Private Limited"}]}}

class ListOfCubnAttendance {
  ListOfCubnAttendance({
    CubnAttendance? cUBNAttendance,}){
    _cUBNAttendance = cUBNAttendance;
  }

  ListOfCubnAttendance.fromJson(dynamic json) {
    _cUBNAttendance = json['CUBN Attendance'] != null ? CubnAttendance.fromJson(json['CUBN Attendance']) : null;
  }
  CubnAttendance? _cUBNAttendance;
  ListOfCubnAttendance copyWith({  CubnAttendance? cUBNAttendance,
  }) => ListOfCubnAttendance(  cUBNAttendance: cUBNAttendance ?? _cUBNAttendance,
  );
  CubnAttendance? get cUBNAttendance => _cUBNAttendance;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_cUBNAttendance != null) {
      map['CUBN Attendance'] = _cUBNAttendance?.toJson();
    }
    return map;
  }

}

/// Start Time : "09:31"
/// End Time : "18:01"
/// Attendance Date : "11/28/2022"
/// ListOfCubnTimesheet : {"CUBN Timesheet":[{"Description":"abcdefg","Number of Hours":"9","Project Name":"Cubastion Consulting Private Limited"}]}

class CubnAttendance {
  CubnAttendance({
    String? startTime,
    String? endTime,
    String? attendanceDate,
    ListOfCubnTimesheet? listOfCubnTimesheet,}){
    _startTime = startTime;
    _endTime = endTime;
    _attendanceDate = attendanceDate;
    _listOfCubnTimesheet = listOfCubnTimesheet;
  }

  CubnAttendance.fromJson(dynamic json) {
    _startTime = json['Start Time'];
    _endTime = json['End Time'];
    _attendanceDate = json['Attendance Date'];
    _listOfCubnTimesheet = json['ListOfCubnTimesheet'];
  }
  String? _startTime;
  String? _endTime;
  String? _attendanceDate;
  ListOfCubnTimesheet? _listOfCubnTimesheet;
  CubnAttendance copyWith({  String? startTime,
    String? endTime,
    String? attendanceDate,
    ListOfCubnTimesheet? listOfCubnTimesheet,
  }) => CubnAttendance(  startTime: startTime ?? _startTime,
    endTime: endTime ?? _endTime,
    attendanceDate: attendanceDate ?? _attendanceDate,
    listOfCubnTimesheet: listOfCubnTimesheet ?? _listOfCubnTimesheet,
  );
  String? get startTime => _startTime;
  String? get endTime => _endTime;
  String? get attendanceDate => _attendanceDate;
  ListOfCubnTimesheet? get listOfCubnTimesheet => _listOfCubnTimesheet;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Start Time'] = _startTime;
    map['End Time'] = _endTime;
    map['Attendance Date'] = _attendanceDate;
    map['ListOfCubnTimesheet'] = _listOfCubnTimesheet;
    return map;
  }

}

/// CUBN Timesheet : [{"Description":"abcdefg","Number of Hours":"9","Project Name":"Cubastion Consulting Private Limited"}]

class ListOfCubnTimesheet {
  ListOfCubnTimesheet({
    List<CubnTimesheet>? cUBNTimesheet,}){
    _cUBNTimesheet = cUBNTimesheet;
  }

  ListOfCubnTimesheet.fromJson(dynamic json) {
    if (json['CUBN Timesheet'] != null) {
      _cUBNTimesheet = [];
      json['CUBN Timesheet'].forEach((v) {
        _cUBNTimesheet?.add(CubnTimesheet.fromJson(v));
      });
    }
  }
  List<CubnTimesheet>? _cUBNTimesheet;
  ListOfCubnTimesheet copyWith({  List<CubnTimesheet>? cUBNTimesheet,
  }) => ListOfCubnTimesheet(  cUBNTimesheet: cUBNTimesheet ?? _cUBNTimesheet,
  );
  List<CubnTimesheet>? get cUBNTimesheet => _cUBNTimesheet;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_cUBNTimesheet != null) {
      map['CUBN Timesheet'] = _cUBNTimesheet?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// Description : "abcdefg"
/// Number of Hours : "9"
/// Project Name : "Cubastion Consulting Private Limited"

class CubnTimesheet {
  CubnTimesheet({
    String? description,
    String? numberofHours,
    String? projectName,}){
    _description = description;
    _numberofHours = numberofHours;
    _projectName = projectName;
  }

  CubnTimesheet.fromJson(dynamic json) {
    _description = json['Description'];
    _numberofHours = json['Number of Hours'];
    _projectName = json['Project Name'];
  }
  String? _description;
  String? _numberofHours;
  String? _projectName;
  CubnTimesheet copyWith({  String? description,
    String? numberofHours,
    String? projectName,
  }) => CubnTimesheet(  description: description ?? _description,
    numberofHours: numberofHours ?? _numberofHours,
    projectName: projectName ?? _projectName,
  );
  String? get description => _description;
  String? get numberofHours => _numberofHours;
  String? get projectName => _projectName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Description'] = _description;
    map['Number of Hours'] = _numberofHours;
    map['Project Name'] = _projectName;
    return map;
  }

}