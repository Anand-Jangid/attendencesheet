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

class EditExpenseScreen extends StatefulWidget {
  final AddExpenseModel addExpenseModel;

  EditExpenseScreen({Key? key, required this.addExpenseModel}) : super(key: key);

  @override
  State<EditExpenseScreen> createState() => _EditExpenseScreenState();
}

class _EditExpenseScreenState extends State<EditExpenseScreen> {

  late final amountController = TextEditingController(text: widget.addExpenseModel.projectAmount);
  late final invoiceController = TextEditingController(text: widget.addExpenseModel.projectInvoice);
  late final descriptionController = TextEditingController(text: widget.addExpenseModel.expenseDescription);
  late final dateController = TextEditingController(text: widget.addExpenseModel.date);
  late final typeController = SingleValueDropDownController(data: DropDownValueModel(name: widget.addExpenseModel.expenseType, value:  widget.addExpenseModel.expenseType));
  late final projectController = SingleValueDropDownController(data: DropDownValueModel(name: widget.addExpenseModel.projectName, value:  widget.addExpenseModel.projectName));
  late final imagePickerController = Get.put(ImagePickercontroller());
  bool loadingData = false;

  final submitProjectExpenseController = Get.put(SubmitProjectExpenseController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("ADD EXPENSE"),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: DropDownTextFielD(
              controller: projectController,
              dropDownList: const [
                DropDownValueModel(name: 'Web Dev', value: '7bz72xg15b50t2z'),
                DropDownValueModel(name: "Cubastion Consulting Private Limited", value: "mxbyyp9xqhazhwk"),
              ],
              hintText: "Select Project",
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
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
                // Get.defaultDialog(
                //     title: "Add Attachment",
                //     content: Column(
                //       children: [
                //         TextButton(
                //             onPressed: () {},
                //             child: const Text("Use Camera")),
                //         TextButton(
                //             onPressed: () async {
                //               await imagePickerController.getFiles();
                //               //imagePickerController.imagePicked.value = true;
                //               Get.back();
                //             },
                //             child: (loadingData)
                //                 ? const Center(
                //                 child: CircularProgressIndicator())
                //                 : const Text("Pick From Device")),
                //         TextButton(
                //             onPressed: () {
                //               Get.back();
                //             },
                //             child: const Text("Cancel")),
                //       ],
                //     ));
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

            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: widget.addExpenseModel.attachment.length,
                itemBuilder: (context, index){
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Flexible(
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
                              child: Text(widget.addExpenseModel.attachment[index]["name"],
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
                            await ApiService.updateExpense(
                                  invoice: invoiceController.text,
                                  date: dateController.text,
                                  type: typeController.dropDownValue!.value,
                                  amount: amountController.text,
                                  description: descriptionController.text,
                                  Id: widget.addExpenseModel.Id);
                            Get.back();
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