import 'package:attendencesheet/apis/api_service.dart';
import 'package:attendencesheet/controllers/image_picker_controller.dart';
import 'package:attendencesheet/controllers/submit_project_expense_controller.dart';
import 'package:attendencesheet/widgets/text_field.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../constants.dart';
import '../../../../controllers/employee_expense_controller.dart';
import '../../../../widgets/drop_down_textfield.dart';

class AddExpenseScreen extends StatefulWidget {
  AddExpenseScreen({Key? key}) : super(key: key);

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final amountController = TextEditingController();
  final invoiceController = TextEditingController();
  final descriptionController = TextEditingController();
  final dateController = TextEditingController();
  final typeController = SingleValueDropDownController();
  final projectController = SingleValueDropDownController();
  final imagePickerController = Get.put(ImagePickercontroller());
  bool loadingData = false;

  final submitProjectExpenseController = Get.put(SubmitProjectExpenseController());

  // String filePath = "";
  //
  // void getPDFFile() async{
  //   final pickedFile1 = await FilePicker.platform.pickFiles();
  //   if(pickedFile1 != null){
  //     filePath = pickedFile1.paths.first!;
  //     Get.snackbar("Image Selected", "");
  //   }else{
  //     print("No image selected");
  //   }
  // }

  // showDialogOpt(BuildContext context) {
  //   return showDialog(
  //       context: context,
  //       builder: (context) => SimpleDialog(
  //             backgroundColor: Colors.white,
  //             children: [
  //               SimpleDialogOption(
  //                   onPressed: () async{
  //                     await imagePickerController.getFile();
  //                     imagePickerController.imagePicked.value = true;
  //                     Get.back();
  //                   },
  //                   child: Row(
  //                     children: const [
  //                       Icon(Icons.home_repair_service_rounded),
  //                       SizedBox(
  //                         width: 20,
  //                       ),
  //                       Text('Gallery')
  //                     ],
  //                   )),
  //               SimpleDialogOption(
  //                   onPressed: () {},
  //                   child: Row(
  //                     children: [
  //                       Icon(Icons.camera_alt),
  //                       SizedBox(
  //                         width: 20,
  //                       ),
  //                       Text('Camera')
  //                     ],
  //                   )),
  //               SimpleDialogOption(
  //                   onPressed: () => Get.back(),
  //                   child: Row(
  //                     children: [
  //                       Icon(Icons.close),
  //                       SizedBox(
  //                         width: 20,
  //                       ),
  //                       Text('Close')
  //                     ],
  //                   )),
  //             ],
  //           ));
  // }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: submitProjectExpenseController.showSpinner.value,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("ADD EXPENSE"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///Projects
              DropDownTextFielD(
                controller: projectController,
                dropDownList: const [
                  DropDownValueModel(name: 'Web Dev', value: '7bz72xg15b50t2z'),
                  DropDownValueModel(
                      name: "Cubastion Consulting Private Limited",
                      value: "mxbyyp9xqhazhwk"),
                ],
                hintText: "Select Project",
              ),
              const SizedBox(
                height: 10,
              ),

