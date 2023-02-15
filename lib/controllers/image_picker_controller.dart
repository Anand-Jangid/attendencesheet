import 'package:attendencesheet/apis/api_service.dart';
import 'package:get/get.dart';

class ImagePickercontroller extends GetxController{
  var imagePicked = false.obs;
  var filePath = "".obs;

  Future<void> getFile() async{
    filePath.value = await ApiService.getFile();
  }
}