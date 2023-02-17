import 'package:attendencesheet/apis/api_service.dart';
import 'package:get/get.dart';

class ImagePickercontroller extends GetxController{

  var filePathList = [].obs;

  Future<void> getFiles() async{
    print("5");
    var listOfFiles = await ApiService.getFile();
    print("6");
    for(int i=0; i<listOfFiles.length; i++){
      filePathList.add(listOfFiles[i]);
    }
    print("7");
    print(filePathList);
  }

}