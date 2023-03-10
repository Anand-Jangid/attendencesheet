import 'package:attendencesheet/apis/api_service.dart';
import 'package:attendencesheet/controllers/file_download_controller.dart';
import 'package:attendencesheet/controllers/image_picker_controller.dart';
import 'package:attendencesheet/controllers/submit_project_expense_controller.dart';
import 'package:attendencesheet/widgets/text_field.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../constants.dart';
import '../../../../controllers/employee_expense_controller.dart';
import '../../../../controllers/query_employee_controller.dart';
import '../../../../models/add_expense_model.dart';
import '../../../../widgets/drop_down_textfield.dart';
import 'package:path/path.dart';

class EditExpenseScreen extends StatefulWidget {
  final AddExpenseModel addExpenseModel;

  EditExpenseScreen({Key? key, required this.addExpenseModel})
      : super(key: key);

  @override
  State<EditExpenseScreen> createState() => _EditExpenseScreenState();
}

class _EditExpenseScreenState extends State<EditExpenseScreen> {

  late final amountController = TextEditingController(
      text: widget.addExpenseModel.projectAmount);
  late final invoiceController = TextEditingController(
      text: widget.addExpenseModel.projectInvoice);
  late final descriptionController = TextEditingController(
      text: widget.addExpenseModel.expenseDescription);
  late final dateController = TextEditingController(
      text: widget.addExpenseModel.date);
  late final typeController = SingleValueDropDownController(
      data: DropDownValueModel(name: widget.addExpenseModel.expenseType,
          value: widget.addExpenseModel.expenseType));
  late final projectController = SingleValueDropDownController(
      data: DropDownValueModel(name: widget.addExpenseModel.projectName,
          value: widget.addExpenseModel.projectName));
  late final imagePickerController = Get.put(ImagePickercontroller());
  final QueryEmployeeController queryEmployeeController = Get.find();
  List<DropDownValueModel> dropDownListProjects = [];
  List<DropDownValueModel> dropDownListTypes = [];
  bool loadingData = false;
  final submitProjectExpenseController = Get.put(
      SubmitProjectExpenseController());
  final fileDownloadController = Get.put(FileDownloadController());
  double? _progress;
  Dio dio = Dio();
  final GlobalKey<FormState> _formkey=GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i < queryEmployeeController.projects.length; i++) {
      dropDownListProjects.add(DropDownValueModel(
          name: queryEmployeeController.projects[i]["Project Name"],
          value: queryEmployeeController.projects[i]["Project Id"])
      );
    }

    for (int i = 0; i < queryEmployeeController.expenseData.length; i++) {
      dropDownListTypes.add(DropDownValueModel(
          name: queryEmployeeController.expenseData[i],
          value: queryEmployeeController.expenseData[i])
      );
    }
  }

  void validateAndSave() {
    final FormState? form = _formkey.currentState;
    if (form!.validate()) {
      print('Form is valid');
    }
    else {
      print('Form is invalid');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          "ADD EXPENSE", style: TextStyle(color: Colors.black),),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropDownTextFielD(
                valText: "Please Select the Project",
                controller: projectController,
                dropDownList: dropDownListProjects,
                hintText: "Select Project",
              ),
            ),
          ),
        ),
        leading: const BackButton(
            color: Colors.black
        ),
      ),
      body: Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView(
                  children: [
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
                      valText: "Please Enter the Amount",
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
                      valText: "Please Enter the Invoice Number",
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
                      valText: "Plase Enter the Description",
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
                      valText: "Please Select the Expense Type",
                      controller: typeController,
                      dropDownList: dropDownListTypes,
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
                    Container(
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

                    ///asset icon

                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: widget.addExpenseModel.attachment.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Get.defaultDialog(
                                  title: "Do you want to download the attachment?",
                                  middleText: "",
                                  actions: [
                                    TextButton(onPressed: () async {
                                      await fileDownloadController.getFilePath("01Q6DRY62E7HIBVZEB4RFKT6OKEAVY5B2A", "sample-20-37-33.pdf");
                                      // const String fileName = "Attachment.pdf";
                                      // String path = await _getFilePath(fileName);
                                      FileDownloader.downloadFile(url: fileDownloadController.filePath.value,
                                        onProgress: (name, progress){
                                        setState(() {
                                          _progress = progress;
                                        });
                                        },
                                        onDownloadCompleted: (value){
                                        print("path $value");
                                        setState(() {
                                          _progress = null;
                                        });
                                        }
                                      );
                                      print(fileDownloadController.filePath.value);
                                      fileDownloadController.downloadFile();
                                      // FileDownloader.downloadFile(url: fileDownloadController.filePath.value,
                                      //     onProgress: (name, progress){
                                      //       setState(() {
                                      //         _progress = progress;
                                      //       });
                                      //     },
                                      //     onDownloadCompleted: (value){
                                      //       print('path $value');
                                      //       setState(() {
                                      //         _progress = null;
                                      //       });
                                      //     }
                                      // );
                                      // await dio.download(
                                      //     fileDownloadController.filePath.value,
                                      //     path,
                                      //   onReceiveProgress: (recivedBytes, totalBytes){
                                      //       setState(() {
                                      //         progress = recivedBytes/totalBytes;
                                      //       });
                                      //       print(progress);
                                      //   },
                                      //   deleteOnError: true,
                                      // ).then((value) => Get.back());
                                    }, child: (_progress != null)? CircularProgressIndicator() : const Text("Yes")),
                                    TextButton(onPressed: () => Get.back(),
                                        child: const Text("No")),
                                  ]
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0),
                              child: Column(
                                children: [
                                  Image.asset(
                                    "asset/images/gallary_image.png",
                                    height: 60,
                                    width: 60,
                                  ),
                                  SizedBox(
                                    width: 70,
                                    child: Center(
                                      child: Text(widget.addExpenseModel
                                          .attachment[index]["name"],
                                        maxLines: 5,
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
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
                              validateAndSave();
                              await ApiService.updateExpense(
                                  invoice: invoiceController.text,
                                  date: dateController.text,
                                  type: typeController.dropDownValue!.value,
                                  amount: amountController.text,
                                  description: descriptionController.text,
                                  Id: widget.addExpenseModel.Id);
                              Get.back();
                            },
                            child: (submitProjectExpenseController.showSpinner
                                .value)
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

  // Future<String> _getFilePath(String fileName) async{
  //   final dir  = await getApplicationDocumentsDirectory();
  //   return "${dir.path}/$fileName";
  // }

}