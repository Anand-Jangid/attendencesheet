import 'package:flutter/material.dart';

import '../constants.dart';

class ExpenseReportWidget extends StatelessWidget {
  final String expenseReportDescription;
  final String expenseAmount;
  final String projectName;
  final String status;
  const ExpenseReportWidget({
    Key? key,
    required this.expenseReportDescription,
    required this.expenseAmount,
    required this.projectName,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Expense for ${expenseReportDescription}",style: Ktextstylecarddate6),
                  Text("INR $expenseAmount", style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.w900),),
                ],
              ),
              const SizedBox(height: 5,),
              Text(projectName, style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w900),),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(status, style: const TextStyle(
                    fontStyle: FontStyle.italic
                  ),),
                  const Icon(Icons.arrow_forward_ios, size: 15,)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
