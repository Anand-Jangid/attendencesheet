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
import '../../../../models/add_expense_model.dart';
import '../../../../widgets/drop_down_textfield.dart';
import 'package:path/path.dart';

class AddExpenseScreen extends StatefulWidget {

  AddExpenseScreen({Key? key, }) : super(key: key);

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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                              print("0");
                              await imagePickerController.getFiles();
                              print("8");
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

            ///asset icon
            Obx(() {
              return (imagePickerController.filePathList.isNotEmpty)
                  ?
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: imagePickerController.filePathList.length,
                  itemBuilder: (context, index){
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          Stack(
                            children: [
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
                                    imagePickerController.filePathList.removeAt(index);
                                  },
                                  icon: const Icon(
                                    Icons.remove_circle,
                                    color: Colors.grey,
                                  ),
                                  iconSize: 20,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            width: 70,
                            child: Center(
                              child: Text(basename(imagePickerController.filePathList[index].path),
                                maxLines: 5,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
                  :
              Container();
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
                            if (imagePickerController.filePathList.isNotEmpty) {
                              await ApiService.uploadImage(
                                amount: amountController.text,
                                description: descriptionController.text,
                                expenseType: typeController.dropDownValue!.value.toString(),
                                filePaths: imagePickerController.filePathList.value,
                                projectId: projectController.dropDownValue!.value.toString(),
                                voucher : invoiceController.text,
                                voucherDate: dateController.text,
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
    );
  }
}