import 'dart:io';

import 'package:attendencesheet/apis/api_service.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class FileDownloadController extends GetxController{
  var filePath = "".obs;

  Future<void> getFilePath(String itemID, String fileName) async{
    var data = await ApiService.downloadAttachmentAPI(itemID, fileName);
    if(data != null){
      filePath.value = data;
    }
    else{
      print("Data coming to FileDownloadController is null");
    }
  }


  void downloadFile() async{
    var dio = Dio();
    Directory directory = await getApplicationDocumentsDirectory();
    print(directory.path);
    var response = await dio.download(
      filePath.value,
      "${directory.path}/attachment.pdf"
    );
    print(response.statusCode);
  }
}