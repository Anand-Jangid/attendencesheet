import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../constants.dart';

class PeojectExpenseWidget extends StatelessWidget {
  final String expenseAmount;
  final String expenseType;
  final String projectName;
  final String expenseDate;
  final String expenseDescription;

  const PeojectExpenseWidget({
    Key? key,
    required this.expenseAmount,
    required this.expenseType,
    required this.projectName,
    required this.expenseDate,
    required this.expenseDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(0.0),
      child: Row(
        children: [
          Expanded(
              child: Container(
            child: GestureDetector(
              onTap: () {},
              child: Flexible(
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(18.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Row(
                                  children: [
                                    Text(
                                        'INR $expenseAmount',
                                        style: Ktextstylecarddate6),
                                    SizedBox.fromSize(
                                      child: SizedBox(width: 15.0),
                                    ),
                                    Flexible(
                                      child: Text(
                                        '$expenseType :$projectName',
                                        softWrap: true,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w900),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Text(
                                  DateFormat('dd MMM yyyy').format(DateFormat('MM/dd/y').parse(expenseDate)),
                                  style: Ktextstylecarddate6)
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(expenseDescription,
                                  style: Ktextstylecarddate5),
                              Icon(
                                Icons.keyboard_arrow_right,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ]),
                  ),
                ),
              ),
            ),
          ))
        ],
      ),
    );
  }
}
