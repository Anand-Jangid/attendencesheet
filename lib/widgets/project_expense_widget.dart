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
    return GestureDetector(
      onTap: () {},
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Flexible(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Row(
                              children: [
                                Flexible(child: Text('INR $expenseAmount', style: Ktextstylecarddate6)),
                                const SizedBox(width: 15.0),
                                Flexible(
                                  child: Text(
                                    '$expenseType :$projectName',
                                    // softWrap: true,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w900),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Flexible(
                            child: Text(DateFormat('dd MMM yyyy').format(DateFormat('MM/dd/y').parse(expenseDate)),
                                style: Ktextstylecarddate6),
                          )
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(expenseDescription, style: Ktextstylecarddate5),
                          const Icon(Icons.keyboard_arrow_right, color: Colors.grey,)
                        ],
                      ),
                    ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