              ///Amount
              const Text(
                "AMOUNT",
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.w900),
              ),
              TextFielD(
                hintText: "Enter Amount",
                controller: amountController,
                textInputType: TextInputType.number,
              ),
              const SizedBox(
                height: 10,
              ),

              ///Invoice
              const Text(
                "INVOICE",
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.w900),
              ),
              TextFielD(
                hintText: "Enter Invoice",
                controller: invoiceController,
                textInputType: TextInputType.text,
              ),
              const SizedBox(
                height: 10,
              ),

              ///Description
              const Text(
                "DESCRIPTION",
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.w900),
              ),
              TextFielD(
                hintText: "Enter Description",
                controller: descriptionController,
                textInputType: TextInputType.text,
              ),
              const SizedBox(
                height: 10,
              ),

              ///Type
              const Text(
                "TYPE",
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.w900),
              ),
              DropDownTextFielD(
                controller: typeController,
                dropDownList: const [
                  DropDownValueModel(name: 'Food', value: 'Food'),
                  DropDownValueModel(name: 'Hotel', value: 'Hotel'),
                  DropDownValueModel(name: 'Internet', value: 'Internet'),
                  DropDownValueModel(name: 'Mobile', value: 'Mobile'),
                  DropDownValueModel(name: 'Office', value: 'Office'),
                  DropDownValueModel(name: 'Others', value: 'Others'),
                  DropDownValueModel(name: 'Travel', value: 'Travel'),
                ],
                hintText: "Select Type",
              ),
              const SizedBox(
                height: 10,
              ),

              ///date
              const Text(
                "DATE",
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.w900),
              ),
              //DateTextField(dateController: dateController),
              TextField(
                controller: dateController,
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100));
                  if (pickedDate != null) {
                    String formatteddate =
                        DateFormat('MM-dd-yyyy').format(pickedDate);
                    setState(() {
                      dateController.text = formatteddate;
                    });
                  }
                },
                decoration: InputDecoration(
                    hintText: 'Select Date',
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7))),
              ),
              const SizedBox(
                height: 10,
              ),

              ///Add attachment
              const Text(
                "ADD ATTACHMENT",
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.w900),
              ),
              InkWell(
                onTap: () {
                  Get.defaultDialog(
                      title: "Add Attachment",
                      content: Column(
                        children: [
                          TextButton(
                              onPressed: () {},
                              child: const Text("Use Camera")),
                          TextButton(
                              onPressed: () async {
                                // setState(() {
                                //   loadingData = true;
                                // });
                                // await ApiService.getFile();
                                // setState(() {
                                //   loadingData = false;
                                // });
                                await imagePickerController.getFile();
                                //getPDFFile();
                                imagePickerController.imagePicked.value = true;
                                Get.back();
                              },
                              child: (loadingData)
                                  ? const Center(
                                      child: CircularProgressIndicator())
                                  : const Text("Pick From Device")),
                          TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text("Cancel")),
                        ],
                      ));
                  // showDialogOpt(context);

                },
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Center(
                    child: Text(
                      "ADD ATTACHMENT",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
              ),
              Obx(() {
                return (imagePickerController.imagePicked.value)
                    ? Column(
                        children: [
                          Stack(
                            // alignment: Alignment.topRight,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Image.asset(
                                "asset/images/gallary_image.png",
                                height: 60,
                                width: 60,
                              ),
                              Positioned(
                                top: -15,
                                right: -15,
                                child: IconButton(
                                  onPressed: () {
                                    imagePickerController.imagePicked.value =
                                        false;
                                    imagePickerController.filePath.value = "";
                                  },
                                  icon: const Icon(
                                    Icons.remove_circle,
                                    color: Colors.grey,
                                  ), //Image.asset("asset/images/negative_image.png",),
                                  iconSize: 20,
                                ),
                              )
                            ],
                          )
                        ],
                      )
                    : Container();
              }),
              const Spacer(),
              Row(children: [
                ///Cancel
                Expanded(
                    flex: 4,
                    child: SizedBox(
                        height: 60,
                        child: GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: const Card(
                              color: Colors.grey,
                              child: Center(
                                  child: Text(
                                'Cancel',
                                style: Ktextstylecardbutton,
                              ))),
                        ))),

                ///submit
                Expanded(
                  flex: 6,
                  child: SizedBox(
                      height: 60,
                      child: Obx(() {
                        return GestureDetector(
                            onTap: () async {
                              if (imagePickerController.filePath.value != "") {
                                await ApiService.uploadImage(
                                  invoiceController.text,
                                  dateController.text,
                                  typeController.dropDownValue!.value.toString(),
                                  amountController.text,
                                  descriptionController.text,
                                  projectController.dropDownValue!.value.toString(),
                                  imagePickerController.filePath.value.toString(),
                                );
                                Get.back();
                              } else {
                                Get.snackbar("Unable to submit", "You cannot submit without an attachment");
                              }
                            },
                            child: (submitProjectExpenseController.showSpinner.value)
                                ? const Center(child: CircularProgressIndicator())
                                : const Card(
                                    color: Colors.orangeAccent,
                                    child: Center(
                                        child: Text(
                                      'SUBMIT',
                                      style: Ktextstylecardbutton,
                                    ))));
                      })),
                )
              ])
            ],
          ),
        ),
      ),
    );
  }
}