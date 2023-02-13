// import 'package:dropdown_textfield/dropdown_textfield.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import '../../../../apis/putdataapi.dart';
// import '../../../../constants.dart';
// import '../../../../controllers/reporting_manager_controller.dart';
// import '../../../../models/employee_leave_model1.dart';
//
// class CompoffScreen extends StatefulWidget {
//   @override
//   State<CompoffScreen> createState() => _CompoffScreenState();
// }
//
// class _CompoffScreenState extends State<CompoffScreen> {
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     ReportingManagerController reportingManagerController1 = Get.find();
//   }
//
//   TextEditingController dateController = TextEditingController();
//   TextEditingController description = TextEditingController();
//   final compoffcount = SingleValueDropDownController();
//   TextEditingController manager = TextEditingController(text: 'Akshay Kalia');
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: AppBar(
//         leading: const BackButton(
//           color: Colors.black,
//         ),
//         title: const Text('LEAVES EDIT', style: Ktextstyledaily),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: Form(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 9),
//                       child: Text(
//                         'Working Date',
//                         style: KtextstyleActivity,
//                       )),
//                   const SizedBox(height: 10),
//                   ///date calendar
//                   TextField(
//                     controller: dateController,
//                     readOnly: true,
//                     onTap: () async {
//                       DateTime? pickedDate = await showDatePicker(
//                           context: context,
//                           initialDate: DateTime.now(),
//                           firstDate: DateTime(2000),
//                           lastDate: DateTime(2100));
//                       if (pickedDate != null) {
//                         String formatteddate =
//                             DateFormat('yyyy-MM-dd').format(pickedDate);
//                         setState(() {
//                           dateController.text = formatteddate;
//                         });
//                       }
//                     },
//                     decoration: InputDecoration(
//                         hintText: 'Select Date',
//                         focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(7)),
//                         enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(7))),
//                   ),
//                   const SizedBox(height: 20),
//                   ///description
//                   const Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 9),
//                       child: Text(
//                         'DESCRIPTION',
//                         style: KtextstyleActivity,
//                       )),
//                   const SizedBox(height: 10),
//                   ///description textfield
//                   TextFormField(
//                     style: KtextstyleActivity1,
//                     controller: description,
//                     decoration: InputDecoration(
//                       hintText: 'Enter Description',
//                       hintStyle: KtextstyleActivity1,
//                       focusedBorder: const OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.grey)),
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10.0)),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   ///compoff count text
//                   const Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 9),
//                       child: Text(
//                         'COMP OFF COUNT',
//                         style: KtextstyleActivity,
//                       )),
//                   const SizedBox(height: 10),
//                   DropDownTextField(
//                     textFieldDecoration: InputDecoration(
//                         hintText: 'Select Days',
//                         hintStyle: KtextstyleActivity,
//                         enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.grey),
//                             borderRadius: BorderRadius.circular(10.0)),
//                         focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.grey),
//                             borderRadius: BorderRadius.circular(10.0))),
//                     controller: compoffcount,
//                     clearOption: true,
//                     dropdownRadius: 10.0,
//                     textStyle: KtextstyleActivity1,
//                     listTextStyle: KtextstyleActivity1,
//                     dropDownList: const [
//                       DropDownValueModel(name: '0.5', value: '0.5'),
//                       DropDownValueModel(name: '1', value: '1')
//                     ],
//                     onChanged: (val) {},
//                   ),
//                   const Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 9),
//                       child: Text(
//                         'APPROVING MANAGER',
//                         style: KtextstyleActivity,
//                       )),
//                   const SizedBox(height: 10),
//                   // TextFormField(
//                   //   style:KtextstyleActivity1,
//                   //   controller: manager,
//                   //   readOnly: true,
//                   //   decoration: InputDecoration(
//                   //     hintStyle: KtextstyleActivity1,
//                   //     focusedBorder: OutlineInputBorder(
//                   //         borderSide: BorderSide(color: Colors.grey)),
//                   //     border: OutlineInputBorder(
//                   //         borderRadius: BorderRadius.circular(10.0)),
//                   //   ),
//                   // ),
//                   Container(
//                       height: 60,
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         border: Border.all(color: Colors.black),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(10.0),
//                         child: Text("${reportingManagerController.reporintManagerLastName.value}",style: KtextstyleActivity1,),
//                       )),
//                 ],
//               ),
//               Row(children: [
//                 /// CANCEL
//                 Expanded(
//                     flex: 4,
//                     child: SizedBox(
//                         height: 60,
//                         child: GestureDetector(
//                           onTap: () {
//                             Get.back();
//                           },
//                           child: const Card(
//                               color: Colors.grey,
//                               child: Center(
//                                   child: Text(
//                                 'Cancel',
//                                 style: Ktextstylecardbutton,
//                               ))),
//                         ))),
//
//                 ///SUBMIT
//                 Expanded(
//                   flex: 6,
//                   child: SizedBox(
//                       height: 60,
//                       child: GestureDetector(
//                           onTap: () async {
//                             var typedDate = DateTime.parse(dateController.text.toString());
//                             var earlyDate = DateTime.now().subtract(const Duration(days: 3));
//                             if(typedDate.isAfter(DateTime.now())){
//                               Get.snackbar("Unable to apply comp off",
//                                   "You can't apply compOff 3 days after your working date or Future Date.");
//                             }
//                             else if(typedDate.isBefore(earlyDate)){
//                               Get.snackbar("Unable to apply comp off",
//                                   "You can't apply compOff 3 days after your working date or Future Date.");
//                             }
//                             else{
//                               EmployeeLeaveModel1 employeeLeaveModel = await ApiService.setCompOffData(dateController.text, compoffcount.dropDownValue!.value.toString(), description.text);
//                               if(employeeLeaveModel.status == "1234567890"){
//                                 Get.snackbar("Unable to apply Comp Off", "You have alredy applied for given date",
//                                   snackPosition: SnackPosition.TOP,
//                                 );
//                               }
//                               else{
//                                 Get.back();
//                               }
//                             }
//
//                           },
//                           child: const Card(
//                               color: Colors.orangeAccent,
//                               child: Center(
//                                   child: Text(
//                                 'SUBMIT',
//                                 style: Ktextstylecardbutton,
//                               ))))),
//                 )
//               ])
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
